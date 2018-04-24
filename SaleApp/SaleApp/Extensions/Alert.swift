//
//  Alert.swift
//  SaleApp
//
//  Created by logan on 2018/4/8.
//  Copyright © 2018 Chuanqi. All rights reserved.
//

import Foundation
import UIKit

struct AlertCreator{
    static let shared = AlertCreator()
    
    func createAlertWithTitle(title: String) -> UIAlertController{
        let alert = UIAlertController(title: "Error", message: title, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(alertAction) in
            alert.dismiss(animated: true, completion: nil)
        }))
        return alert
    }
    
    func createSuccessAlertWithTitle(title: String) -> UIAlertController{
        let alert = UIAlertController(title: "Success", message: title, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(alertAction) in
            alert.dismiss(animated: true, completion: nil)
        }))
        return alert
    }

}
