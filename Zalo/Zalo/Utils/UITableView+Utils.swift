//
//  UITableView+Utils.swift
//  Zalo
//
//  Created by AnhLe on 15/04/2022.
//

import UIKit
extension UITableView {
    // xoa bo row thua
    func removeExcessCell(){
        tableFooterView = UIView(frame: .zero)
        
    }
    
    func removeSeparatorsOfEmptyCellsAndLastCell() {
        tableFooterView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: 1)))
    }
}
