//
//  SplashView.swift
//  HarryPotterApp
//
//  Created by Bartu Gençcan on 8.11.2022.
//

import UIKit
import Lottie


class SplashView: UIView {
    
    // MARK: - Properties
    private var animationView: LottieAnimationView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        showAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func showAnimation() {
        self.animationView = LottieAnimationView(name: "harrypotterloading")
        
        guard let animationView = self.animationView else {return}
        
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        self.addSubview(animationView)
        animationView.snp.makeConstraints { make in
            make.leading.trailing.bottom.top.equalToSuperview()
        }
        animationView.play()
        
    }
}

