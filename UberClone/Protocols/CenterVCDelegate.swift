//
//  CenterVCDelegate.swift
//  UberClone
//
//  Created by MacBook Pro on 09/09/2018.
//  Copyright © 2018 MobilePowered. All rights reserved.
//

import UIKit
protocol CenterVCDelegate{
    func toggleLeftDelegate()
    func addMenuViewController()
    func animateMenu(shouldExpand:Bool)
}
