//
//  extension+UIView.swift
//  RealRacing
//
//  Created by Родион Ковалевский on 12/5/19.
//  Copyright © 2019 Родион Ковалевский. All rights reserved.
//

import Foundation
import UIKit
extension UIView{
    func roundCorner() {
        self.layer.cornerRadius = 10
    }
    
    func dropShadow(color:UIColor , opacity:Float , radius:CGFloat) {
           self.layer.masksToBounds = false// вью не ограничивается своими ганицами
           self.layer.shadowColor = color.cgColor // цвет тени
           self.layer.shadowOpacity = opacity // прозрачность тени
           self.layer.shadowOffset = CGSize(width: 1, height: 1) // отступ между тени и объектом
           self.layer.shadowRadius = radius //ширина тени
           self.layer.shadowPath = UIBezierPath(rect: bounds).cgPath//путь безье (почитать)
           self.layer.shouldRasterize = true // размытие тени
           self.layer.rasterizationScale = UIScreen.main.scale // autolayout
       }
}
