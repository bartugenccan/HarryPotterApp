//
//  StudentDetailView.swift
//  HarryPotterApp
//
//  Created by Bartu Gençcan on 11.11.2022.
//

import Foundation
import UIKit

class StudentDetailView: UIView {
    
    // MARK: - Properties
    var name: String? {
        didSet {
            studentNameLabel.text = name
        }
    }
    
    var house: String? {
        didSet{
            studentHouseLabel.text = house
        }
    }
    
    var patronus: String? {
        didSet {
            studentPatronusLabel.text = patronus
        }
    }
    
    var wand: String? {
        didSet {
            studentWandLabel.text = wand
        }
    }

    private(set) lazy var studentNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "HarryP", size: 48.0)
        return label
    }()
    
    private(set) lazy var studentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 78.0
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 2
        return imageView
    }()
    
    private(set) lazy var houseView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    private(set) lazy var studentHouseImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private(set) lazy var studentHouseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "HarryP", size: 48.0)
        return label
    }()
    
    private(set) lazy var studentPatronusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "HarryP", size: 36.0)
        return label
    }()
    
    private(set) lazy var studentWandLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "HarryP", size: 36.0)
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    func layout(){
        studentNameLabelLayout()
        studentImageViewLayout()
        houseViewLayout()
        studentHouseImageViewLayout()
        studentHouseLabelLayout()
        studentWandLabelLayout()
        studentPatronusLabelLayout()
    }
    
    func studentNameLabelLayout(){
        addSubview(studentNameLabel)
        
        studentNameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(16.0)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
    
    func studentImageViewLayout(){
        addSubview(studentImageView)
        
        studentImageView.snp.makeConstraints { make in
            make.top.equalTo(studentNameLabel.snp.bottom).offset(32.0)
            make.centerX.equalTo(self.snp.centerX)
            make.size.equalTo(156.0)
        }
    }
    
    func houseViewLayout(){
        addSubview(houseView)
        
        houseView.snp.makeConstraints { make in
            make.top.equalTo(studentImageView.snp.bottom).offset(16.0)
            make.leading.equalTo(32.0)
            make.trailing.equalTo(-32.0)
            make.height.equalTo(64.0)
        }
    }
    
    func studentHouseImageViewLayout(){
        houseView.addSubview(studentHouseImageView)
        
        studentHouseImageView.snp.makeConstraints { make in
            make.leading.equalTo(houseView.snp.leading).offset(16.0)
            make.centerY.equalTo(houseView.snp.centerY)
            make.size.equalTo(48.0)
        }
    }
    
    func studentHouseLabelLayout(){
        houseView.addSubview(studentHouseLabel)
        
        studentHouseLabel.snp.makeConstraints { make in
            make.center.equalTo(houseView.snp.center)
        }
    }
    
    func studentWandLabelLayout(){
        addSubview(studentWandLabel)
        
        studentWandLabel.snp.makeConstraints { make in
            make.top.equalTo(houseView.snp.bottom).offset(32.0)
            make.leading.equalTo(self.snp.leading).offset(16.0)
        }
    }
    
    func studentPatronusLabelLayout(){
        addSubview(studentPatronusLabel)
        
        studentPatronusLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(16.0)
            make.top.equalTo(studentWandLabel.snp.bottom).offset(16.0)
        }
    }
}
