//
//  StudentsViewController.swift
//  HarryPotterApp
//
//  Created by Bartu Gençcan on 8.11.2022.
//

import UIKit
import Kingfisher
import Lottie

class StudentsViewController: UIViewController {
    
    private var viewModel: StudentsViewModel
    
    private lazy var tableView = UITableView()
    
    private lazy var searchBar = UISearchBar()
    
    var searchData = [Student]()
    var searchActive = false
    var searchTerm: String?
    
    var sortedList = [Student]()
    
    // Segmented Control Items
    let items = ["All", "Gryffindor", "Slytherin", "Hufflepuff", "Ravenclaw"]
    
    private lazy var segmentedControl = UISegmentedControl(items: items)
    
    private var animationView: LottieAnimationView?
    
    let cellSpacingHeight: CGFloat = 5
    
    // MARK: - Init
    init(viewModel: StudentsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        tableView.register(StudentsTableViewCell.self
                           , forCellReuseIdentifier: "studentCell")

        searchBarLayout()
        segmentedControlConfiguration()
        segmentedControlLayout()
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
        
        searchBar.delegate = self
        
        title = "Hogwarts Students"
        
        viewModel.fetchStudents()
        
        if viewModel.isLoading == true {
            showAnimation()
        }
        
        viewModel.changeHandler = { change in
            switch change {
            case .didFetchStudents:
                
                guard let studentList = self.viewModel.studentList else {return}
                
                self.sortedList = studentList
                
                guard let animationView = self.animationView else {return}
                animationView.stop()
                animationView.isHidden = true
                self.tableView.reloadData()
            case .didErrorOccurred(let error):
                print(error.localizedDescription)
            }
        }

    }
    
    // MARK: - SegmentedControl Configuration
    func segmentedControlConfiguration(){
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }
    
    // MARK: - SearchBar Layout
    func searchBarLayout(){
        view.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8.0)
            make.leading.equalTo(8.0)
            make.trailing.equalTo(-8.0)
        }
    }
    
    // MARK: - SearchBar Configuration
    func searchBarConfiguration(){
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        
    }
    
    // MARK: - SegmentedControl Layout
    func segmentedControlLayout(){
        view.addSubview(segmentedControl)
        
        segmentedControl.backgroundColor = .black
        segmentedControl.tintColor = .white
        
        segmentedControl.selectedSegmentTintColor = .white
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let selectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            segmentedControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
            segmentedControl.setTitleTextAttributes(selectedTitleTextAttributes, for: .selected)
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(8.0)
            make.leading.equalTo(8.0)
            make.trailing.equalTo(-8.0)
        }
    }
    
    // MARK: - TableView Layout
    func tableViewLayout(){
        view.addSubview(tableView)
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rowHeight = 125
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(16.0)
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
    
    // MARK: - Actions
    @objc func segmentedValueChanged(){
        
        guard let studentList = viewModel.studentList else {return}
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            searchActive = false
            searchBar.searchTextField.text = ""
            sortedList = studentList
            tableView.setContentOffset(CGPoint(x: 0, y: -tableView.contentInset.top), animated: true)
            tableView.reloadData()
        case 1:
            searchActive = false
            searchBar.searchTextField.text = ""
            sortedList = studentList.filter({$0.house == "Gryffindor"})
            tableView.setContentOffset(CGPoint(x: 0, y: -tableView.contentInset.top), animated: true)
            tableView.reloadData()
        case 2:
            searchActive = false
            searchBar.searchTextField.text = ""
            sortedList = studentList.filter({$0.house == "Slytherin"})
            tableView.setContentOffset(CGPoint(x: 0, y: -tableView.contentInset.top), animated: true)
            tableView.reloadData()
        case 3:
            searchActive = false
            searchBar.searchTextField.text = ""
            sortedList = studentList.filter({$0.house == "Hufflepuff"})
            tableView.setContentOffset(CGPoint(x: 0, y: -tableView.contentInset.top), animated: true)
            tableView.reloadData()
        case 4:
            searchActive = false
            searchBar.searchTextField.text = ""
            sortedList = studentList.filter({$0.house == "Ravenclaw"})
            tableView.setContentOffset(CGPoint(x: 0, y: -tableView.contentInset.top), animated: true)
            tableView.reloadData()
        default:
            searchActive = false
            searchBar.searchTextField.text = ""
            sortedList = studentList
            tableView.setContentOffset(CGPoint(x: 0, y: -tableView.contentInset.top), animated: true)
            tableView.reloadData()
        }
    }

}

// MARK: - TableView Delegate
extension StudentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if searchActive {
            let student = searchData[indexPath.section]
            
            let viewModel = StudentDetailViewModel(student: student)
            let studentDetailVC = StudentDetailViewController(viewModel: viewModel)
            navigationController?.pushViewController(studentDetailVC, animated: true)
            
            tableView.deselectRow(at: indexPath, animated: true)
        }else {
            let student = sortedList[indexPath.section]
            
            let viewModel = StudentDetailViewModel(student: student)
            let studentDetailVC = StudentDetailViewController(viewModel: viewModel)
            navigationController?.pushViewController(studentDetailVC, animated: true)
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        
    }

}

// MARK: - TableView DataSource
extension StudentsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if searchActive {
            return searchData.count
        }else {
            return sortedList.count
        }
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath) as? StudentsTableViewCell else {
            fatalError("Cell not found")
        }

        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = 3
        cell.layer.borderColor = UIColor.darkGray.cgColor
        
        let student = sortedList[indexPath.section]
        
        if searchActive {
            let searchedStudent = searchData[indexPath.section]
            
            switch searchedStudent.house {
            case "Gryffindor":
                cell.backgroundColor = HexColor.shared.hexStringToUIColor(hex: "#740001")
                cell.studentNameLabel.textColor = HexColor.shared.hexStringToUIColor(hex: "#D3A625")
                cell.studentHouseLabel.textColor = HexColor.shared.hexStringToUIColor(hex: "#D3A625")
                cell.studentBirthLabel.textColor = HexColor.shared.hexStringToUIColor(hex: "#D3A625")
            case "Slytherin":
                cell.backgroundColor = HexColor.shared.hexStringToUIColor(hex: "#1A472A")
                cell.studentNameLabel.textColor = HexColor.shared.hexStringToUIColor(hex: "#C0C0C0")
                cell.studentHouseLabel.textColor = HexColor.shared.hexStringToUIColor(hex: "#C0C0C0")
                cell.studentBirthLabel.textColor = HexColor.shared.hexStringToUIColor(hex: "#C0C0C0")
            case "Hufflepuff":
                cell.backgroundColor = HexColor.shared.hexStringToUIColor(hex: "#FFD800")
                cell.studentNameLabel.textColor = .black
                cell.studentHouseLabel.textColor = .black
                cell.studentBirthLabel.textColor = .black
            case "Ravenclaw":
                cell.backgroundColor = HexColor.shared.hexStringToUIColor(hex: "#0E1A40")
                cell.studentNameLabel.textColor = HexColor.shared.hexStringToUIColor(hex: "#946B2D")
                cell.studentHouseLabel.textColor = HexColor.shared.hexStringToUIColor(hex: "#946B2D")
                cell.studentBirthLabel.textColor = HexColor.shared.hexStringToUIColor(hex: "#946B2D")
            default:
                cell.backgroundColor = .black
                cell.studentNameLabel.textColor = .white
            }
            
            if searchedStudent.image == "" {
                cell.studentImageView.image = UIImage(systemName: "person.crop.circle")
                cell.studentImageView.tintColor = .white
            }else {
                DispatchQueue.main.async {
                    cell.studentImageView.kf.setImage(with: URL(string: "\(searchedStudent.image ?? "")")) {_ in
                    }
                }
            }

            cell.studentName = searchedStudent.name
        
            if searchedStudent.dateOfBirth == "" {
                cell.studentHouse = "Unknown"
            }else {
                cell.studentHouse = searchedStudent.house
            }

            if searchedStudent.dateOfBirth == "" {
                cell.studentBirth = "Unknown"
            }else {
                cell.studentBirth = searchedStudent.dateOfBirth
            }
        }else {

            
            switch student.house {
            case "Gryffindor":
                cell.backgroundColor = HexColor.shared.hexStringToUIColor(hex: "#740001")
                cell.studentNameLabel.textColor = HexColor.shared.hexStringToUIColor(hex: "#D3A625")
                cell.studentHouseLabel.textColor = HexColor.shared.hexStringToUIColor(hex: "#D3A625")
                cell.studentBirthLabel.textColor = HexColor.shared.hexStringToUIColor(hex: "#D3A625")
            case "Slytherin":
                cell.backgroundColor = HexColor.shared.hexStringToUIColor(hex: "#1A472A")
                cell.studentNameLabel.textColor = HexColor.shared.hexStringToUIColor(hex: "#C0C0C0")
                cell.studentHouseLabel.textColor = HexColor.shared.hexStringToUIColor(hex: "#C0C0C0")
                cell.studentBirthLabel.textColor = HexColor.shared.hexStringToUIColor(hex: "#C0C0C0")
            case "Hufflepuff":
                cell.backgroundColor = HexColor.shared.hexStringToUIColor(hex: "#FFD800")
                cell.studentNameLabel.textColor = .black
                cell.studentHouseLabel.textColor = .black
                cell.studentBirthLabel.textColor = .black
            case "Ravenclaw":
                cell.backgroundColor = HexColor.shared.hexStringToUIColor(hex: "#0E1A40")
                cell.studentNameLabel.textColor = HexColor.shared.hexStringToUIColor(hex: "#946B2D")
                cell.studentHouseLabel.textColor = HexColor.shared.hexStringToUIColor(hex: "#946B2D")
                cell.studentBirthLabel.textColor = HexColor.shared.hexStringToUIColor(hex: "#946B2D")
            default:
                cell.backgroundColor = .black
                cell.studentNameLabel.textColor = .white
            }
            
            if student.image == "" {
                cell.studentImageView.image = UIImage(systemName: "person.crop.circle")
                cell.studentImageView.tintColor = .white
            }else {
                DispatchQueue.main.async {
                    cell.studentImageView.kf.setImage(with: URL(string: "\(student.image ?? "")")) {_ in
                    }
                }
            }

            cell.studentName = student.name
            
            if student.dateOfBirth == "" {
                cell.studentHouse = "Unknown"
            }else {
                cell.studentHouse = student.house
            }

            if student.dateOfBirth == "" {
                cell.studentBirth = "Unknown"
            }else {
                cell.studentBirth = student.dateOfBirth
            }
        }

        return cell
    }
}

// MARK: - UISearchbar Delegate
extension StudentsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchData = searchText.isEmpty ? sortedList : sortedList.filter{$0.name?.range(of: searchText, options: [.caseInsensitive, .anchored]) != nil}
        searchActive = true
        
        tableView.reloadData()
    }
}
