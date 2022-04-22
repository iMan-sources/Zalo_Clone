//
//  UIViewController+Utils.swift
//  Zalo
//
//  Created by AnhLe on 06/04/2022.
//

import UIKit

extension UIViewController {
    func setupDissmissKeyboard(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(resignResponder(_:)))
        gesture.cancelsTouchesInView = true
        view.addGestureRecognizer(gesture)
    }
    
    @objc func resignResponder(_ sender: UITapGestureRecognizer){
        view.endEditing(true)
        navigationController?.navigationBar.endEditing(true)
    }
    
    func setTabBarImage(image: UIImage, title: String, withTag tag: Int){
        let configuration = UIImage.SymbolConfiguration(scale: .medium)
        let image = image.withConfiguration(configuration)
        
        tabBarItem = UITabBarItem(title: title, image: image, tag: tag)
    }
    
    func makeNavBarButton(image: UIImage) -> UIButton{
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let button = UIButton(type: .custom)
        button.setImage(image.withConfiguration(configuration), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        return button
    }
}
