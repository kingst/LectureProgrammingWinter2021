//
//  ViewController.swift
//  TimerApp
//
//  Created by Sam King on 1/12/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startStopButton: UIButton!
    let startStopTitles: (String, String) = ("Start", "Stop")
    @IBOutlet weak var lapLabel: UILabel!
    
    var lap = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lapLabel.text = nil
    }

    func toggleButtonTitle(between titles: (String, String), on button: UIButton) -> Void {
        let newTitle: String = button.currentTitle == titles.0 ? titles.1 : titles.0
        button.setTitle(newTitle, for: .normal)
    }
    
    // MARK: -UI action handlers
    @IBAction func startStopButtonPress() {
        toggleButtonTitle(between: startStopTitles, on: startStopButton)
    }
    
    @IBAction func lapButtonPress() {
        lap += 1
        lapLabel.text = "Current lap: \(lap)"
    }
    
    @IBAction func settingsButtonPress(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let settingsViewController = storyboard.instantiateViewController(withIdentifier: "settingsViewController") as? SettingsViewController else {
            assertionFailure("couldn't find vc")
            return
        }
        
        settingsViewController.someData = "This is my data"
        
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
}

