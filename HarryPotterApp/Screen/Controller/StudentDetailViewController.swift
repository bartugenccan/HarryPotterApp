//
//  StudentDetailViewController.swift
//  HarryPotterApp
//
//  Created by Bartu Gençcan on 11.11.2022.
//

import UIKit
import Kingfisher

class StudentDetailViewController: UIViewController {
    
    private var viewModel: StudentDetailViewModel
    
    private var detailView = StudentDetailView()
    
    init(viewModel: StudentDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view = detailView
        title = "Student Detail"
    
        if viewModel.imageURL == URL(string: "") {
            detailView.studentImageView.image = UIImage(systemName: "person.crop.circle")
            detailView.studentImageView.tintColor = .black
        }else {
            detailView.studentImageView.kf.setImage(with: viewModel.imageURL)
        }
        
        switch viewModel.house {
        case "Gryffindor":
            detailView.studentHouseImageView.image = UIImage(named: "gryffindor")
            detailView.houseView.backgroundColor = HexColor.shared.hexStringToUIColor(hex: "#740001")
        case "Slytherin":
            detailView.studentHouseImageView.image = UIImage(named: "slytherin")
            detailView.houseView.backgroundColor = HexColor.shared.hexStringToUIColor(hex: "#1A472A")
        case "Hufflepuff":
            detailView.studentHouseImageView.image = UIImage(named: "hufflepuff")
            detailView.houseView.backgroundColor = HexColor.shared.hexStringToUIColor(hex: "#FFD800")
        case "Ravenclaw":
            detailView.studentHouseImageView.image = UIImage(named: "ravenclaw")
            detailView.houseView.backgroundColor = HexColor.shared.hexStringToUIColor(hex: "#0E1A40")
        default:
            detailView.studentHouseImageView.image = UIImage(systemName: "person.crop.circle")
        }
        
        detailView.name = viewModel.name
        detailView.house = viewModel.house
        
        if viewModel.wand == "" {
            detailView.wand = "Wand Core: Unknown"
        }else {
            detailView.wand = "Wand Core: \(viewModel.wand?.capitalized ?? "")"
        }
        
        if viewModel.patronus == "" {
            detailView.patronus = "Patronus: Unknown"
        }else {
            detailView.patronus = "Patronus: \(viewModel.patronus?.capitalized ?? "")"
        }
 }
}
