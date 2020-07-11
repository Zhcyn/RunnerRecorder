import UIKit
class StopwatchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var isRunning : Bool = false
    let LAPS_KEY = "laps_array"
    let CURRENT_SW_KEY = "current_stop_watch"
    @IBOutlet weak var startstopbutton: UIButton!
    @IBOutlet weak var lapreset: UIButton!
    var laps : [String] = []
    var stopwatchstring : String = ""
    var startStopWatch: Bool = true
    var timer = Timer()
    var minutes = 0
    var seconds = 0
    var fraction = 0
    var addLap = false
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var timeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.delegate = self
        self.table.dataSource = self
        stopwatchstring = "00:00:00"
        timeLabel.text = stopwatchstring
        table.reloadData()
        UserDefaults.standard.setValue(laps, forKey: LAPS_KEY)
        UserDefaults.standard.setValue(stopwatchstring, forKey: CURRENT_SW_KEY)
        startstopbutton.layer.cornerRadius = min(100, 100) / 2.0
        lapreset.layer.cornerRadius = min(100, 100) / 2.0
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lapcell") as! LapTableViewCell
        cell.lapnumber.text = String(laps.count - indexPath.row)
        cell.duration.text = laps[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    @IBAction func startstop(_ sender: Any) {
        print("Start/Stop")
        if startStopWatch == true {
            if isRunning == false {
                isRunning = true
                timer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(StopwatchViewController.updateTime), userInfo: nil, repeats: true)
                startStopWatch = false
                startstopbutton.setTitle("Stop", for: .normal)
                lapreset.setTitle("Lap", for: .normal)
                addLap = true
            }
        }else { 
            if isRunning == true {
                isRunning = false
                timer.invalidate()
                startStopWatch = true
                startstopbutton.setTitle("Start", for: .normal)
                lapreset.setTitle("Reset", for: .normal)
                addLap = false
            }
        }
    }
    @IBAction func lapreset(_ sender: Any) {
        print("Lap/Reset")
        if addLap == true {
            laps.insert(stopwatchstring, at: 0)
            UserDefaults.standard.setValue(laps, forKey: LAPS_KEY)
            table.reloadData()
        }else {
            addLap = false
            lapreset.setTitle("Lap", for: .normal)
            fraction = 0
            seconds = 0
            minutes = 0
            stopwatchstring = "00:00:00"
            laps.removeAll()
            table.reloadData()
            timeLabel.text = stopwatchstring
        }
    }
    @objc func updateTime() {
        fraction += 1
        if fraction == 100 {
            seconds += 1
            fraction = 0
        }
        if seconds == 60 {
            minutes += 1
            seconds = 0
        }
        let fractionsString = fraction > 9 ? "\(fraction)" : "0\(fraction)"
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        let totalString = "\(minutesString):\(secondsString):\(fractionsString)"
        stopwatchstring = totalString
        timeLabel.text = stopwatchstring
        UserDefaults.standard.setValue(stopwatchstring, forKey: CURRENT_SW_KEY)
    }
}
