//
//  TabBarViewController.swift
//  HarryPotterApp
//
//  Created by Bartu Gençcan on 8.11.2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tab Bar Colors
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .systemOrange

        // View Controllers
        let studentsViewController = StudentsViewController(viewModel: StudentsViewModel())
        let staffViewController = StaffViewController(viewModel: StaffViewModel())
        
        // Navigation Controllers
        let studentsNavigationController = UINavigationController(rootViewController: studentsViewController)
        studentsNavigationController.title = "Students"
        studentsNavigationController.tabBarItem.image = UIImage(systemName: "graduationcap")
        
        let staffNavigationController = UINavigationController(rootViewController: staffViewController)
        staffNavigationController.title = "Staff"
        staffNavigationController.tabBarItem.image = UIImage(systemName: "person.crop.rectangle.stack")
    
        self.navigationItem.hidesBackButton = true
        self.viewControllers = [studentsNavigationController,staffNavigationController]
    }

}
