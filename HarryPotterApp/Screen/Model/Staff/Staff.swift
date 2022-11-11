//
//  Staff.swift
//  HarryPotterApp
//
//  Created by Bartu Gençcan on 11.11.2022.
//

import Foundation

// MARK: - Staff
struct Staff: Codable {
    let name: String?
    let species, gender, house, dateOfBirth: String?
    let yearOfBirth: Int?
    let wizard: Bool?
    let ancestry, eyeColour, hairColour: String?
    let wand: StaffWand?
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
struct StaffWand: Codable {
    let wood, core: String?
}
