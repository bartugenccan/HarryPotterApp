//
//  StaffViewModel.swift
//  HarryPotterApp
//
//  Created by Bartu Gençcan on 11.11.2022.
//

import Foundation
import Alamofire

enum StaffListChanges {
    case didErrorOccurred(_ error: Error)
    case didFetchStaff
}

class StaffViewModel {
    
    var changeHandler: ((StaffListChanges) -> Void)?
    
    var isLoading: Bool = false
    
    private(set) var staffList: [Staff]? {
        didSet{
            self.changeHandler?(.didFetchStaff)
        }
    }
    
    var numberOfItems: Int {
        staffList?.count ?? .zero
    }
    
    func fetchStaff(){
        isLoading = true
        AF.request("https://hp-api.herokuapp.com/api/characters/staff")
            .validate()
            .responseDecodable(of: [Staff].self) { (response) in
                guard let staffList = response.value else { return }
                self.staffList = staffList
                self.isLoading = false
        }
    }
    
    func staffForIndexPath(_ indexPath: IndexPath) -> Staff? {
        staffList?[indexPath.section]
    }
}
