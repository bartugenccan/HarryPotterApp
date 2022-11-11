//
//  StudentDetailViewModel.swift
//  HarryPotterApp
//
//  Created by Bartu Gençcan on 11.11.2022.
//

import Foundation

class StudentDetailViewModel {
    
    private var student: Student
    
    var name: String? {
        student.name
    }
    
    var house: String? {
        student.house
    }
    
    var imageURL: URL? {
            URL(string: student.image ?? "")
    }
    
    var wand: String? {
        student.wand?.core
    }
    
    var patronus: String? {
        student.patronus
    }
    
    init(student: Student) {
        self.student = student
    }
}
