//
//  UIViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/10/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//
import Foundation
import UIKit
import NVActivityIndicatorView


  let appDelegate = UIApplication.shared.delegate as! AppDelegate

extension UIViewController:NVActivityIndicatorViewable{
    
    
    func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showLoader(){
        self.startAnimating(Constants.activitySize.size, message: Constants.loaderMessages.loadingMessage.rawValue,messageFont: UIFont.systemFont(ofSize: 14), type: NVActivityIndicatorType.orbit)
    }
    
}

extension UIViewController {
    
   
    
    func hideBackButton() {
        self.navigationItem.hidesBackButton = true
    }
    
    func showBackButton() {
        self.hideBackButton()
        let backButton = UIButton(type: .custom)
        backButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        if UserDefaults.standard.bool(forKey: "isRtl") {
            backButton.setBackgroundImage(UIImage(named: "LeftNarrow"), for: .normal)
        } else {
            backButton.setBackgroundImage(UIImage(named: "LeftNarrow"), for: .normal)
        }
        backButton.addTarget(self, action: #selector(onBackButtonClciked), for: .touchUpInside)
        let backBarButton = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backBarButton
    }
    
    func showSearchButton() {
        self.hideBackButton()
        let backButton = UIButton(type: .custom)
        backButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        if UserDefaults.standard.bool(forKey: "isRtl") {
            backButton.setBackgroundImage(UIImage(named: "searchWhite"), for: .normal)
        } else {
            backButton.setBackgroundImage(UIImage(named: "searchWhite"), for: .normal)
        }
        backButton.addTarget(self, action: #selector(onSearchButtonClciked), for: .touchUpInside)
        let backBarButton = UIBarButtonItem(customView: backButton)
        self.navigationItem.rightBarButtonItem = backBarButton
    }
    
    @objc func onBackButtonClciked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func onSearchButtonClciked() {
        //appDelegate.nokri_moveToAdvanceSearch()
        //let ctrl = AdvanceSearchViewController()
        //self.navigationController?.pushViewController(ctrl, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AdvanceSearchViewController") as! AdvanceSearchViewController
        //vc.newsObj = newsObj
        navigationController?.pushViewController(vc,
                                                 animated: false)
        
        
    }
}


extension Dictionary {
    mutating func merge(with dictionary: Dictionary) {
        dictionary.forEach { updateValue($1, forKey: $0) }
    }
    
    func merged(with dictionary: Dictionary) -> Dictionary {
        var dict = self
        dict.merge(with: dictionary)
        return dict
    }
}

extension Array where Element: Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        if let index = firstIndex(of: object) {
            remove(at: index)
        }
    }
}
