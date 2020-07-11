import UIKit
class OnboardingViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var schoolNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTextField.delegate = self
        self.schoolNameTextField.delegate = self
         self.view.addGestureRecognizer(UITapGestureRecognizer(target:self, action:#selector(self.handleTap(sender:))))
    }
    @objc func handleTap(sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        schoolNameTextField.resignFirstResponder()
    }
    func dismissKeyboard(){ 
        nameTextField.resignFirstResponder() 
        schoolNameTextField.resignFirstResponder() 
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func getstarted(_ sender: Any) {
        if nameTextField.text == "" || schoolNameTextField.text == "" {
            showAlert(error: "Please fill in all fields")
        }else {
            let defaults = UserDefaults.standard
            defaults.setValue(nameTextField.text, forKey: "coach_name")
            defaults.setValue(schoolNameTextField.text, forKey: "school_name")
            print("Get Started pressed")
            dismiss(animated: true, completion: nil)
        }
    }
    func showAlert(error : String) {
        let alertController = UIAlertController(title: "Error!", message:
            error, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
