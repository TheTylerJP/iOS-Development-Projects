//
//  ViewController.swift
//  Kitchen Calculator
//
//  Created by Tommy Bojanin on 3/8/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//

import UIKit
import BarcodeScanner

class ViewController: UIViewController {

    var barcode:String?
    @IBOutlet weak var barcodeScannerButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func pushScannerButton(_ sender: Any) {
        let scanner = BarcodeScannerViewController()
        scanner.dismissalDelegate = self
        scanner.codeDelegate = self
        scanner.errorDelegate = self
        scanner.title = "Scan Barcode"
        present(scanner, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Home"
        
        //barcode Button styling
        barcodeScannerButton.layer.borderColor = UIColor.black.cgColor
        barcodeScannerButton.layer.borderWidth = 2.0
        barcodeScannerButton.layer.cornerRadius = 4.0
        
        
        //title label styling
        titleLabel.layer.borderColor = UIColor.black.cgColor
        titleLabel.layer.borderWidth = 2.0
        titleLabel.layer.cornerRadius = 4.0
        
        

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //print("segue was called")
        if segue.identifier == "toInformationPage" {
            let destination = segue.destination as? InformationPageViewController

            destination?.barcode = self.barcode
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    private func makeBarcodeScannerViewController() -> BarcodeScannerViewController {
        let viewController = BarcodeScannerViewController()
        viewController.codeDelegate = self
        viewController.errorDelegate = self
        viewController.dismissalDelegate = self
        return viewController
    }

}

extension ViewController: BarcodeScannerCodeDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        print("Barcode Data: \(code)")
        print("Symbology Type: \(type)")
        self.barcode = code
        controller.dismiss(animated: true) {
            self.performSegue(withIdentifier: "toInformationPage", sender: nil)
        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//            controller.resetWithError()
//        }
    }
    
}

// MARK: - BarcodeScannerErrorDelegate

extension ViewController: BarcodeScannerErrorDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        print(error)
    }
}

// MARK: - BarcodeScannerDismissalDelegate

extension ViewController: BarcodeScannerDismissalDelegate {
    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
