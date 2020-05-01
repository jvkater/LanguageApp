//
//  WordsCollection.swift
//  StudyApp
//
//  Created by Евгений Катаев on 11/04/2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import Foundation
import UIKit

struct WordsLibrary {

    var sampleLib = [
        "Wahrheit":"Random",
        "Gesundheit":"Health",
        "Hilfen":"To help",
        "Fragen":"To question"
    ]
    func getRandomPair() -> Array<Any> {
        let currentWord = sampleLib.keys.randomElement()
        let currentTranslation = sampleLib[currentWord!]
        
        return [currentWord!,currentTranslation!]
    }
}

