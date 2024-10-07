//
//  auxiliar.swift
//  CS
//
//  Created by Dragomir Mindrescu on 08.10.2024.
//

import Foundation
import Darwin

// Single press key input
func getKeyPress() -> String {
    var oldt = termios()
    tcgetattr(STDIN_FILENO, &oldt)
    var newt = oldt
    newt.c_lflag &= ~UInt(ICANON | ECHO)
    tcsetattr(STDIN_FILENO, TCSANOW, &newt)
    
    let key = getchar()
    
    tcsetattr(STDIN_FILENO, TCSANOW, &oldt)
    
    print()
    
    return String(UnicodeScalar(UInt8(key)))
}

// Message validation of the input
func isValidMessage(_ message: String) -> Bool {
    let allowedCharacters = CharacterSet.letters.union(.whitespaces)
    return message.unicodeScalars.allSatisfy { allowedCharacters.contains($0) }
}
