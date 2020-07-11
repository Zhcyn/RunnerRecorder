import UIKit
class InfoViewController: UIViewController {
    @IBOutlet weak var versionLabel: UILabel!
    let appVersionString: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    override func viewDidLoad() {
        super.viewDidLoad()
        versionLabel.text = "v\(appVersionString)"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
