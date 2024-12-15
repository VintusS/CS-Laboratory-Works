//
//  AuxiliarFunctions.swift
//  Laboratory 2
//
//  Created by Dragomir Mindrescu on 15.12.2024.
//

import Foundation

func analyzeFrequencies(from text: String) -> [Character: Double] {
    let totalCharacters = Double(text.filter { $0.isLetter }.count)
    return text.lowercased()
        .filter { $0.isLetter }
        .reduce(into: [:]) { counts, letter in counts[letter, default: 0] += 1 }
        .mapValues { count in Double(count) / totalCharacters }
}

func applyDecryption(to text: String, with mapping: [Character: Character]) -> String {
    return String(text.map { char in
        if let mappedChar = mapping[char.lowercased().first ?? char] {
            return char.isUppercase ? Character(mappedChar.uppercased()) : mappedChar
        } else {
            return char
        }
    })
}
