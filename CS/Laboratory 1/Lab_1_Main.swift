//
//  Lab_1_Main.swift
//  CS
//
//  Created by Dragomir Mindrescu on 06.10.2024.
//

import Foundation
import Darwin

func Laboratory1() {
    
    // MARK: - Task 1.1
    let upperCaseAlphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    let lowerCaseAlphabet = "abcdefghijklmnopqrstuvwxyz"
    
    var key: String
    
    print("Choose one operation:")
    print("1.encryption   |   2.decryption")
    
    let keyPress = getKeyPress()
    
    if keyPress == "1" {
        print("\nenc")
    } else if keyPress == "2" {
        print("\ndec")
    } else {
        print("\nInvalid input. Please choose '1' or '2'.")
    }
    
    // MARK: - Task 1.2
    
}
