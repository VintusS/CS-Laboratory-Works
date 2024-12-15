# Laboratory Report: Frequency Analysis and Decryption

## Task Description
Build a small app that takes in some ciphertext and applies frequency analysis to decipher and find the original text. The original text is in English.

---

## Implementation

### Step 1: Analyze Frequencies
To start, we initialize the frequencies of English letters. This includes single letters as well as combinations of 2, 3, and 4 letters (e.g., digrams, trigrams). We then analyze the ciphertext to compute the frequencies of these combinations.

#### Code Example for Frequency Analysis in Swift
The following function calculates letter frequencies and supports combinations of up to 4 letters:

```swift
import Foundation

func getWordPartsFrequencies(text: String, nrOfLetters: Int, maxParts: Int? = nil) -> [String: (count: Int, frequency: Double)] {
    guard !text.isEmpty else {
        fatalError("No text provided")
    }
    guard nrOfLetters > 0 else {
        fatalError("Number of letters must be greater than zero")
    }

    let words = text.components(separatedBy: " ")
    let wordParts = words.flatMap { word in
        (0...(word.count - nrOfLetters)).compactMap { index in
            let startIndex = word.index(word.startIndex, offsetBy: index)
            let endIndex = word.index(startIndex, offsetBy: nrOfLetters, limitedBy: word.endIndex)
            return endIndex != nil ? String(word[startIndex..<endIndex!]).uppercased() : nil
        }
    }

    let totalParts = wordParts.count
    var wordPartCounts = Dictionary(wordParts.map { ($0, 1) }, uniquingKeysWith: +)

    if let maxParts = maxParts {
        wordPartCounts = wordPartCounts.sorted(by: { $0.value > $1.value })
                                       .prefix(maxParts)
                                       .reduce(into: [String: Int]()) { $0[$1.key] = $1.value }
    }

    return wordPartCounts.mapValues { count in
        (count: count, frequency: round((Double(count) / Double(totalParts)) * 10000) / 100.0)
    }
}
```

### Step 2: Replace the Most Frequent Letter with E
In English, the letter E is the most frequently used. We begin the decryption process by identifying the most frequent letter in the ciphertext and replacing it with E.

![Most Used Character Change](Assets/Screenshot1.png)


### Conclusion
This project successfully decrypts ciphertext using frequency analysis in Swift. The approach combines programmatic letter frequency analysis with manual replacement steps, leveraging known English patterns and statistical probabilities.





