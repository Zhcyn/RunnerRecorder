import UIKit
import AVFoundation
class TimerViewController: UIViewController, UIApplicationDelegate {
    var seconds = 32
    var timer = Timer()
    let systemSoundID: SystemSoundID = 1023
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var startbutton: UIButton!
    @IBOutlet weak var stopbutton: UIButton!
    var isOn = false;
    @IBAction func slider(_ sender: UISlider) {
        print("Slider Moved")
        seconds = Int(sender.value)
        timeLeftLabel.text = "\(seconds) s"
    }
    @IBAction func start(_ sender: Any) {
        print("Start button pressed")
        if isOn == false {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerViewController.counter), userInfo: nil, repeats: true)
            isOn = true;
        }
    }
    @objc func counter() {
        seconds -= 1
        timeLeftLabel.text = "\(seconds) s"
        if seconds == 0 {
            AudioServicesPlaySystemSound (systemSoundID)
            timer.invalidate()
        }
    }
    @IBAction func stop(_ sender: Any) {
        print("Stopped")
        timer.invalidate()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        startbutton.layer.cornerRadius = min(100, 100) / 2.0
        stopbutton.layer.cornerRadius = min(100, 100) / 2.0
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func applicationWillTerminate(_ application: UIApplication) {
        print("terminated")
        timer.invalidate()
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("About to Enter Foreground")
    }
}
