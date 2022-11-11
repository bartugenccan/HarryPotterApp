//
//  StudentsViewModel.swift
//  HarryPotterApp
//
//  Created by Bartu Gençcan on 8.11.2022.
//

import Foundation
import Alamofire

// Controlling Changes
enum StudentListChanges {
    case didErrorOccurred(_ error: Error)
    case didFetchStudents
}

class StudentsViewModel {
    
    var changeHandler: ((StudentListChanges) -> Void)?
    
    var isLoading: Bool = false
    
    
    private(set) var studentList: [Student]? {
        didSet {
            self.changeHandler?(.didFetchStudents)
        }
    }
    
    var numberOfItems: Int {
            studentList?.count ?? .zero
        }
    
    func fetchStudents() {
        isLoading = true
        AF.request("https://hp-api.herokuapp.com/api/characters/students")
            .validate()
            .responseDecodable(of: [Student].self) { (response) in
                guard let studentList = response.value else { return }
                self.studentList = studentList
                self.isLoading = false
        }
      }
    
    func studentForIndexPath(_ indexPath: IndexPath) -> Student? {
            studentList?[indexPath.section]
        }
}

