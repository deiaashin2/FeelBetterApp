//
//  MoodEntry+CoreDataProperties.swift
//  Feel Better App
//
//  Created by Andreia Shin on 3/12/24.
//
//

import Foundation
import CoreData


extension MoodEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MoodEntry> {
        return NSFetchRequest<MoodEntry>(entityName: "MoodEntry")
    }

    @NSManaged public var moodType: String?
    @NSManaged public var moodNotes: String?
    @NSManaged public var date: Date?

}

extension MoodEntry : Identifiable {

}
