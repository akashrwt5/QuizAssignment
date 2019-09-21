//
//  Extensions.swift
//  Assignment
//
//  Created by Akash - iOS Dev on 21/09/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit


extension UIColor {
    static let defaultBlue = UIColor(red: 33/255.0, green: 150/255.0, blue: 243/255.0, alpha: 1.0)
    static let darkGreen = UIColor(red: 0.2, green: 0.85, blue: 0.2, alpha: 1.0)
    static let alternativeRed = UIColor(red: 0.85, green: 0.3, blue: 0.3, alpha: 1.0)
}

extension UIViewController{
    
    func showAlert(title:String,msg:String){
        let alertViewController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.goBack()
        }
        alertViewController.addAction(okAction)
        self.present(alertViewController, animated: true)
        
    }
    
    
    func goBack(){
        self.navigationController?.popViewController(animated: true)
    }
}
