import UIKit
class SplashViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        perform(#selector(SplashViewController.showmainmenu), with: nil, afterDelay: 0.2)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @objc func showmainmenu(){
        performSegue(withIdentifier: "showmain", sender: self)
    }
}
