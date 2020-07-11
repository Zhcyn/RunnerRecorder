import UIKit
import MessageUI
class AthleteDetailViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var schoolLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var bioTextField: UITextView!
    @IBOutlet weak var phoneLabel: UILabel!
    var sentName : String = ""
    var sentGrade : Int = 0
    var sentBio : String = ""
    var sentPhone : Int = 0
    var sentId : Int = 0
    override func viewWillAppear(_ animated: Bool) {
        nameLabel.text = sentName
        schoolLabel.text = (UserDefaults.standard.value(forKey: "school_name") as! String?)?.capitalized
        gradeLabel.text = String(sentGrade)
        bioTextField.text = sentBio
        phoneLabel.text = "#: \(sentPhone)"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"new-message"), style: .plain, target: self, action: #selector(AthleteDetailViewController.sendtext))
        }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @objc func sendtext() {
        print("Tapped the Send Text button")
        let messageVC = MFMessageComposeViewController()
        messageVC.body = "Hello!";
        messageVC.recipients = [String(sentPhone)]
        messageVC.messageComposeDelegate = self;
        if MFMessageComposeViewController.canSendText() {
            present(messageVC, animated: false, completion: nil)
        }
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result) {
        case MessageComposeResult.cancelled:
            print("Message was cancelled")
            self.dismiss(animated: true, completion: nil)
        case MessageComposeResult.failed:
            print("Message failed to send")
            self.dismiss(animated: true, completion: nil)
        case MessageComposeResult.sent:
            print("Message was sent")
            self.dismiss(animated: true, completion: nil)
        }
    }
}
