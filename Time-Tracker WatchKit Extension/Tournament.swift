//
//  Tournament.swift
//  Time-Tracker
//
//  Created by Hani Tawil on 17/09/2017.
//  Copyright © 2017 Hani Tawil. All rights reserved.
//

import Foundation

class Tournament {
    var currentRound = [Match]();
    var isFinal = false;

    init(numberOfPlayers: Int) {
        var mapping = [Match]();
        var randomHelper = [Int](0..<numberOfPlayers);
        
        while !randomHelper.isEmpty {
            if randomHelper.count == 1 {
                mapping.append(Match(playerOne: (UserDefaults.standard.value(forKey: "player" + String(randomHelper.remove(at: Int(0))))) as! String, playerTwo: nil));
            } else {
                let firstPlayer = UserDefaults.standard.value(forKey: "player" + String(randomHelper.remove(at: Int(arc4random_uniform(UInt32(randomHelper.count))))));
                let secondPlayer = UserDefaults.standard.value(forKey: "player" + String(randomHelper.remove(at: Int(arc4random_uniform(UInt32(randomHelper.count))))));
                mapping.append(Match(playerOne: firstPlayer as! String, playerTwo: secondPlayer as? String));
            }
        }
        if mapping.count == 1 {
            isFinal = true;
        }
        currentRound = mapping;
    }
    
    func createNextRound() -> [Match]{
        var nextRound = [Match]();
        if(currentRound.count != 2) {
            let rightBranch = Int(ceil(Double(currentRound.count)/Double(2)))
            for winner in stride(from: 0, to: rightBranch, by: 2) {
                if(winner == (rightBranch) - 1) {
                    nextRound.append(Match(playerOne: currentRound[winner].winner!, playerTwo: nil));
                } else {
                    nextRound.append(Match(playerOne: currentRound[winner].winner!, playerTwo: currentRound[winner+1].winner));
                }
            }
            for winner in stride(from: currentRound.count - 1, through: rightBranch, by: -2) {
                if(winner == rightBranch) {
                    nextRound.append(Match(playerOne: currentRound[winner].winner!, playerTwo: nil));
                } else {
                    nextRound.append(Match(playerOne: currentRound[winner].winner!, playerTwo: currentRound[winner-1].winner));
                }
            }
        } else {
            nextRound.append(Match(playerOne: currentRound[0].winner!, playerTwo: currentRound[1].winner));
        }
        if nextRound.count == 1 {
            isFinal = true;
        }
        currentRound = nextRound;
        return nextRound;
    }
    
    func numberOfMatches() -> Int {
        var counter = 0;
        currentRound.forEach { (match) in
            if(match.playerTwo != nil) {
                counter += 1;
            }
        }
        return counter;
    }
}
