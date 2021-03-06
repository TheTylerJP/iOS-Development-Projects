//
//  ViewController.swift
//  ARKit IMS351
//
//  Created by Tommy Bojanin on 4/16/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//


import UIKit
import SceneKit
import ARKit
import Vision
import Foundation


public var materialIndex : Int = 0

class ViewController: UIViewController, ARSCNViewDelegate {
    
    
    var spinner: UIActivityIndicatorView?
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var messagePanel: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak public var materialPicker: UISegmentedControl!

    
    var screenCenter: CGPoint?
    var trackingFallbackTimer: Timer?
    
    
    var dragOnInfinitePlanesEnabled = false
    var virtualObjectManager: VirtualObjectManager!
    
    var textManager: TextManager!
    //var restartExperienceButtonIsEnabled = true
    
    @IBOutlet weak var drawButton: UIButton!
    
    @IBAction func drawAction() {
        drawButton.isSelected = !drawButton.isSelected
        inDrawMode = drawButton.isSelected
        in3DMode = false
    }
    
    @IBOutlet weak var threeDMagicButton: UIButton!
    @IBAction func threeDMagicAction(_ button: UIButton) {
        threeDMagicButton.isSelected = !threeDMagicButton.isSelected
        in3DMode = threeDMagicButton.isSelected
        inDrawMode = false
        
        trackImageInitialOrigin = nil
    }
    
    static let serialQueue = DispatchQueue(label: "Dispatch Queue")
    let serialQueue: DispatchQueue = ViewController.serialQueue
    
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUIControls()
        setupScene()
        setupSegmentedControl()
        
        print("Tommy, fix your signing certificates! ==Tyler **Located in viewController.swift**")
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setupSegmentedControl() {
        materialPicker.backgroundColor = .clear
        materialPicker.tintColor = .clear
        
        materialPicker.setTitleTextAttributes([
            NSAttributedStringKey.font : UIFont(name: "DINCondensed-Bold", size: 18),
            NSAttributedStringKey.foregroundColor: UIColor.lightGray
            ], for: .normal)
        
        materialPicker.setTitleTextAttributes([
            NSAttributedStringKey.font : UIFont(name: "DINCondensed-Bold", size: 18),
            NSAttributedStringKey.foregroundColor: UIColor.black
            ], for: .selected)
    }
    
    @IBAction func segmentIndex(_ sender: Any) {
        
        switch(materialPicker.selectedSegmentIndex){
        case 0 : materialIndex = 0
        case 1 : materialIndex = 1
        case 2 : materialIndex = 2
        case 3 : materialIndex = 3
        case 4 : materialIndex = 4
            
        default:
            materialIndex = 0
            
        }
        restartExperience()
        
    }
    
    
    
    //INITIALIZING AR-SESSION
    let session = ARSession()
    
    let standardConfiguration: ARWorldTrackingConfiguration = {
        let configuration = ARWorldTrackingConfiguration()
        if #available(iOS 11.3, *) {
            configuration.planeDetection = [.horizontal, .vertical]
        } else {
            configuration.planeDetection = .horizontal
        }
        return configuration
    }()
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Prevent the screen from being dimmed after a while.
        UIApplication.shared.isIdleTimerDisabled = true
        
        if ARWorldTrackingConfiguration.isSupported {
            resetTracking()
        } else {
            let sessionErrorMsg = "This app requires devices later than the iPhone 6s."
            displayErrorMessage(title: "Unsupported Device", message: sessionErrorMsg, allowRestart: false)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        session.pause()
    }
    
    func setupScene() {
        virtualObjectManager = VirtualObjectManager()
        
        // set up scene view
        sceneView.setup()
        sceneView.delegate = self
        sceneView.session = session
        
        //UNCOMMENT to show statistics (Frames per second, memory usages, etc)
        //sceneView.showsStatistics = true
        
        sceneView.scene.enableEnvironmentMapWithIntensity(25, queue: serialQueue)
        
        setupFocusSquare()
        
        DispatchQueue.main.async {
            self.screenCenter = self.sceneView.bounds.mid
        }
    }
    
    func setupUIControls() {
        textManager = TextManager(viewController: self)
        messagePanel.layer.cornerRadius = 3.0
        messagePanel.clipsToBounds = true
        messagePanel.isHidden = true
        messageLabel.text = ""
    }
    
    
    //Drawer
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        updateFocusSquare()
        
        
        if let lightEstimate = self.session.currentFrame?.lightEstimate {
            self.sceneView.scene.enableEnvironmentMapWithIntensity(lightEstimate.ambientIntensity / 40, queue: serialQueue)
        } else {
            self.sceneView.scene.enableEnvironmentMapWithIntensity(40, queue: serialQueue)
        }
        
        
        // dot
        if (self.virtualPenTip == nil) {
            self.virtualPenTip = PointNode(color: UIColor.red)
            self.sceneView.scene.rootNode.addChildNode(self.virtualPenTip!)
        }
        
        
        guard let pixelBuffer = self.sceneView.session.currentFrame?.capturedImage,
            let observation = self.lastObservation else {
                return
        }
        let request = VNTrackObjectRequest(detectedObjectObservation: observation) { [unowned self] request, error in
            self.handle(request, error: error)
        }
        //Make a option that does both
        request.trackingLevel = .accurate
        do {
            try self.handler.perform([request], on: pixelBuffer)
        }
        catch {
            print(error)
        }
        
        // Draw
        if let lastFingerWorldPos = self.lastFingerWorldPos {
            
            // Update virtual pen position
            self.virtualPenTip?.isHidden = false
            self.virtualPenTip?.simdPosition = lastFingerWorldPos
            
            // Draw new point
            if (self.inDrawMode && !self.virtualObjectManager.pointNodeExistAt(pos: lastFingerWorldPos)){
                let newPoint = PointNode()
                self.sceneView.scene.rootNode.addChildNode(newPoint)
                self.virtualObjectManager.loadVirtualObject(newPoint, to: lastFingerWorldPos)
            }
            
            // Convert drawing to 3D
            if (self.in3DMode ) {
                if self.trackImageInitialOrigin != nil {
                    DispatchQueue.main.async {                                                        
                        let newH = 0.4 *  (self.trackImageInitialOrigin!.y - self.trackImageBoundingBox!.origin.y) / self.sceneView.frame.height
                        self.virtualObjectManager.setNewHeight(newHeight: newH)
                    }
                }
                else {
                    self.trackImageInitialOrigin = self.trackImageBoundingBox?.origin
                }
            }
            
        }
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let planeAnchor = anchor as? ARPlaneAnchor {
            serialQueue.async {
                self.addPlane(node: node, anchor: planeAnchor)
                self.virtualObjectManager.checkIfObjectShouldMoveOntoPlane(anchor: planeAnchor, planeAnchorNode: node)
            }
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if let planeAnchor = anchor as? ARPlaneAnchor {
            serialQueue.async {
                self.updatePlane(anchor: planeAnchor)
                self.virtualObjectManager.checkIfObjectShouldMoveOntoPlane(anchor: planeAnchor, planeAnchorNode: node)
            }
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        if let planeAnchor = anchor as? ARPlaneAnchor {
            serialQueue.async {
                self.removePlane(anchor: planeAnchor)
            }
        }
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        textManager.showTrackingQualityInfo(for: camera.trackingState, autoHide: true)
        
        switch camera.trackingState {
        case .notAvailable:
            fallthrough
        case .limited:
            textManager.escalateFeedback(for: camera.trackingState, inSeconds: 3.0)
        case .normal:
            textManager.cancelScheduledMessage(forType: .trackingStateEscalation)
        }
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        
        guard let arError = error as? ARError else { return }
        
        let nsError = error as NSError
        var sessionErrorMsg = "\(nsError.localizedDescription) \(nsError.localizedFailureReason ?? "")"
        if let recoveryOptions = nsError.localizedRecoveryOptions {
            for option in recoveryOptions {
                sessionErrorMsg.append("\(option).")
            }
        }
        
        let isRecoverable = (arError.code == .worldTrackingFailed)
        if isRecoverable {
            sessionErrorMsg += "\nYou can try resetting the session or quit the application."
        } else {
            sessionErrorMsg += "\nThis is an unrecoverable error that requires to quit the application."
        }
        
        displayErrorMessage(title: "We're sorry!", message: sessionErrorMsg, allowRestart: isRecoverable)
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        textManager.blurBackground()
        textManager.showAlert(title: "Session Interrupted", message: "The session will be reset after the interruption has ended.")
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        textManager.unblurBackground()
        session.run(standardConfiguration, options: [.resetTracking, .removeExistingAnchors])
        self.restartExperience()
        textManager.showMessage("RESETTING SESSION")
    }
    
    // MARK: - Planes
    
    var planes = [ARPlaneAnchor: Plane]()
    
    func addPlane(node: SCNNode, anchor: ARPlaneAnchor) {
        
        let plane = Plane(anchor)
        planes[anchor] = plane
        node.addChildNode(plane)
        
        textManager.cancelScheduledMessage(forType: .planeEstimation)
        textManager.showMessage("SURFACE DETECTED")
        if virtualObjectManager.pointNodes.isEmpty {
            textManager.scheduleMessage("TAP + TO PLACE AN OBJECT", inSeconds: 7.5, messageType: .contentPlacement)
        }
    }
    
    func updatePlane(anchor: ARPlaneAnchor) {
        if let plane = planes[anchor] {
            plane.update(anchor)
        }
    }
    
    func removePlane(anchor: ARPlaneAnchor) {
        if let plane = planes.removeValue(forKey: anchor) {
            plane.removeFromParentNode()
        }
    }
    
    func resetTracking() {
        session.run(standardConfiguration, options: [.resetTracking, .removeExistingAnchors])
        
        textManager.scheduleMessage("FIND A SURFACE TO PLACE AN OBJECT",
                                    inSeconds: 7.5,
                                    messageType: .planeEstimation)
        
        trackImageInitialOrigin = nil
        inDrawMode = false
        in3DMode = false
        lastFingerWorldPos = nil
        drawButton.isSelected = false
        threeDMagicButton.isSelected = false
        self.virtualPenTip?.isHidden = true
        
    }
    
    // MARK: - Focus Square
    
    var focusSquare: FocusSquare?
    
    func setupFocusSquare() {
        serialQueue.async {
            self.focusSquare?.isHidden = true
            self.focusSquare?.removeFromParentNode()
            self.focusSquare = FocusSquare()
            self.sceneView.scene.rootNode.addChildNode(self.focusSquare!)
        }
        
        textManager.scheduleMessage("TRY MOVING LEFT OR RIGHT", inSeconds: 5.0, messageType: .focusSquare)
    }
    
    func updateFocusSquare() {
        guard let screenCenter = screenCenter else { return }
        
        DispatchQueue.main.async {
            if self.virtualObjectManager.pointNodes.count > 0 {
                self.focusSquare?.hide()
            } else {
                self.focusSquare?.unhide()
            }
            
            let (worldPos, planeAnchor, _) = self.virtualObjectManager.worldPositionFromScreenPosition(screenCenter,
                                                                                                       in: self.sceneView,
                                                                                                       objectPos: self.focusSquare?.simdPosition)
            if let worldPos = worldPos {
                self.serialQueue.async {
                    self.focusSquare?.update(for: worldPos, planeAnchor: planeAnchor, camera: self.session.currentFrame?.camera)
                }
                self.textManager.cancelScheduledMessage(forType: .focusSquare)
            }
        }
    }
    
    // MARK: - Error handling
    
    func displayErrorMessage(title: String, message: String, allowRestart: Bool = false) {
        // Blur the background.
        textManager.blurBackground()
        
        if allowRestart {
            // Present an alert informing about the error that has occurred.
            let restartAction = UIAlertAction(title: "Reset", style: .default) { _ in
                self.textManager.unblurBackground()
                self.restartExperience()
            }
            textManager.showAlert(title: title, message: message, actions: [restartAction])
        } else {
            textManager.showAlert(title: title, message: message, actions: [])
        }
    }
    
    // MARK: - ARPaint methods
    
    var inDrawMode = false
    var in3DMode = false
    var lastFingerWorldPos: float3?
    
    var virtualPenTip: PointNode?
    
    
    // MARK: Object tracking
    
    private let handler = VNSequenceRequestHandler()
    fileprivate var lastObservation: VNDetectedObjectObservation?
    var trackImageBoundingBox: CGRect?
    var trackImageInitialOrigin: CGPoint?
    let trackImageSize = CGFloat(20)
    
    @objc private func tapAction(recognizer: UITapGestureRecognizer) {
        
        lastObservation = nil
        let tapLocation = recognizer.location(in: view)
        
        // Set up the rect in the image in view coordinate space that we will track
        let trackImageBoundingBoxOrigin = CGPoint(x: tapLocation.x - trackImageSize / 2, y: tapLocation.y - trackImageSize / 2)
        trackImageBoundingBox = CGRect(origin: trackImageBoundingBoxOrigin, size: CGSize(width: trackImageSize, height: trackImageSize))
        
        let t = CGAffineTransform(scaleX: 1.0 / self.view.frame.size.width, y: 1.0 / self.view.frame.size.height)
        let normalizedTrackImageBoundingBox = trackImageBoundingBox!.applying(t)
        
        // Transfrom the rect from view space to image space
        guard let fromViewToCameraImageTransform = self.sceneView.session.currentFrame?.displayTransform(for: UIInterfaceOrientation.portrait, viewportSize: self.sceneView.frame.size).inverted() else {
            return
        }
        var trackImageBoundingBoxInImage =  normalizedTrackImageBoundingBox.applying(fromViewToCameraImageTransform)
        trackImageBoundingBoxInImage.origin.y = 1 - trackImageBoundingBoxInImage.origin.y
        // Image space uses bottom left as origin while view space uses top left
        
        lastObservation = VNDetectedObjectObservation(boundingBox: trackImageBoundingBoxInImage)
        
    }
    
    fileprivate func handle(_ request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            guard let newObservation = request.results?.first as? VNDetectedObjectObservation else {
                return
            }
            self.lastObservation = newObservation
            
            // check the confidence level before updating the UI
            guard newObservation.confidence >= 0.3 else {
                // hide the pen when we lose accuracy so the user knows something is wrong
                self.virtualPenTip?.isHidden = true
                self.lastObservation = nil
                return
            }
            
            var trackImageBoundingBoxInImage = newObservation.boundingBox
            
            // Transfrom the rect from image space to view space
            trackImageBoundingBoxInImage.origin.y = 1 - trackImageBoundingBoxInImage.origin.y
            guard let fromCameraImageToViewTransform = self.sceneView.session.currentFrame?.displayTransform(for: UIInterfaceOrientation.portrait, viewportSize: self.sceneView.frame.size) else {
                return
            }
            let normalizedTrackImageBoundingBox = trackImageBoundingBoxInImage.applying(fromCameraImageToViewTransform)
            let t = CGAffineTransform(scaleX: self.view.frame.size.width, y: self.view.frame.size.height)
            let unnormalizedTrackImageBoundingBox = normalizedTrackImageBoundingBox.applying(t)
            self.trackImageBoundingBox = unnormalizedTrackImageBoundingBox
            
            // Get the projection if the location of the tracked image from image space to the nearest detected plane
            if let trackImageOrigin = self.trackImageBoundingBox?.origin {
                (self.lastFingerWorldPos, _, _) = self.virtualObjectManager.worldPositionFromScreenPosition(CGPoint(x: trackImageOrigin.x - 20.0, y: trackImageOrigin.y + 40.0), in: self.sceneView, objectPos: nil, infinitePlane: false)
            }
            
        }
    }
}


