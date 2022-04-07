//
//  OnboardingViewController.swift
//  Zalo
//
//  Created by AnhLe on 03/04/2022.
//

import UIKit

class OnboardingViewController: UIViewController {
    // MARK: - Subview
    private let backgroundImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = Image.onboardingImg1
        imageView.clipsToBounds = true
        return imageView
    }()
    

    private var label: UILabel!
    private var subLabel: UILabel!
    // MARK: - Properties
    
    // MARK: - Lifecycle

    
    init(contentLabel: String, contenSublabel: String ,image: UIImage, textColor: UIColor?) {
        super.init(nibName: nil, bundle: nil)
        label = CustomLabel(content: contentLabel,
                            color: .black,
                            alignment: .center,
                            fontFamily: .preferredFont(forTextStyle: .body))

        subLabel = CustomLabel(content: contenSublabel,
                               color: textColor ?? .black,
                               alignment: .center,
                               fontFamily: .preferredFont(forTextStyle: .callout))
        backgroundImageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        OnboardingContainerViewController.zaloLogo.isHidden = false
    }
    

    

    
    // MARK: - Selector
    
    // MARK: - API
    
    // MARK: - Helper
}
// MARK: - Extension
extension OnboardingViewController {
    
    func style(){
        view.backgroundColor = .systemBackground
        
        
        subLabel.lineBreakMode = .byWordWrapping
        subLabel.numberOfLines = 0
        
    }
    func layout(){
        view.addSubview(backgroundImageView)
        view.addSubview(label)
        view.addSubview(subLabel)
        

        
        //background Img
        NSLayoutConstraint.activate([
            backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        ])
        
        //label
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalToSystemSpacingBelow: backgroundImageView.bottomAnchor, multiplier: 1),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        //sublabel
        NSLayoutConstraint.activate([
            subLabel.topAnchor.constraint(equalToSystemSpacingBelow:label.bottomAnchor, multiplier: 1),
            subLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: subLabel.trailingAnchor, multiplier: 2)
        ])
        
    }
}
