//
//  auxiliar.swift
//  CS
//
//  Created by Dragomir Mindrescu on 08.10.2024.
//

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
    return String(UnicodeScalar(UInt8(key)))
}
