//
//  appConfig.swift
//  RealRacing
//
//  Created by Родион Ковалевский on 12/8/19.
//  Copyright © 2019 Родион Ковалевский. All rights reserved.
//

import Foundation
import UIKit
class AppConfig{
    static let car = UIImageView()
    static let carHeight = 120
    static let rock = UIImageView()
    static let bottomStep = 20
    static let carWidth = 60
    static var roadLine  = UIView()
    static var roadLineAnimate = 1.0
    static var bushAnimate = 1.0
    static let timerAnimate = 1.0
    static let minBushDistance = 44
    static let maxBushDistance = 440
    static var timer = Timer()
    static var checkTimer = Timer()
    static var appFont = "Sowjetschablone"
    static var score = 0
    
    static func makeLabelFont(label:UILabel,size:CGFloat){
        label.font = UIFont(name: appFont, size: size)
    }
    static func makeButtonFont(button:UIButton,size:CGFloat){
        button.titleLabel?.font = UIFont(name: appFont, size: size)
    }
    
}
