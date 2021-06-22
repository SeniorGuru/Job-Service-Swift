//
//  JobAlertTableViewController.swift
//  Nokri
//
//  Created by apple on 3/26/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit
import DropDown
import JGProgressHUD

class JobAlertTableViewController: UITableViewController {
    
    @IBOutlet weak var lblJobAlert: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblAlertName: UILabel!
    @IBOutlet weak var txtFieldAlertName: UITextField!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblSelectEmailFreq: UILabel!
    @IBOutlet weak var btnEmailFreq: UIButton!
    @IBOutlet weak var lblJobCategory: UILabel!
    @IBOutlet weak var btnJobCategory: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var lblJobExp: UILabel!
    @IBOutlet weak var btnJobExp: UIButton!
    @IBOutlet weak var lblJobType: UILabel!
    @IBOutlet weak var btnJobtype: UIButton!
    @IBOutlet weak var heightConstFreq: NSLayoutConstraint!
    @IBOutlet weak var heightConstCat: NSLayoutConstraint!
    @IBOutlet weak var heightConstExp: NSLayoutConstraint!
    @IBOutlet weak var heightConstType: NSLayoutConstraint!
    
    @IBOutlet weak var viewCat: UIView!
    @IBOutlet weak var viewExp: UIView!
    @IBOutlet weak var viewType: UIView!
    @IBOutlet weak var viewFreq: UIView!
    
    
    
    var dropDownJobType = DropDown()
    var dropDownJobExp = DropDown()
    var dropDownFreq = DropDown()
    var dropDownFreqInt = 0
    var dropDownJobExpInt = 0
    var dropDownJobTypeInt = 0
    var catInt = 0
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var jobFrequencyKey = [Int]()
    var jobFrequencyValue = [String]()
    var jobCatArr = [String]()
    var childArr = [Bool]()
    var keyArray = [Int]()
    var jobtypeKey = [Int]()
    var jobtypeValuerr = [String]()
    var jobExpKeyArr = [Int]()
    var jobExpValArr = [String]()
    var jobExpText = ""
    var jobTypeText = ""
    
    var jobCatArr2 = [String]()
    var childArr2 = [Bool]()
    var keyArray2 = [Int]()
    
    var isShowCategory = "false"
    var isShowjobType = "false"
    var isShowExp = "false"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnSubmit.backgroundColor = UIColor(hex: appColorNew!)
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            lblJobAlert.text = "Job alerts"//dataTabs.data.extra.jobalert
            lblDetail.text = dataTabs.data.extra.jobalertdetail
            lblEmail.text = dataTabs.data.extra.yourEmail
            txtEmail.placeholder = dataTabs.data.extra.yourEmail
            lblAlertName.text = dataTabs.data.extra.alertName
            txtFieldAlertName.placeholder = dataTabs.data.extra.alertName
            lblSelectEmailFreq.text = dataTabs.data.extra.selectEmailFreq
            lblJobCategory.text = dataTabs.data.extra.jobCat
            self.title = "Job alerts"//dataTabs.data.extra.jobalert
            btnSubmit.setTitle(dataTabs.data.feedBackSaplash.data.btnSubmit, for: .normal)
        }
        lblJobExp.text = jobExpText
        lblJobType.text = jobTypeText
        //txtEmail.layer.borderColor = UIColor.lightGray.cgColor
        //txtFieldAlertName.layer.borderColor = UIColor.lightGray.cgColor
        viewCat.layer.cornerRadius = 5
        viewExp.layer.cornerRadius = 5
        viewType.layer.cornerRadius = 5
        viewFreq.layer.cornerRadius = 5
        btnSubmit.layer.cornerRadius = 5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let catName  = UserDefaults.standard.string(forKey: "caName")
        let cat2Name  = UserDefaults.standard.string(forKey: "caName")
        let cat3Name  = UserDefaults.standard.string(forKey: "caName")
        let cat4Name  = UserDefaults.standard.string(forKey: "caName")
        let catKey = UserDefaults.standard.integer(forKey: "caKey")
        let cat2Key = UserDefaults.standard.integer(forKey: "ca2Key")
        let cat3Key = UserDefaults.standard.integer(forKey: "ca3Key")
        let cat4Key = UserDefaults.standard.integer(forKey: "ca4Key")
       
        btnJobCategory.setTitle(catName, for: .normal)
        btnJobCategory.setTitle(cat2Name, for: .normal)
        btnJobCategory.setTitle(cat3Name, for: .normal)
        btnJobCategory.setTitle(cat4Name, for: .normal)
      
        if catKey != 0 {
             btnJobCategory.tag = catKey
        }
        if cat2Key != 0 {
             btnJobCategory.tag = cat2Key
        }
        if cat3Key != 0 {
            btnJobCategory.tag = cat3Key
        }
        if cat4Key != 0 {
            btnJobCategory.tag = cat4Key
        }
        
        
        dropDownFreq.anchorView = btnEmailFreq
        dropDownJobExp.anchorView = btnJobExp
        dropDownJobType.anchorView = btnJobtype
        
        if isShowCategory == "false"{
            heightConstCat.constant = 0
            viewCat.isHidden = true
        }
        if isShowExp == "false"{
            heightConstExp.constant = 0
            viewExp.isHidden = true
        }
        if isShowjobType == "false"{
            heightConstType.constant = 0
            viewType.isHidden = true
        }
        
        
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    @IBAction func btnEmailFreqClicked(_ sender: UIButton) {
        dropDownFreq.anchorView = btnEmailFreq
        dropDownFreq.dataSource = jobFrequencyValue
        dropDownFreq.show()
        print(jobFrequencyValue)
        dropDownFreq.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.btnEmailFreq.setTitle(item, for: .normal)
            self.dropDownFreqInt = self.jobFrequencyKey[index]
        }
    }
    
    @IBAction func btnJobCatClicked(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "JobCatOneViewController") as? JobCatOneViewController
        vc!.jobCatArr = jobCatArr
        vc!.childArr = childArr
        vc!.keyArray = keyArray
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func btnJobExpClicked(_ sender: UIButton) {
        dropDownJobExp.anchorView = btnJobExp
        dropDownJobExp.dataSource = jobExpValArr
        print(jobExpValArr)
        dropDownJobExp.show()
        dropDownJobExp.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.btnJobExp.setTitle(item, for: .normal)
            self.dropDownJobExpInt = self.jobExpKeyArr[index]
        }
    }
    
    @IBAction func btnJobTypeClicked(_ sender: UIButton) {
        dropDownJobType.anchorView = btnJobtype
        dropDownJobType.dataSource = jobtypeValuerr
        dropDownJobType.show()
        dropDownJobType.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.btnJobtype.setTitle(item, for: .normal)
            self.dropDownJobTypeInt = self.jobExpKeyArr[index]
        }
    }
    
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        
        var field:String = ""
        var validEmail:String = ""
        
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            field = dataTabs.data.extra.allField
            validEmail = dataTabs.data.extra.validEmail
        }
        
        if txtFieldAlertName.text == ""{
            let alert = Constants.showBasicAlert(message: field)
            self.present(alert, animated: true, completion: nil)
        }else if txtEmail.text == ""{
            let alert = Constants.showBasicAlert(message: field)
            self.present(alert, animated: true, completion: nil)
        }else if isValidEmail(testStr: txtEmail.text!) == false{
            let alert = Constants.showBasicAlert(message: validEmail)
            self.present(alert, animated: true, completion: nil)
        }else{
            let param: [String: Any] = [
                "alert_email": txtEmail.text!,
                "alert_name": txtFieldAlertName.text!,
                "alert_frequency": dropDownFreqInt,
                "alert_type": dropDownJobTypeInt,
                "alert_experience": dropDownJobExpInt,
                "alert_category": btnJobCategory.tag
            ]
            print(param)
            self.nokri_EmailAlertPost(parameter: param as NSDictionary)
            //job_alert_subsucription
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    func nokri_EmailAlertPost(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_EmailAlertPost(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true{
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
            }
            else {
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
                self.stopAnimating()
            }
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
    
}


