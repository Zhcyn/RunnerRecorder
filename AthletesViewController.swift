import UIKit
import AddressBook
class AthletesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var ATH_KEY = "athletes_array"
    let defaults = UserDefaults.standard
    var athletes = [Athlete]()
    @IBOutlet weak var table: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        if let data = defaults.data(forKey: ATH_KEY), let myAthletes = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Athlete] {
            athletes = myAthletes
        }
        table.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.delegate = self
        self.table.dataSource = self
        table.reloadData()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.barTintColor =  #colorLiteral(red: 0.1568627451, green: 0.8039215686, blue: 0.2549019608, alpha: 1)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return athletes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AthleteTableViewCell
        cell.name.text = (athletes[indexPath.row].name).capitalized
        cell.grade.text = String(athletes[indexPath.row].grade)
        cell.runnerImageView.image = UIImage(named: "runner")
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            athletes.remove(at: indexPath.row)
            var tempAthletes : [Athlete] = []
            if let data = defaults.data(forKey: ATH_KEY), let myAthletes = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Athlete] {
                tempAthletes = myAthletes
            }
            tempAthletes.remove(at: indexPath.row)
            defaults.removeObject(forKey: ATH_KEY)
            let encoded = NSKeyedArchiver.archivedData(withRootObject: tempAthletes)
            defaults.set(encoded, forKey: ATH_KEY)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAthleteDetail",
            let destination = segue.destination as? AthleteDetailViewController,
            let detailIndex = table.indexPathForSelectedRow?.row
        {
            if let data = defaults.data(forKey: ATH_KEY), let myAthletes = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Athlete] {
                athletes = myAthletes
            }
            destination.sentName = self.athletes[detailIndex].name
            destination.sentId = self.athletes[detailIndex].id
            destination.sentBio = self.athletes[detailIndex].bio
            destination.sentPhone = self.athletes[detailIndex].phone
            destination.sentGrade = self.athletes[detailIndex].grade
        }
    }
}
