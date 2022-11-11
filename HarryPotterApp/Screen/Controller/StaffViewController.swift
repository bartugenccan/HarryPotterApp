//
//  StaffViewController.swift
//  HarryPotterApp
//
//  Created by Bartu Gençcan on 8.11.2022.
//

import UIKit
import Lottie

class StaffViewController: UIViewController {
    
    private var viewModel: StaffViewModel
    
    private lazy var tableView = UITableView()
    
    private var animationView: LottieAnimationView?
    
    let cellSpacingHeight: CGFloat = 5


    // MARK: - Init
    init(viewModel: StaffViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        tableView.register(StaffTableViewCell.self
                           , forCellReuseIdentifier: "staffCell")

        tableViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        
        title = "Hogwarts Staff"
        
        viewModel.fetchStaff()
        
        if viewModel.isLoading == true {
            showAnimation()
        }
        
        viewModel.changeHandler = { change in
            switch change {
            case .didFetchStaff:
                guard let animationView = self.animationView else {return}
                animationView.stop()
                animationView.isHidden = true
                self.tableView.reloadData()
            case .didErrorOccurred(let error):
                print(error.localizedDescription)
            }
        }

    }
    
    // MARK: - TableView Layout
    func tableViewLayout(){
        view.addSubview(tableView)
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rowHeight = 125
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16.0)
            make.bottom.equalToSuperview()
            make.leading.equalTo(16.0)
            make.trailing.equalTo(-16.0)
        }
    }
    
    // MARK: - Methods
    func showAnimation() {
        self.animationView = LottieAnimationView(name: "hermoine")
        
        guard let animationView = self.animationView else {return}
        
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        tableView.backgroundView = animationView
        animationView.play()
    }
}

// MARK: - TableView Delegate
extension StaffViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - TableView DataSource
extension StaffViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "staffCell", for: indexPath) as? StaffTableViewCell else {
            fatalError("Cell not found")
        }
        
        cell.backgroundColor = .black
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = 3
        cell.layer.borderColor = UIColor.darkGray.cgColor
        
        guard let staff = viewModel.staffList?[indexPath.section] else { fatalError("Staff not found")}
        
            if staff.image == "" {
                cell.staffImageView.image = UIImage(systemName: "person.crop.circle")
                cell.staffImageView.tintColor = .white
            }else {
                DispatchQueue.main.async {
                    cell.staffImageView.kf.setImage(with: URL(string: "\(staff.image ?? "")")) {_ in
                    }
                }
            }

            cell.staffName = staff.name
            
            
        
        if staff.house == "" {
            cell.staffHouse = "Unknown"
        }else {
            cell.staffHouse = staff.house
        }

            if staff.dateOfBirth == "" {
                cell.staffBirth = "Unknown"
            }else {
                cell.staffBirth = staff.dateOfBirth
            }
        

        return cell
    }
}
