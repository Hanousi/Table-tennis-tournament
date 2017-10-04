//
//  SelectWinner.swift
//  Time-Tracker
//
//  Created by Hani Tawil on 13/09/2017.
//  Copyright © 2017 Hani Tawil. All rights reserved.
//

import WatchKit

protocol WinnerDelegate: class {
    func didTapPlayerOne(index: Int);
    func didTapPlayerTwo(index: Int);
}

class SelectWinner: NSObject {
    
    var delegateWinner:WinnerDelegate?;
    var position: Int?
    
    @IBOutlet var playerOne: WKInterfaceButton!
    @IBOutlet var playerTwo: WKInterfaceButton!
    
    @IBAction func tapPlayerOne() {
        delegateWinner?.didTapPlayerOne(index: position!);
    }
    
    @IBAction func tapPlayerTwo() {
        delegateWinner?.didTapPlayerTwo(index: position!);
    }
}
