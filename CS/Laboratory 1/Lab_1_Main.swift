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
    
    var flag: Bool = true
    var flag0: Bool = true
    
    print("Choose crypto mode:")
    print("1.easy   |   2.hard")
    
    while(flag) {
        
        let mode = getKeyPress()
        
        if mode == "1" {
            // MARK: - Task 1.1
            
            print("Choose one operation:")
            print("1.encryption   |   2.decryption")
            
            while(flag0) {
                let keyPress = getKeyPress()
                
                if keyPress == "1" {
                    Encryption()
                    flag0 = false
                } else if keyPress == "2" {
                    Decryption()
                    flag0 = false
                } else {
                    print("\nInvalid input. Please choose '1' or '2'.")
                }
            }
            
            flag = false
        } else if mode == "2" {
            // MARK: - Task 1.2
            //HARDMODE
            
            flag = false
        } else {
            print("\nInvalid input. Please choose '1' or '2'.")
        }
        
    }
    
}
