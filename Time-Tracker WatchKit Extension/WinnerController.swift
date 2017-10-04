//
//  WinnerController.swift
//  Time-Tracker
//
//  Created by Hani Tawil on 20/09/2017.
//  Copyright © 2017 Hani Tawil. All rights reserved.
//

import WatchKit
import Foundation


class WinnerController: WKInterfaceController {

    @IBOutlet var winnerLabel: WKInterfaceLabel!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        winnerLabel.setText(context as? String);
    }

    @IBAction func newTournament() {
        WKInterfaceController.reloadRootControllers(withNames: ["home"], contexts: []);
    }
}
