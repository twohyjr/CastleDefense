import Cocoa

class SettingsViewController: NSViewController {
    //Color Wheels
    @IBOutlet weak var sldClearColor: NSColorWell!

    override func viewDidLoad() {
        super.viewDidLoad()

        //sldClearColor.color = NSColor.init(red: CGFloat(Preferences.clearColor.red), green: CGFloat(Preferences.clearColor.green), blue: CGFloat(Preferences.clearColor.blue), alpha: CGFloat(Preferences.clearColor.alpha))
    
    }
    
    @IBAction func sldClearColor_Changed(_ sender: NSColorWell) {
        Preferences.updateClearColor(color: sender.color)
    }

}
