//
//  StudentsTableViewCell.swift
//  HarryPotterApp
//
//  Created by Bartu Gençcan on 8.11.2022.
//

import UIKit

class StudentsTableViewCell: UITableViewCell {
    
    var studentName: String? {
        didSet {
            studentNameLabel.text = "Name: \(studentName ?? "")"
        }
    }
    
    var studentHouse: String? {
        didSet {
            studentHouseLabel.text = "House: \(studentHouse ?? "")"
        }
    }
    
    var studentBirth: String? {
        didSet {
            studentBirthLabel.text = "Birth: \(studentBirth ?? "")"
        }
    }

    private(set) lazy var studentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 37.0
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
    }()
    
    private(set) lazy var studentNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.init(name: "HarryP", size: 32.0)
        return label
    }()
    
    private(set) lazy var studentHouseLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.init(name: "HarryP", size: 32.0)
        label.textColor = .white
        return label
    }()
    
    private(set) lazy var studentBirthLabel: UILabel = {
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
        studentImageViewLayout()
        studentNameLabelLayout()
        studentHouseLabelLayout()
        studentBirthLabelLayout()
    }
    
    // ImageView Layout
    func studentImageViewLayout(){
        self.addSubview(studentImageView)

        
        studentImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(8.0)
            make.leading.equalTo(16.0)
            make.size.equalTo(74.0)
        }
    }
    
    // NameLabel Layout
    func studentNameLabelLayout(){
        self.addSubview(studentNameLabel)
        
        studentNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(studentImageView.snp.trailing).offset(16.0)
            make.top.equalTo(self.snp.top).offset(8.0)
        }
    }
    
    // Student House Layout
    func studentHouseLabelLayout(){
        self.addSubview(studentHouseLabel)
        
        studentHouseLabel.snp.makeConstraints { make in
            make.top.equalTo(studentNameLabel.snp.bottom).offset(12.0)
            make.leading.equalTo(studentNameLabel.snp.leading)
        }
    }
    
    // Student Birth Layout
    func studentBirthLabelLayout(){
        self.addSubview(studentBirthLabel)
        
        studentBirthLabel.snp.makeConstraints { make in
            make.top.equalTo(studentHouseLabel.snp.bottom).offset(12.0)
            make.trailing.equalTo(self.snp.trailing).offset(-8.0)
        }
    }

}
