//
//  UIImageViexExtensions.swift
//  UberClone
//
//  Created by MacBook Pro on 08/09/2018.
//  Copyright © 2018 MobilePowered. All rights reserved.
//

import UIKit

extension UIImageView{
    
    func roundImageView(){
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
}
