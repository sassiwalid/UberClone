//
//  ContainerVC.swift
//  UberClone
//
//  Created by MacBook Pro on 09/09/2018.
//  Copyright © 2018 MobilePowered. All rights reserved.
//

import UIKit
import QuartzCore

enum SlideOutState{
    case menucollapsed
    case menuexpanded
}
enum ShowWhichVC{
    case homeVC
}
//by default the home view controller
var showVC:ShowWhichVC = .homeVC
class ContainerVC: UIViewController {
    var homeVC:HomeVC!
    var menuVC:MenuVC!
    var currentViewController:UIViewController!
    var menuState: SlideOutState = .menucollapsed
    var statusbarIsHidden:Bool = false
    let menuLargeOffset:CGFloat = 150.0
    var tap:UITapGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()
        initCenter(screen: showVC)
        // Do any additional setup after loading the view.
    }
    func initCenter(screen:ShowWhichVC){
        var presentingVC:UIViewController
        showVC = screen
        if homeVC == nil {
            homeVC = UIStoryboard.homeVC()
            homeVC.delegate = self
        }
        presentingVC = homeVC
        //check if there is a view controller
        if let conn = currentViewController {
            conn.view.removeFromSuperview()
            conn.removeFromParentViewController()
        }
        currentViewController = presentingVC
        //now add the view related to currentViewController
        view.addSubview(currentViewController.view)
        addChildViewController(currentViewController)
        currentViewController.didMove(toParentViewController: self)
    }
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation{
        return UIStatusBarAnimation.slide
    }
    override var prefersStatusBarHidden: Bool{
        return statusbarIsHidden
    }
    
}
extension ContainerVC:CenterVCDelegate{
    func toggleLeftDelegate() {
        let menuNotReadyExpanded = (menuState != .menuexpanded)
        if menuNotReadyExpanded {
            addMenuViewController()
        }
       animateMenu(shouldExpand: menuNotReadyExpanded)
    }
    
    func addMenuViewController() {
        if menuVC == nil {
            menuVC = UIStoryboard.leftMenuVC()
            addChildMenuViewController(menu: menuVC)
        }
    }
    func addChildMenuViewController(menu:MenuVC){
        view.insertSubview(menu.view, at: 0)
        addChildViewController(menu)
        menu.didMove(toParentViewController: self)
        
    }
    
    @objc func animateMenu(shouldExpand: Bool) {
        if shouldExpand{
           statusbarIsHidden = true
           animateStatusBar()
           showMenuViewShadow()
           menuState = .menuexpanded
           animateMenuShow(targetPosition: currentViewController.view.frame.width - menuLargeOffset)
        }else{
            statusbarIsHidden = false
            animateStatusBar()
            hideMenuViewShadow()
            animateMenuShow(targetPosition: 0) { (finished) in
                if finished{
                    self.menuState = .menucollapsed
                    self.menuVC = nil
                }
            }
        }
    }
    //hidden and show status bar
    func animateStatusBar(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        })
    }
    func showMenuViewShadow(){
        let whiteCoverView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        whiteCoverView.alpha = 0.0
        whiteCoverView.backgroundColor = UIColor.white
        whiteCoverView.tag = 25
        self.currentViewController.view.addSubview(whiteCoverView)
        UIView.animate(withDuration: 0.2) {
            whiteCoverView.alpha = 0.75
        }
        tap = UITapGestureRecognizer(target: self, action: #selector(animateMenu(shouldExpand:)))
        tap.numberOfTapsRequired = 1
        self.currentViewController.view.addGestureRecognizer(tap)
        
        
    }
    func hideMenuViewShadow(){
        self.currentViewController.view.removeGestureRecognizer(tap)
        for subview in currentViewController.view.subviews{
            if subview.tag == 25 {
                UIView.animate(withDuration: 0.2, animations: {
                    subview.alpha = 0.0
                }) { (finished) in
                    if finished {
                        subview.removeFromSuperview()
                    }
                }
            }
        }
    }
    func animateMenuShow(targetPosition:CGFloat,completion:((Bool)->Void)! = nil){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.currentViewController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
    
}
private extension UIStoryboard{
    class func mainStoryboard()-> UIStoryboard{
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    class func leftMenuVC()->MenuVC?{
        return mainStoryboard().instantiateViewController(withIdentifier: "MenuVC") as? MenuVC
    }
    class func homeVC()->HomeVC?{
        return mainStoryboard().instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
    }
}

