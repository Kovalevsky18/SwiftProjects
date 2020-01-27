//
//  extension+UiViewController.swift
//  RealRacing
//
//  Created by Родион Ковалевский on 12/15/19.
//  Copyright © 2019 Родион Ковалевский. All rights reserved.
//
import UIKit
import Foundation
extension UIViewController{
    func tapRecogniser(view:UIView , selector:Selector){
            let detector = UITapGestureRecognizer(target: self, action:#selector(selector)
            detector.numberOfTapsRequired = 1
            self.burgerMenuOutlet.addGestureRecognizer(detector)

    }
}
