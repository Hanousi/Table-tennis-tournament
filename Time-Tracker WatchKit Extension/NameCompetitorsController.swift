//
//  NameCompetitorsController.swift
//  Time-Tracker
//
//  Created by Hani Tawil on 03/09/2017.
//  Copyright © 2017 Hani Tawil. All rights reserved.
//

import WatchKit
import Foundation


class NameCompetitorsController: WKInterfaceController {

    @IBOutlet var table: WKInterfaceTable!
    var numberOfRows: Int!;
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        numberOfRows = (context as! Int);
        table.setNumberOfRows(context as! Int, withRowType: "EnterCompetitorsName");
        updateTable();
    }
    
    func updateTable() {
        for index in 0..<(numberOfRows) {
            if let rowController = table.rowController(at: index) as? EnterCompetitorsName {
                rowController.competitorId.setText("#" + String(index + 1));
                rowController.competitorName.setText((UserDefaults.standard.value(forKey: "player" + String(index)) ?? "Enter Name") as? String);
            }
        }
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        presentTextInputController(withSuggestions: ["Hani", "Johannes", "Nikolai", "Filip", "Martin", "Toby", "Alex", "James"], allowedInputMode: .plain) { (result) in
            if let choice = result?[0] as? String {
                UserDefaults.standard.set(choice, forKey: "player" + String(rowIndex));
                UserDefaults.standard.synchronize();
                self.updateTable();
            }
        }
    }

    @IBAction func startTournament() {
        var passed = true;
        
        for index in 0..<(numberOfRows) {
            if (UserDefaults.standard.value(forKey: "player" + String(index)) == nil) {
                passed = false;
            }
        }
        
        if passed {
            WKInterfaceController.reloadRootControllers(withNames: ["tournament"], contexts: [numberOfRows]);
        } else {
            WKInterfaceDevice.current().play(.failure);
        }
    }
}


















