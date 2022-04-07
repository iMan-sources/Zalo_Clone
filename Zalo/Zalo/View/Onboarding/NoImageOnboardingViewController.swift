//
//  noImageOnboardingViewController.swift
//  Zalo
//
//  Created by AnhLe on 05/04/2022.
//

import UIKit

class NoImageOnboardingViewController: UIViewController {
    // MARK: - Subview
    private let zaloLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = Image.zaloImg
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let backgroundImg: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = Image.cityImg
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("DEBUG: noImageVC appear")
        OnboardingContainerViewController.zaloLogo.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    // MARK: - Selector
    
    // MARK: - API
    
    // MARK: - Helper
}
// MARK: - Extension
extension NoImageOnboardingViewController {
    
    func style(){
        
    }
    func layout(){
        view.addSubview(backgroundImg)
        view.addSubview(zaloLogo)
        //zaloImg
        NSLayoutConstraint.activate([
            zaloLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            zaloLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            zaloLogo.heightAnchor.constraint(equalToConstant: 124),
            zaloLogo.widthAnchor.constraint(equalTo: zaloLogo.heightAnchor, multiplier: 1)
        ])
        
        //backgroundImg
        
        NSLayoutConstraint.activate([
            backgroundImg.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImg.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: backgroundImg.trailingAnchor, multiplier: 0),
            backgroundImg.heightAnchor.constraint(equalToConstant: view.bounds.height / 2),
            
        
        ])
    }
}
