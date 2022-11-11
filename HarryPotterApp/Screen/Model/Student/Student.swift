//
//  Student.swift
//  HarryPotterApp
//
//  Created by Bartu Gençcan on 8.11.2022.
//

import Foundation

// MARK: - Student
struct Student: Codable {
    let name: String?
    let species, gender, house, dateOfBirth: String?
    let yearOfBirth: Int?
    let wizard: Bool?
    let ancestry, eyeColour, hairColour: String?
    let wand: Wand?
    let patronus: String?
    let hogwartsStudent, hogwartsStaff: Bool?
    let actor: String?
    let alive: Bool?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case name
        case species, gender, house, dateOfBirth, yearOfBirth, wizard, ancestry, eyeColour, hairColour, wand, patronus, hogwartsStudent, hogwartsStaff, actor
        case alive, image
    }
}

// MARK: - Wand
struct Wand: Codable {
    let wood, core: String?
    let length: Double?
}
