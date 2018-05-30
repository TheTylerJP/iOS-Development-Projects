import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var animalAge: UITextField!
    
    @IBOutlet weak var ageCalculationResult: UILabel!
    
    @IBOutlet weak var chooseAnimal: UISegmentedControl!
    
    @IBAction func goCalculation(_ sender: Any) {
        if(chooseAnimal.selectedSegmentIndex == 0) {
            var animalCalculatedAge = Int(animalAge.text!)!*7
            ageCalculationResult.text = String(animalCalculatedAge)
        } else if(chooseAnimal.selectedSegmentIndex == 1) {
            var animalCalculatedAge = Int(animalAge.text!)!*5
            ageCalculationResult.text = String(animalCalculatedAge)
        } else {
            var animalRandom = Int(arc4random_uniform(60))
            var animalCalculatedAge = Int(animalAge.text!)!*animalRandom
            ageCalculationResult.text = String(animalCalculatedAge)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
}
