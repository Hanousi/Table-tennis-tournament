//
//  TournamentController.swift
//  Time-Tracker
//
//  Created by Hani Tawil on 07/09/2017.
//  Copyright © 2017 Hani Tawil. All rights reserved.
//

import WatchKit
import Foundation

class TournamentController: WKInterfaceController, WinnerDelegate {
    
    @IBOutlet var nextRoundButton: WKInterfaceButton!
    @IBOutlet var matches: WKInterfaceTable!
    var fixtures = [Match]();
    var tournament: Tournament?;
    var mapping: [Int:Int] = [:];
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        let numberOfPlayers = context as! Int;
        
        initMatches(numberOfPlayers: numberOfPlayers);
    }
    
    func updateMatches(numberOfMatches: Int) {
        mapping.removeAll();
        matches.setNumberOfRows(numberOfMatches, withRowType: "SelectWinner");
        var nextController = 0;
        for game in 0..<fixtures.count {
            if fixtures[game].playerTwo == nil {
                continue;
            } else {
                if let rowController = matches.rowController(at: nextController) as? SelectWinner {
                    rowController.delegateWinner = self;
                    rowController.position = nextController;
                    rowController.playerOne.setTitle(fixtures[game].playerOne);
                    rowController.playerTwo.setTitle(fixtures[game].playerTwo);
                    mapping[nextController] = game;
                    nextController += 1;
                }
            }
        }
        if (tournament?.isFinal)! {
            changeNextRoundButton();
        }
    }
    
    func initMatches(numberOfPlayers: Int) {
        tournament = Tournament(numberOfPlayers: numberOfPlayers);
        fixtures = (tournament?.currentRound)!;
        updateMatches(numberOfMatches: (tournament?.numberOfMatches())!);
    }
    
    func updateMatch(index: Int) {
        if fixtures[mapping[index]!].winner == fixtures[mapping[index]!].playerOne {
            if let rowController = matches.rowController(at: index) as? SelectWinner {
                rowController.playerOne.setBackgroundColor(UIColor.green);
                rowController.playerTwo.setBackgroundColor(UIColor.red);
            }
        } else if fixtures[mapping[index]!].winner == fixtures[mapping[index]!].playerTwo {
            if let rowController = matches.rowController(at: index) as? SelectWinner {
                rowController.playerTwo.setBackgroundColor(UIColor.green);
                rowController.playerOne.setBackgroundColor(UIColor.red);
            }
        }
    }
    
    @IBAction func nextRound() {
        var winners = [String]();
        for game in fixtures {
            if let winner = game.winner {
                winners.append(winner)
            }
        }
        print(winners);
        if(winners.count == fixtures.count) {
            if (tournament?.isFinal)! {
                pushController(withName: "winner", context: winners[0]);
            } else {
                fixtures = (tournament?.createNextRound())!;
                updateMatches(numberOfMatches: (tournament?.numberOfMatches())!);
            }
        } else {
            WKInterfaceDevice.current().play(.failure);
        }
        matches.scrollToRow(at: 0);
    }
    
    func changeNextRoundButton() {
        nextRoundButton.setTitle("Finish Tournament!");
    }
    
    func didTapPlayerOne(index: Int) {
        fixtures[mapping[index]!].setWinner(player: 1);
        updateMatch(index: index);
    }
    
    func didTapPlayerTwo(index: Int) {
        fixtures[mapping[index]!].setWinner(player: 2);
        updateMatch(index: index);
    }
}
