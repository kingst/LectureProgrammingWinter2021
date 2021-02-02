//
//  ViewController.swift
//  TimerApp
//
//  Created by Sam King on 1/12/21.
//

import UIKit

class ViewController: UIViewController, TimerModelUpdates, UITableViewDataSource {

    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var lapLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var lapsTableView: UITableView!
    
    let startStopTitles: (String, String) = ("Start", "Stop")
    let timerModel = TimerModel()
    var currentLaps: [TimeInterval] = []
    var fastestLapIndex = 0
    var slowestLapIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lapLabel.text = nil
        timerModel.delegate = self
        lapsTableView.dataSource = self
        
        lapLabel.text = "Current lap: 1"
    }

    func toggleButtonTitle(between titles: (String, String), on button: UIButton) -> Void {
        let newTitle: String = button.currentTitle == titles.0 ? titles.1 : titles.0
        button.setTitle(newTitle, for: .normal)
    }
    
    // MARK: -UI action handlers
    @IBAction func startStopButtonPress() {
        if startStopButton.title(for: .normal) == "Start" {
            timerModel.start()
        }
        toggleButtonTitle(between: startStopTitles, on: startStopButton)
    }
    
    @IBAction func lapButtonPress() {
        timerModel.addLap()
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
    
    // MARK: -TimerModelUpdates protocol implementation
    func lapsDidChange(_ laps: [TimeInterval]) {
        currentLaps = laps.reversed()
        
        var fastestTime = Double.greatestFiniteMagnitude
        var slowestTime = 0.0
        
        for (index, lap) in currentLaps.enumerated() {
            if lap < fastestTime {
                fastestLapIndex = index
                fastestTime = lap
            }
            
            if lap > slowestTime {
                slowestLapIndex = index
                slowestTime = lap
            }
        }
        
        let lapNumber = currentLaps.count + 1
        lapLabel.text = "Current lap: \(lapNumber)"
        lapsTableView.reloadData()
    }
    
    func currentTimeDidChange(_ currentTime: TimeInterval) {
        let timeInSeconds = Int(currentTime)
        let seconds = timeInSeconds % 60
        let minutes = (timeInSeconds / 60) % 60
        let hours = timeInSeconds / (60 * 60)
        
        currentTimeLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    // MARK: -UITableViewDataSource implementation
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        assert(section == 0)
        return currentLaps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lapCell") ?? UITableViewCell(style: .default, reuseIdentifier: "lapCell")
        
        assert(indexPath.section == 0)
        let lapNumber = currentLaps.count - indexPath.row
        let lap = String(format: "%0.1f", currentLaps[indexPath.row])
        
        cell.textLabel?.text = "Lap \(lapNumber): \(lap)"
        cell.imageView?.image = UIImage(systemName: "stopwatch")
        
        switch indexPath.row {
        case fastestLapIndex:
            cell.imageView?.tintColor = .green
        case slowestLapIndex:
            cell.imageView?.tintColor = .red
        default:
            cell.imageView?.tintColor = .lightGray
        }
 
        return cell
    }
}

