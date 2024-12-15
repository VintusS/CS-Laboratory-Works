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
            ScrollView {
                VStack {
                    TextField("Enter Ciphertext Here", text: $ciphertext)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button(action: analyzeFrequenciesAction) {
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
                        
                        let columns = [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ]
                        
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(frequencies.keys.sorted(), id: \.self) { letter in
                                VStack {
                                    Text(String(letter))
                                        .frame(width: 30, height: 30)
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(5)
                                    
                                    TextField("", text: Binding(
                                        get: { letterMapping[letter] != nil ? String(letterMapping[letter]!) : "" },
                                        set: { letterMapping[letter] = $0.first }
                                    ))
                                    .multilineTextAlignment(.center)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 50, height: 30)
                                    .onChange(of: letterMapping[letter]) { _ in
                                        updateDecryptedText()
                                    }
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
            }
            .navigationTitle("Frequency Analysis")
        }
    }
    
    private func analyzeFrequenciesAction() {
        frequencies = analyzeFrequencies(from: ciphertext)
        letterMapping = [:]
        decryptedText = ""
    }
    
    private func updateDecryptedText() {
        decryptedText = applyDecryption(to: ciphertext, with: letterMapping)
    }
}

struct FrequencyAnalysisView_Previews: PreviewProvider {
    static var previews: some View {
        FrequencyAnalysisView()
    }
}
