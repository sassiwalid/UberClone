//
//  ViewController.swift
//  UberClone
//
//  Created by MacBook Pro on 07/09/2018.
//  Copyright © 2018 MobilePowered. All rights reserved.
//

import UIKit
import MapKit
class HomeVC: UIViewController,MKMapViewDelegate {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    var delegate:CenterVCDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapView.delegate = self
        setupViews()
    }
    
    func setupViews(){
        //headerView.setupGradient()
        profileImageView.roundImageView()
        locationView.setupShadow()
    }

    @IBAction func showMenuClicked(_ sender: Any) {
        delegate?.toggleLeftDelegate()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

