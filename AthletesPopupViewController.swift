import UIKit
import MessageUI
class AthletesPopupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMessageComposeViewControllerDelegate {
    let ATH_KEY = "athletes_array"
    let LAPS_KEY = "laps_array"
    let CURRENT_SW_KEY = "current_stop_watch"
    var athletes = [Athlete]()
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.delegate = self
        self.table.dataSource = self
        table.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: ATH_KEY), let myAthletes = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Athlete] {
            athletes = myAthletes
        }
        return athletes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "popupAthleteCell") as! PopupAthleteTableViewCell
        cell.name.text = (athletes[indexPath.row].name).capitalized
        cell.grade.text = String(athletes[indexPath.row].grade)
        cell.runnerImageView.image = UIImage(named: "runner")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sendtext(number: athletes[indexPath.row].phone)
    }
    func sendtext(number : Int) {
        print("Tapped the Send Text button")
        let messageVC = MFMessageComposeViewController()
        let laps_array : [String] = UserDefaults.standard.value(forKey: LAPS_KEY) as! [String]
        var laps_string = ""
        for i in 0..<laps_array.count {
            laps_string += "Lap \(i + 1): \(laps_array[laps_array.count-i-1])\n"
        }
        let sw_string = "Final Time: \(UserDefaults.standard.value(forKey: CURRENT_SW_KEY) as! String)"
        messageVC.body = "\(sw_string)\n\(laps_string)";
        print("\(sw_string)\n\(laps_string)")
        messageVC.recipients = [String(number)]
        messageVC.messageComposeDelegate = self;
        if MFMessageComposeViewController.canSendText() {
            present(messageVC, animated: false, completion: nil)
        }else {
            print("this device can't send texts!")
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
