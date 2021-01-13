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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func toggleButtonTitle(between titles: (String, String), on button: UIButton) -> Void {
        let newTitle: String = button.currentTitle == titles.0 ? titles.1 : titles.0
        button.setTitle(newTitle, for: .normal)
    }
    
    @IBAction func startStopButtonPress() {
        toggleButtonTitle(between: startStopTitles, on: startStopButton)
    }
    
}

