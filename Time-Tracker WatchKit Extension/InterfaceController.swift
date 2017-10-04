//
//  InterfaceController.swift
//  Time-Tracker WatchKit Extension
//
//  Created by Hani Tawil on 31/08/2017.
//  Copyright © 2017 Hani Tawil. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    @IBOutlet var playerNumberSlider: WKInterfaceSlider!
    @IBOutlet var displayNumber: WKInterfaceLabel!
    var numberOfCompetitors = 6;
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }

    @IBAction func sliderTapped(_ value: Float) {
        displayNumber.setText("\(Int(round(value)))");
        numberOfCompetitors = Int(value);
    }
    
    @IBAction func submitNumber() {
        pushController(withName: "competitors", context: numberOfCompetitors);
    }
}
