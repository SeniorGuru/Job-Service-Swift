//
//  CustomStaticeRegisterTableViewCell.swift
//  Nokri
//
//  Created by apple on 2/18/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit
import TextFieldEffects
import TTSegmentedControl


protocol registerStaticHeader {
    func registerStaticHeader(txtName:String,txtEmail:String,txtPass:String,segmentValue:String)
}

class CustomStaticeRegisterTableViewCell: UITableViewCell,UITextFieldDelegate {
    
    
    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var segmentedControl: TTSegmentedControl!
    
    var delegate : registerStaticHeader?
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var defSegmentVal = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        segmentedControl.itemTitles = ["Candidate","Company"]
        segmentedControl.layer.cornerRadius = 3
        segmentedControl.thumbGradientColors = [UIColor(hex:appColorNew!), UIColor(hex:appColorNew!)]
        UserDefaults.standard.set("0", forKey: "candidateV")
        segmentedControl.didSelectItemWith = { (index, title) -> () in
            print("Selected item \(index)")
            if index == 0{
                UserDefaults.standard.set("0", forKey: "candidateV")
                //self.type = "0"
                UserDefaults.standard.set("0", forKey: "signUp")
                self.delegate?.registerStaticHeader(txtName: self.txtName.text!, txtEmail: self.txtEmail.text!, txtPass: self.txtPassword.text!, segmentValue: "0")
            }else{
                //self.type = "1"
                UserDefaults.standard.set("1", forKey: "candidateV")
                UserDefaults.standard.set("1", forKey: "signUp")
                self.delegate?.registerStaticHeader(txtName: self.txtName.text!, txtEmail: self.txtEmail.text!, txtPass: self.txtPassword.text!, segmentValue: "1")
            }
        }
        viewEmail.layer.cornerRadius = 20
        viewPassword.layer.cornerRadius = 20
        viewName.layer.cornerRadius = 20
        viewEmail.layer.borderWidth = 1
        viewPassword.layer.borderWidth = 1
        viewName.layer.borderWidth = 1
        viewEmail.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        viewPassword.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        viewName.layer.borderColor = UIColor.groupTableViewBackground.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    //MARK:- TextField Delegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtName {
            //txtName.nokri_updateBottomBorderColor(isTextFieldSelected: true)
            viewName.layer.borderWidth = 1
            viewName.layer.borderColor = UIColor(hex: appColorNew!).cgColor
        } else {
            //txtName.nokri_updateBottomBorderColor(isTextFieldSelected: false)
            viewName.layer.borderWidth = 1
            viewName.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        }
        if textField == txtEmail {
            //txtEmail.nokri_updateBottomBorderColor(isTextFieldSelected: true)
            viewEmail.layer.borderWidth = 1
            viewEmail.layer.borderColor = UIColor(hex: appColorNew!).cgColor
        } else {
            //txtEmail.nokri_updateBottomBorderColor(isTextFieldSelected: false)
            viewEmail.layer.borderWidth = 1
            viewEmail.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        }
        
        if textField == txtPassword {
            viewPassword.layer.borderWidth = 1
            viewPassword.layer.borderColor = UIColor(hex: appColorNew!).cgColor
            //txtPassword.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            //txtPassword.nokri_updateBottomBorderColor(isTextFieldSelected: false)
            viewPassword.layer.borderWidth = 1
            viewPassword.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    
    @IBAction func txtNameChanged(_ sender: Any) {
        let segVal = UserDefaults.standard.string(forKey: "candidateV")
        self.delegate?.registerStaticHeader(txtName: self.txtName.text!, txtEmail: self.txtEmail.text!, txtPass: self.txtPassword.text!, segmentValue: segVal!)
    }
    
    @IBAction func txtEmailChanged(_ sender: Any) {
        let segVal = UserDefaults.standard.string(forKey: "candidateV")
        self.delegate?.registerStaticHeader(txtName: self.txtName.text!, txtEmail: self.txtEmail.text!, txtPass: self.txtPassword.text!, segmentValue: segVal!)
    }
    
    @IBAction func txtPassChanged(_ sender: Any) {
        let segVal = UserDefaults.standard.string(forKey: "candidateV")
        self.delegate?.registerStaticHeader(txtName: self.txtName.text!, txtEmail: self.txtEmail.text!, txtPass: self.txtPassword.text!, segmentValue: segVal!)
    }
    
    
}
