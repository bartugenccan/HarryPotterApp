//
//  StaffTableViewCell.swift
//  HarryPotterApp
//
//  Created by Bartu Gençcan on 11.11.2022.
//

import UIKit

class StaffTableViewCell: UITableViewCell {
    
    var staffName: String? {
        didSet {
            staffNameLabel.text = "Name: \(staffName ?? "")"
        }
    }
    
    var staffHouse: String? {
        didSet {
            staffHouseLabel.text = "House: \(staffHouse ?? "")"
        }
    }
    
    var staffBirth: String? {
        didSet {
            staffBirthLabel.text = "Birth: \(staffBirth ?? "")"
        }
    }

    private(set) lazy var staffImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.cornerRadius = 37.0
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    private(set) lazy var staffNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.init(name: "HarryP", size: 32.0)
        return label
    }()
    
    private(set) lazy var staffHouseLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.init(name: "HarryP", size: 32.0)
        label.textColor = .white
        return label
    }()
    
    private(set) lazy var staffBirthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "HarryP", size: 18.0)
        label.textColor = .white
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
    }
        
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    func layout(){
        staffImageViewLayout()
        staffNameLabelLayout()
        staffHouseLabelLayout()
        staffBirthLabelLayout()
    }
    
    // ImageView Layout
    func staffImageViewLayout(){
        self.addSubview(staffImageView)

        
        staffImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(8.0)
            make.leading.equalTo(16.0)
            make.size.equalTo(74.0)
        }
    }
    
    // NameLabel Layout
    func staffNameLabelLayout(){
        self.addSubview(staffNameLabel)
        
        staffNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(staffImageView.snp.trailing).offset(16.0)
            make.top.equalTo(self.snp.top).offset(8.0)
        }
    }
    
    // Student House Layout
    func staffHouseLabelLayout(){
        self.addSubview(staffHouseLabel)
        
        staffHouseLabel.snp.makeConstraints { make in
            make.top.equalTo(staffNameLabel.snp.bottom).offset(12.0)
            make.leading.equalTo(staffNameLabel.snp.leading)
        }
    }
    
    // Student Birth Layout
    func staffBirthLabelLayout(){
        self.addSubview(staffBirthLabel)
        
        staffBirthLabel.snp.makeConstraints { make in
            make.top.equalTo(staffHouseLabel.snp.bottom).offset(12.0)
            make.trailing.equalTo(self.snp.trailing).offset(-8.0)
        }
    }


}
