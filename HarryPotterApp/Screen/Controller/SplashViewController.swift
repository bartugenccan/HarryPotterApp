//
//  SplashViewController.swift
//  HarryPotterApp
//
//  Created by Bartu Gençcan on 8.11.2022.
//

import UIKit

class SplashViewController: UIViewController {
    
    var splashView = SplashView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Navigates to main screen after 2.5 seconds.
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.5){
            let tabBarVC = TabBarViewController()
            
            self.navigationController?.pushViewController(tabBarVC, animated: true)
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        view = splashView
    }
}


