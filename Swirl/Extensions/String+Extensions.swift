//
//  String+Extensions.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/13/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import Foundation

private struct Constants {
    static let numbers = "0123456789"
    static let numbersLength = 4
    static let animals = [ // 20 animals in alphabetical order.
        "alpaca", "beaver", "cheetah", "chicken", "elephant",
        "fox", "goose", "grizzly", "hawk", "hedgehog",
        "jaguar", "kitten", "mole", "moose", "panther",
        "porcupine", "raccoon", "squirrel", "walrus", "wolf"
    ]
}

extension String {
    var removingWhitespaces: String {
        return components(separatedBy: .whitespacesAndNewlines).joined()
    }

    static var randomAnimalUnique: String {
        let animalsCount = UInt32(Constants.animals.count)
        let randomIndex = Int(arc4random_uniform(animalsCount))
        let randomAnimal = Constants.animals[randomIndex]
        let randomNumbers = String.randomNumbers(length: Constants.numbersLength)
        let uniqueAnimal = randomAnimal.appending(randomNumbers)
        return uniqueAnimal
    }

    static func randomNumbers(length: Int) -> String {
        let numbers = Constants.numbers
        let numbersCount = UInt32(numbers.characters.count)

        let randomString: String = (0..<length).reduce(String()) { accum, _ in
            let randomOffset = arc4random_uniform(numbersCount)
            let randomIndex = numbers.index(numbers.startIndex, offsetBy: Int(randomOffset))
            return accum.appending(String(numbers[randomIndex]))
        }

        return randomString
    }
}
