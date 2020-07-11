import UIKit
class NewAthleteFormViewController: UIViewController, UITextFieldDelegate {
    let ATH_KEY = "athletes_array"
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var gradeTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.autocorrectionType = .no
        self.nameTextField.delegate = self
        self.bioTextField.delegate = self
        self.gradeTextField.delegate = self
        self.phoneTextField.delegate = self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NewAthleteFormViewController.dismissKeyboard)))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @objc func dismissKeyboard(){ 
        nameTextField.resignFirstResponder() 
        bioTextField.resignFirstResponder() 
        gradeTextField.resignFirstResponder() 
        phoneTextField.resignFirstResponder() 
    }
    @IBAction func submit(_ sender: Any) {
        print("Pressed Submit")
        let defaults = UserDefaults.standard
        var tempAthletes = [Athlete]()
        let newName : String? = nameTextField.text
        var newBio : String? = bioTextField.text
        let newGrade : Int? = Int(gradeTextField.text!)
        var newPhone : Int? = Int(phoneTextField.text!)
        var new_id = 0
        if nameTextField.text != "" && gradeTextField.text != "" {
            if (newBio == nil) {
                newBio = ""
            }
            if newPhone == nil {
                newPhone = 0
            }
            if let data = defaults.data(forKey: ATH_KEY), let myAthletes = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Athlete] {
                if myAthletes != [] {
                    new_id = (myAthletes.last?.id)! + 1
                    tempAthletes = myAthletes
                }
            }
            let newAthlete = Athlete(name : newName!, grade : newGrade!, id : new_id, phone : newPhone!, bio : newBio!)
            if tempAthletes.count == 0 {
                tempAthletes = [newAthlete]
                let encoded = NSKeyedArchiver.archivedData(withRootObject: tempAthletes)
                defaults.set(encoded, forKey: ATH_KEY)
            }else {
                tempAthletes.append(newAthlete)
                defaults.removeObject(forKey: ATH_KEY)
                let encoded = NSKeyedArchiver.archivedData(withRootObject: tempAthletes)
                defaults.set(encoded, forKey: ATH_KEY)
            }
            dismiss(animated: true, completion: nil)
        }else {
            sendAlert(error: "Please fill in the required fields!")
        }
    }
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func sendAlert(error : String) {
        print("Alert Sent")
        let alertController = UIAlertController(title: "Error!", message:
            error, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
