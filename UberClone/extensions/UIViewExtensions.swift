//
//  UIViewExtensions.swift
//  UberClone
//
//  Created by MacBook Pro on 08/09/2018.
//  Copyright © 2018 MobilePowered. All rights reserved.
//

import UIKit

extension UIView{

    func setupGradient(){
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor.white.cgColor,UIColor.init(white: 1.0, alpha: 0.0).cgColor]
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.locations = [0,8,1.0]
        self.layer.addSublayer(gradient)

    }
    func setupShadow(){
        self.layer.cornerRadius = 0.5
        self.layer.shadowOpacity = 0.3
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        
    }
    func setupBorder(){
        self.layer.cornerRadius = 0.5
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.black.cgColor
    }
}
