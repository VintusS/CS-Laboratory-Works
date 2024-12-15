//
//  FrequencyAnalysisView.swift
//  Laboratory 2
//
//  Created by Dragomir Mindrescu on 15.12.2024.
//

import SwiftUI

struct FrequencyAnalysisView: View {
    @State private var ciphertext: String = ""
    @State private var frequencies: [Character: Double] = [:]
    @State private var letterMapping: [Character: Character] = [:]
    @State private var decryptedText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter Ciphertext Here", text: $ciphertext)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: analyzeFrequencies) {
                    Text("Analyze Frequencies")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                if !frequencies.isEmpty {
                    Text("Letter Frequencies")
                        .font(.headline)
                        .padding(.top)
                    
                    ScrollView(.horizontal) {
                        HStack(alignment: .bottom, spacing: 5) {
                            ForEach(frequencies.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                                VStack {
                                    Text(String(format: "%.2f", value * 100) + "%")
                                        .font(.caption)
                                    Rectangle()
                                        .fill(Color.blue)
                                        .frame(width: 20, height: CGFloat(value * 300))
                                    Text(String(key))
                                }
                            }
                        }
                        .padding()
                    }
                }
                
                VStack {
                    Text("Letter Mapping")
                        .font(.headline)
                        .padding(.top)
                    
                    ScrollView {
                        ForEach(frequencies.keys.sorted(), id: \.self) { letter in
                            HStack {
                                Text(String(letter))
                                    .frame(width: 30)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(5)
                                
                                TextField("Map to...", text: Binding(
                                    get: { String(letterMapping[letter] ?? "_") },
                                    set: { letterMapping[letter] = $0.first }
                                ))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 50)
                            }
                        }
                    }
                    .padding()
                }
                
                VStack(alignment: .leading) {
                    Text("Decrypted Text")
                        .font(.headline)
                        .padding(.top)
                    ScrollView {
                        Text(decryptedText.isEmpty ? "Decrypted text will appear here" : decryptedText)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                    }
                    .frame(maxHeight: 200)
                }
                
                Spacer()
            }
            .navigationTitle("Frequency Analysis")
        }
    }
    
    func analyzeFrequencies() {
        let totalCharacters = Double(ciphertext.filter { $0.isLetter }.count)
        frequencies = ciphertext.lowercased()
            .filter { $0.isLetter }
            .reduce(into: [:]) { counts, letter in counts[letter, default: 0] += 1 }
            .mapValues { count in Double(count) / totalCharacters }
        letterMapping = [:]
        decryptedText = ""
    }
}

struct FrequencyAnalysisView_Previews: PreviewProvider {
    static var previews: some View {
        FrequencyAnalysisView()
    }
}

