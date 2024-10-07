//
//  Lab_1_Main.swift
//  CS
//
//  Created by Dragomir Mindrescu on 06.10.2024.
//

import Foundation
import Darwin

// MARK: - Laboratory 1 Global Variables
let upperCaseAlphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
let lowerCaseAlphabet = "abcdefghijklmnopqrstuvwxyz"

func Laboratory1() {
    
    // MARK: - Task 1.1
    var flag: Bool = true
    
    print("Choose one operation:")
    print("1.encryption   |   2.decryption")
    
    while(flag) {
        let keyPress = getKeyPress()
        
        if keyPress == "1" {
            Encryption()
            flag = false
        } else if keyPress == "2" {
            print("\ndec")
            flag = false
        } else {
            print("\nInvalid input. Please choose '1' or '2'.")
        }
    }
    
    // MARK: - Task 1.2
    
}
