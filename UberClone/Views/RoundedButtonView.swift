//
//  RoundedButtonView.swift
//  UberClone
//
//  Created by MacBook Pro on 09/09/2018.
//  Copyright © 2018 MobilePowered. All rights reserved.
//

import UIKit

class RoundedButtonView: UIButton {

    override func awakeFromNib() {
        setupRoundedButton()
    }
    func setupRoundedButton(){
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 5
    }

}
