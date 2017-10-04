//
//  match.swift
//  Time-Tracker
//
//  Created by Hani Tawil on 16/09/2017.
//  Copyright © 2017 Hani Tawil. All rights reserved.
//

import Foundation

class Match {
    var playerOne: String;
    var playerTwo: String?
    var score = [[Int]]();
    var winner: String?;
    
    init(playerOne: String, playerTwo: String?) {
        self.playerOne = playerOne;
        self.playerTwo = playerTwo;
        if(playerTwo == nil) {
            winner = playerOne;
        }
    }
    
    func setWinner(player: Int) {
        (player == 1) ? (winner = playerOne) : (winner = playerTwo);
    }
}
