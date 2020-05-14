//
//  WordsLibrary+CoreDataProperties.swift
//  StudyApp
//
//  Created by Евгений Катаев on 14/05/2020.
//  Copyright © 2020 Eugene. All rights reserved.
//
//

import Foundation
import CoreData


extension WordsLibrary {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WordsLibrary> {
        return NSFetchRequest<WordsLibrary>(entityName: "WordsLibrary")
    }

    @NSManaged public var addedWord: String?
    @NSManaged public var addedWordTranslation: String?
    @NSManaged public var successfullRecalls: Int32

}
