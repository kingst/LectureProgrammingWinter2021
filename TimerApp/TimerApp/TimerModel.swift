//
//  TimerModel.swift
//  TimerApp
//
//  Created by Sam King on 1/28/21.
//

import Foundation

protocol TimerModelUpdates: class {
    func lapsDidChange(_ laps: [TimeInterval])
    func currentTimeDidChange(_ currentTime: TimeInterval)
}

class TimerModel {
    var startTime: Date?
    var lastLap: Date?
    var laps: [TimeInterval] = []
    weak var delegate: TimerModelUpdates?
    
    func addLap() {
        guard let lastLapStart = lastLap ?? startTime else {
            return
        }
        
        // be careful about time intervals and the absolute time
        let now = Date()
        let lap = -lastLapStart.timeIntervalSince(now)
        lastLap = now
        
        laps.append(lap)
        delegate?.lapsDidChange(laps)
    }
    
    func timerNeedsUpdating() {
        guard let startTime = startTime else {
            assertionFailure("start time not set")
            return
        }
        
        let currentTime = -startTime.timeIntervalSinceNow
        delegate?.currentTimeDidChange(currentTime)
    }
    
    func start() {
        startTime = Date()
        let timer = Timer(timeInterval: 0.1, repeats: true) { _ in
            self.timerNeedsUpdating()
        }
        
        RunLoop.main.add(timer, forMode: .default)
    }
    
    func stop() {
        print("stop")
    }
}
