///
//  SaplashViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/8/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class SaplashViewController: UIViewController {

   
    @IBOutlet weak var lblLoading: UILabel!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var isSignUp:Bool?
    var navBar: UINavigationBar = UINavigationBar()
    var navigationBarAppearace = UINavigationBar.appearance()
    var tabBarAppearence = UITabBar.appearance()
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    let login = UserDefaults.standard.string(forKey: "loginCheck")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nokri_signUpData()
        nokri_splashData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK:- Custome Methods
   
    @objc func nokri_showNavController2(){
        let id = UserDefaults.standard.string(forKey: "id")
        let check = UserDefaults.standard.string(forKey: "loginCheck")
        if check == nil {
            UserDefaults.standard.set("5", forKey: "aType")
            UserDefaults.standard.set(nil, forKey: "loginCheck")
            let withOutLogin = UserDefaults.standard.string(forKey: "aType")
            if withOutLogin == "5"{
                appDelegate.nokri_moveToHome2()
            }
        }else{
            if id == "0" || id == nil{
                appDelegate.nokri_showLandingPage()
            }else{
                appDelegate.nokri_moveToHome2()
            }
        }
    }
    
    @objc func nokri_showNavController1(){
        let id = UserDefaults.standard.string(forKey: "id")
        let check = UserDefaults.standard.string(forKey: "loginCheck")
        if check == nil {
            UserDefaults.standard.set("5", forKey: "aType")
            UserDefaults.standard.set(nil, forKey: "loginCheck")
            let withOutLogin = UserDefaults.standard.string(forKey: "aType")
            if withOutLogin == "5"{
                //UserDefaults.standard.set("5", forKey: "aType")
                appDelegate.nokri_moveToHome1()
            }
        }else{
            if id == "0" || id == nil{
                appDelegate.nokri_showLandingPage()
            }else{
                appDelegate.nokri_moveToHome1()
            }
        }
    }
    
    func nokri_splashData(){
        UserHandler.nokri_saplashData(success: { (successResponse) in
            if successResponse.success {
                UserHandler.sharedInstance.objSaplash = successResponse.data
                //print(successResponse.data.isRtl)
                UserDefaults.standard.set(successResponse.data.isRtl, forKey: "isRtl")
                UserDefaults.standard.set(successResponse.data.app_color, forKey: "app_Color")
                self.nokri_appearance()
                let appColorNew = UserDefaults.standard.string(forKey: "app_Color")
                self.navigationBarAppearace.tintColor = UIColor.white
                self.navigationBarAppearace.barTintColor = UIColor(hex:appColorNew!)
                self.navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
                self.tabBarAppearence.barTintColor = UIColor(hex:appColorNew!)
                self.tabBarAppearence.alpha = 1.0
                let isRtl = UserDefaults.standard.string(forKey: "isRtl")
                if isRtl == "0"{
                    UIView.appearance().semanticContentAttribute = .forceLeftToRight
                }else{
                    UIView.appearance().semanticContentAttribute = .forceRightToLeft
                }
                UserDefaults.standard.set(successResponse.data.isBlog, forKey: "isBlog")
                UserDefaults.standard.set(successResponse.data.home, forKey: "home")
                if successResponse.data.home == "1"{
                     self.perform(#selector(self.nokri_showNavController1), with: nil, afterDelay: 2)
                }else{
                     self.perform(#selector(self.nokri_showNavController2), with: nil, afterDelay: 2)
                }
                UserDefaults.standard.set(successResponse.data.job_form, forKey: "job_form")
//                UserDefaults.standard.set(successResponse.data.extra.JobTitle, forKey: "title")
//                UserDefaults.standard.set(successResponse.data.extra.JobDes, forKey: "desc")
//                UserDefaults.standard.set(successResponse.data.extra.JobVec, forKey: "vacan")
//                UserDefaults.standard.set(successResponse.data.extra.JobLoc, forKey: "loc")
//                UserDefaults.standard.set(successResponse.data.extra.JobSkill, forKey: "skil")
//                UserDefaults.standard.set(successResponse.data.extra.tag, forKey: "tag")
                
            }
            else {
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
            }
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func nokri_appearance(){
        var preferredStatusBarStyle: UIStatusBarStyle {
              return .lightContent
        }        //->> Tab bar
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        let colorNormal : UIColor = UIColor(hex: "101024 ")
        let colorSelected : UIColor = UIColor.white
        let titleFontNormal : UIFont = UIFont(name: "Helvetica", size: 12.0)!
        let titleFontSelected : UIFont = UIFont.boldSystemFont(ofSize: 15.0)
        let attributesNormal = [
            NSAttributedString.Key.foregroundColor : colorNormal,
            NSAttributedString.Key.font : titleFontNormal
        ]
        
        let attributesSelected = [
            NSAttributedString.Key.foregroundColor : colorSelected,
            NSAttributedString.Key.font : titleFontSelected
        ]
        
        UITabBarItem.appearance().setTitleTextAttributes(attributesNormal, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(attributesSelected, for: .selected)
        UITabBar.appearance().unselectedItemTintColor = .black
        //tabBarItem.image = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
    }

    //MARK:- API Calls
    
    func nokri_signUpData() {
        UserHandler.nokri_signUpData(success: { (successResponse) in
            if successResponse.success {
                UserHandler.sharedInstance.objUser = successResponse.data
                UserDefaults.standard.set(UserHandler.sharedInstance.objUser?.switchCand, forKey: "cand")
                UserDefaults.standard.set(UserHandler.sharedInstance.objUser?.switchEmp, forKey: "comp")
                self.stopAnimating()
            }
            else {
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
            }
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
