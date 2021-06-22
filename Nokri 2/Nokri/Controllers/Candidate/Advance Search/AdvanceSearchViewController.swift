//
//  AdvanceSearchViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/30/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import DropDown
import Alamofire
import JGProgressHUD

class AdvanceSearchViewController: UITableViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    //MARK:- IBOutlets

    @IBOutlet weak var viewJobCategory: UIView!
    @IBOutlet weak var viewSubCat: UIView!
    @IBOutlet weak var viewSubCatTwo: UIView!
    @IBOutlet weak var ViewSubCatThree: UIView!
    @IBOutlet weak var viewJobQualification: UIView!
    @IBOutlet weak var viewJobType: UIView!
    @IBOutlet weak var viewSalaryCurrency: UIView!
    @IBOutlet weak var viewJobShift: UIView!
    @IBOutlet weak var viewJobLevel: UIView!
    @IBOutlet weak var viewJobSkill: UIView!
    @IBOutlet weak var btnSearchNow: UIButton!
    @IBOutlet weak var txtFieldSearch: UITextField!
    @IBOutlet weak var btnSearchKeyword: UIButton!
    @IBOutlet weak var lblJobCategoryKey: UILabel!
    @IBOutlet weak var lblJobQualificationKey: UILabel!
    @IBOutlet weak var lblJobTypeKey: UILabel!
    @IBOutlet weak var lblSalaryCurencyKey: UILabel!
    @IBOutlet weak var lblJobShiftKey: UILabel!
    @IBOutlet weak var lblJoblevelKey: UILabel!
    @IBOutlet weak var lblJobSkillKey: UILabel!
    @IBOutlet weak var lblSearchNow: UILabel!
    @IBOutlet weak var lblSubCatKey: UILabel!
    @IBOutlet weak var lblJobCategoryValue: UILabel!
    @IBOutlet weak var lblJobQualificationValue: UILabel!
    @IBOutlet weak var lblJobTypeValue: UILabel!
    @IBOutlet weak var lblSalaryCurencyValue: UILabel!
    @IBOutlet weak var lblJobShiftValue: UILabel!
    @IBOutlet weak var lblJoblevelValue: UILabel!
    @IBOutlet weak var lblJobSkillValue: UILabel!
    @IBOutlet weak var lblSubCatValue: UILabel!
    @IBOutlet weak var lblSubCatTwoKey: UILabel!
    @IBOutlet weak var lblSubCatValueTwo: UILabel!
    @IBOutlet weak var btnSubCatTwoClicked: UIButton!
    @IBOutlet weak var lblSubCatThreeKey: UILabel!
    @IBOutlet weak var lblSubCatThreeValue: UILabel!
    @IBOutlet weak var btnSubCatThree: UIButton!
    @IBOutlet weak var heightConstraintSubCatView: NSLayoutConstraint!
    @IBOutlet weak var topConstraintViewQualification: NSLayoutConstraint!
    @IBOutlet weak var btnDropDownJobCategory: UIButton!
    @IBOutlet weak var btnDropDownJobQualification: UIButton!
    @IBOutlet weak var btnDropDownJobType: UIButton!
    @IBOutlet weak var btnDropDownSalaryCurrency: UIButton!
    @IBOutlet weak var btnDropDownJobShift: UIButton!
    @IBOutlet weak var btnDropDownJobLevel: UIButton!
    @IBOutlet weak var btnDropDownJobSkill: UIButton!
    @IBOutlet weak var btnDropDownSubCategory: UIButton!
    @IBOutlet weak var iconJobCat: UIImageView!
    @IBOutlet weak var iconJobSubCat: UIImageView!
    @IBOutlet weak var iconJobSubCatTwo: UIImageView!
    @IBOutlet weak var iconJobSubCatThree: UIImageView!
    @IBOutlet weak var iconQulification: UIImageView!
    @IBOutlet weak var iconJobType: UIImageView!
    @IBOutlet weak var iconSalaryCurrency: UIImageView!
    @IBOutlet weak var iconJobShift: UIImageView!
    @IBOutlet weak var iconJobLevel: UIImageView!
    @IBOutlet weak var iconJobSkill: UIImageView!
    @IBOutlet weak var viewSearchKeyWord: UIView!
    
    @IBOutlet weak var viewCCS: UIView!
    @IBOutlet weak var viewCountry: UIView!
    @IBOutlet weak var viewState: UIView!
    @IBOutlet weak var viewCity: UIView!
    @IBOutlet weak var viewTown: UIView!
    @IBOutlet weak var lblCountryKey: UILabel!
    @IBOutlet weak var lblCountryValue: UILabel!
    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var lblStateKey: UILabel!
    @IBOutlet weak var lblStateValue: UILabel!
    @IBOutlet weak var btnState: UIButton!
    @IBOutlet weak var lblCityKey: UILabel!
    @IBOutlet weak var lblCityValue: UILabel!
    @IBOutlet weak var btnCity: UIButton!
    @IBOutlet weak var lblTownKey: UILabel!
    @IBOutlet weak var lblTownValue: UILabel!
    @IBOutlet weak var btnTown: UIButton!
    @IBOutlet weak var heightConstraintCCT: NSLayoutConstraint!
    @IBOutlet weak var heightConstraintView: NSLayoutConstraint!
    @IBOutlet weak var heightContraintMain: NSLayoutConstraint!
    @IBOutlet weak var iconCountry: UIImageView!
    @IBOutlet weak var iconState: UIImageView!
    @IBOutlet weak var iconCity: UIImageView!
    @IBOutlet weak var iconTown: UIImageView!
    
    //MARK:- Proporties
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    let dropDownJobCategory = DropDown()
    let dropDownJobQualification = DropDown()
    let dropDownJobType = DropDown()
    let dropDownSalaryCurrency = DropDown()
    let dropDownJobShift = DropDown()
    let dropDownJobLevel = DropDown()
    let dropDownJobSkill = DropDown()
    let dropDownSubCategory = DropDown()
    let dropDownSubCategoryTwo = DropDown()
    let dropDownSubCategoryThree = DropDown()
    let dropDownSubCategoryFour = DropDown()
    let dropDownCountry = DropDown()
    var dropDownState = DropDown()
    let dropDownCity = DropDown()
    let dropDownTown = DropDown()

    var searchField = [AdvanceSearchField]()
    var valueArray = [AdvanceValue]()
    var extraArray = [AdvanceSearchExtra]()
    var selectOption:String?
    var subCategoryArray = NSMutableArray()
    var subCategoryArrayTwo = NSMutableArray()
    var subCategoryArrayThree = NSMutableArray()
    var jobsArray = NSMutableArray()
    var message:String?
    
    var countryInt:Int?
    var stateInt:Int?
    var cityInt:Int?
    var townInt:Int?
    var categoryArray = [String]()
    var statArray = NSMutableArray()
    var cityArray = NSMutableArray()
    var townArray = NSMutableArray()
   
    var isCountry:Bool = false
    var isState:Bool = false
    var isCity:Bool = false
    var isTown:Bool = false
    var isShow2:Bool?
    var isShow:Bool?
    var isShowSecond:Bool?
    var isShowSec:Bool?
    var isShowThird:Bool?
    var isShowThi:Bool?
    
    var isQulificaton:Bool = false
    var isJobCat:Bool = false
    var isSubCat:Bool = false
    var isSubCatTwo:Bool = false
    var isSubCatThree:Bool = false
    var isSalarCurrency:Bool = false
    var isJobShift:Bool = false
    var isjobType:Bool = false
    var isJobLevel:Bool = false
    var isSkill:Bool = false

    var qualificationInt = 0
    var jobCatInt = 0
    var subCatInt = 0
    var subCatTwoInt = 0
    var subCatThreeInt = 0
    var salarCurrencyInt = 0
    var jobShiftInt = 0
    var jobTypeInt = 0
    var jobLevelInt = 0
    var skillInt = 0
    var nextPage:Int?
    var hasNextPage:Bool?
    var noOfJobs = ""
    var jobCategoreisArray = NSMutableArray()
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
    
    @IBOutlet weak var collectionViewJobShift: UICollectionView!
    var jobShiftKey = [Int]()
    var jobshiftValuerr = [String]()
    @IBOutlet weak var collectionViewJobType: UICollectionView!
    var jobtypeKey = [Int]()
    var jobtypeValuerr = [String]()
    let resultButton = UIButton()
    
    var jobFrequencyKey = [Int]()
    var jobFrequencyValue = [String]()
    var barButtonItems = [UIBarButtonItem]()
    var jobExpKeyArr = [Int]()
    var jobExpValArr = [String]()
    var jobExpTxt = ""
    var jobTypeText = ""
    
    var isAlertShow = "true"
    var isShowJobCat = "true"
    var isShowJobType = "true"
    var isShowJobExp = "true"
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewJobShift.delegate = self
        collectionViewJobShift.dataSource = self
        collectionViewJobType.delegate = self
        collectionViewJobType.dataSource = self
        nokri_ltrRtl()
      //dropDownSetup()
      //nokri_viewShadow()
      //self.showBackButton()
        nokri_advanceSearchData()
        nokri_boolChecks()
        nokri_dropDownIcons()
        heightConstraintSubCatView.constant = 0
      //btnSearchNow.backgroundColor = UIColor(hex: appColorNew!)
        btnSearchKeyword.backgroundColor = UIColor(hex: appColorNew!)
        heightConstraintCCT.constant -= 180
        addResultButtonView()
        viewSearchKeyWord.layer.borderWidth = 2
        viewSearchKeyWord.layer.borderColor = UIColor.groupTableViewBackground.cgColor
       // showSearchButton()
        refreshButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.txtFieldSearch.text! = ""
       
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let obj = dataTabs.data.guestTabs
            self.navigationController?.navigationBar.topItem?.title = obj?.explore
        }
        
        
        let catName  = UserDefaults.standard.string(forKey: "caName")
        let cat2Name  = UserDefaults.standard.string(forKey: "caName")
        let cat3Name  = UserDefaults.standard.string(forKey: "caName")
        let cat4Name  = UserDefaults.standard.string(forKey: "caName")
        let catKey = UserDefaults.standard.integer(forKey: "caKey")
        let cat2Key = UserDefaults.standard.integer(forKey: "ca2Key")
        let cat3Key = UserDefaults.standard.integer(forKey: "ca3Key")
        let cat4Key = UserDefaults.standard.integer(forKey: "ca4Key")
        dropDownJobCategory.tag = catKey
        self.lblJobCategoryValue.text = catName
        dropDownJobCategory.tag = cat2Key
        self.lblJobCategoryValue.text = cat2Name
        dropDownJobCategory.tag = cat3Key
        self.lblJobCategoryValue.text = cat3Name
        dropDownJobCategory.tag = cat4Key
        self.lblJobCategoryValue.text = cat4Name

        let cotName  = UserDefaults.standard.string(forKey: "coName")
        let cot2Name  = UserDefaults.standard.string(forKey: "coName")
        let cot3Name  = UserDefaults.standard.string(forKey: "coName")
        let cot4Name  = UserDefaults.standard.string(forKey: "coName")
        let cotKey = UserDefaults.standard.integer(forKey: "coKey")
        let cot2Key = UserDefaults.standard.integer(forKey: "co2Key")
        let cot3Key = UserDefaults.standard.integer(forKey: "co3Key")
        let cot4Key = UserDefaults.standard.integer(forKey: "co4Key")
        dropDownCountry.tag = cotKey
        self.lblCountryValue.text = cotName
        dropDownCountry.tag = cot2Key
        self.lblCountryValue.text = cot2Name
        dropDownCountry.tag = cot3Key
        self.lblCountryValue.text = cot3Name
        dropDownCountry.tag = cot4Key
        self.lblCountryValue.text = cot4Name
        

    }
    
    func nokri_ltrRtl(){
        let isRtl = UserDefaults.standard.string(forKey: "isRtl")
        if isRtl == "0"{
            self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }else{
            self.addRightBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }
    }

    func refreshButton() {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(#imageLiteral(resourceName: "refresh"), for: .normal)
        if #available(iOS 11, *) {
            button.widthAnchor.constraint(equalToConstant: 20).isActive = true
            button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        }
        else {
            button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        }
        button.addTarget(self, action: #selector(onClickRefreshButton), for: .touchUpInside)
        
        let barButton = UIBarButtonItem(customView: button)
        barButtonItems.append(barButton)
        
        
        let type = UserDefaults.standard.string(forKey: "usrTyp")
        
        if type == "0"{
        let button2 = UIButton(type: .custom)
        button2.setBackgroundImage(#imageLiteral(resourceName: "notification"), for: .normal)
        if #available(iOS 11, *) {
            button2.widthAnchor.constraint(equalToConstant: 20).isActive = true
            button2.heightAnchor.constraint(equalToConstant: 20).isActive = true
        }
        else {
            button2.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        }
        button2.addTarget(self, action: #selector(btnAlertClick), for: .touchUpInside)
        
        let barButton2 = UIBarButtonItem(customView: button2)
        barButtonItems.append(barButton2)
        }
       
         self.navigationItem.rightBarButtonItems = barButtonItems
    }
    
    @objc func onClickRefreshButton() {
        nokri_advanceSearchData()
    }
    
    @objc func btnAlertClick() {
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "JobAlertTableViewController") as! JobAlertTableViewController
        
        var jobCatArr = [String]()
        var keyArray = [Int]()
        var childArr = [Bool]()
        for obj in searchField{
            if obj.fieldTypeName == "job_category"{
                lblJobCategoryKey.text = obj.key
                //lblJobCategoryValue.text = obj.column
                selectOption = obj.column
                valueArray = obj.valueAr
                for innerObj in valueArray{
                    jobCatArr.append(innerObj.value)
                    keyArray.append(innerObj.key)
                    childArr.append(innerObj.hasChild)
                }
            }
        }
        
        nextViewController.jobCatArr = jobCatArr
        nextViewController.childArr = childArr
        nextViewController.keyArray = keyArray
        nextViewController.jobFrequencyKey = jobFrequencyKey
        nextViewController.jobFrequencyValue = jobFrequencyValue
        nextViewController.jobtypeKey = jobtypeKey
        nextViewController.jobtypeValuerr = jobtypeValuerr
        nextViewController.jobExpKeyArr = jobExpKeyArr
        nextViewController.jobExpValArr = jobExpValArr
        nextViewController.jobExpText = jobExpTxt
        nextViewController.jobTypeText = jobTypeText
        nextViewController.isShowExp = isShowJobExp
        nextViewController.isShowjobType = isShowJobType
        nextViewController.isShowCategory = isShowJobCat
        
        
        var countryKey = [Int]()
               var childArrr = [Bool]()
               for obj in searchField{
                   if obj.fieldTypeName == "job_location"{
                       categoryArray.removeAll()
                       valueArray = obj.valueAr
                       for innerObj in valueArray{
                           categoryArray.append(innerObj.value)
                           countryKey.append(innerObj.key)
                           childArrr.append(innerObj.hasChild)
                       }
                   }
                   //categoryArray.removeAll()
               }
        
        nextViewController.jobCatArr2 = categoryArray
        nextViewController.childArr2 = childArrr
        nextViewController.keyArray2 = countryKey
        
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
    //MARK:- IBAction
  
    @IBAction func btnDropDownJobCategoryClicked(_ sender: UIButton) {
       // dropDownJobCategory.show()
        
        
        var jobCatArr = [String]()
        var keyArray = [Int]()
        var childArr = [Bool]()
        for obj in searchField{
            if obj.fieldTypeName == "job_category"{
                lblJobCategoryKey.text = obj.key
                //lblJobCategoryValue.text = obj.column
                selectOption = obj.column
                valueArray = obj.valueAr
                for innerObj in valueArray{
                    jobCatArr.append(innerObj.value)
                    keyArray.append(innerObj.key)
                    childArr.append(innerObj.hasChild)
                   
                }
            }
        }
        
        
  
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "JobCatOneViewController") as? JobCatOneViewController

        vc!.jobCatArr = jobCatArr
        vc!.childArr = childArr
        vc!.keyArray = keyArray


        self.navigationController?.pushViewController(vc!, animated: true)

    }
    
    @IBAction func btnDropDownSubCatClicked(_ sender: UIButton) {
        dropDownSubCategoryTwo.show()
    }
    
    @IBAction func dropDownSubCatTwoClicked(_ sender: UIButton) {
    dropDownSubCategoryThree.show()
    }
    
    @IBAction func dropDownSubCatThreeClicked(_ sender: UIButton) {
        dropDownSubCategoryFour.show()
    }
    
    @IBAction func btnDropDownJobQualificationClicked(_ sender: UIButton) {
        dropDownJobQualification.show()
    }
    
    @IBAction func btnDropDownJobTypeClicked(_ sender: UIButton) {
        dropDownJobType.show()
    }
    
    @IBAction func btnDropDownSalaryCurrencyClicked(_ sender: UIButton) {
        dropDownSalaryCurrency.show()
    }
    
    @IBAction func btnDropDownJobShiftClicked(_ sender: UIButton) {
        dropDownJobShift.show()
    }
    
    @IBAction func btnDropDownJobLevelClicked(_ sender: UIButton) {
        dropDownJobLevel.show()
    }
    
    @IBAction func btnDropDownJobSkillClicked(_ sender: UIButton) {
        dropDownJobSkill.show()
    }
    
    @IBAction func btnSearchKeywordClicked(_ sender: UIButton) {
        nokri_jobData()
    }
    
    @IBAction func btnSearchNowClicked(_ sender: UIButton) {
        nokri_jobDataWithFilters()
    }
    
    @IBAction func btnCountryClicked(_ sender: UIButton) {
        //dropDownCountry.show()
        
        var countryKey = [Int]()
        var childArrr = [Bool]()
        for obj in searchField{
            if obj.fieldTypeName == "job_location"{
                categoryArray.removeAll()
                valueArray = obj.valueAr
                for innerObj in valueArray{
                    categoryArray.append(innerObj.value)
                    countryKey.append(innerObj.key)
                    childArrr.append(innerObj.hasChild)
                }
            }
            //categoryArray.removeAll()
        }
        
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "JobPostCountryViewController") as? JobPostCountryViewController
        
        vc!.jobCatArr = categoryArray
        vc!.childArr = childArrr
        vc!.keyArray = countryKey
        
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func btnStateClicked(_ sender: UIButton) {
        dropDownState.show()
    }
    
    @IBAction func btnCityClicked(_ sender: UIButton) {
        dropDownCity.show()
    }
    
    @IBAction func btnTownClicked(_ sender: UIButton) {
        dropDownTown.show()
    }
    
    
    private func addResultButtonView() {
        
        
        resultButton.backgroundColor = UIColor(hex: appColorNew!)
        
        tableView.addSubview(resultButton)
        
        // set position
        resultButton.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            resultButton.leftAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.leftAnchor).isActive = true
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 11.0, *) {
            resultButton.rightAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.rightAnchor).isActive = true
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 11.0, *) {
            resultButton.bottomAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 11.0, *) {
            resultButton.widthAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.widthAnchor).isActive = true
        } else {
            // Fallback on earlier versions
        }
        resultButton.heightAnchor.constraint(equalToConstant: 50).isActive = true // specify the height of the view
        
      resultButton.addTarget(self, action:  #selector(AdvanceSearchViewController.nokri_SearchClicked), for: .touchUpInside)
    }
    
    @objc func nokri_SearchClicked(_ sender: UIButton){
      nokri_jobDataWithFilters()
    }

    //-->>> Collection vIEW
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewJobShift{
            return jobShiftKey.count
        }
       else{
            return jobtypeKey.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionViewJobShift{
            let cell = collectionViewJobShift.dequeueReusableCell(withReuseIdentifier: "JobShiftCollectionViewCell", for: indexPath) as! JobShiftCollectionViewCell
            
            cell.tag = jobShiftKey[indexPath.row]
            cell.lblJobShiftValue.text = jobshiftValuerr[indexPath.row]
            cell.lblJobShiftValue.layer.borderWidth = 1
            cell.lblJobShiftValue.layer.borderColor = UIColor(hex: appColorNew!).cgColor
            return cell
        }
        else  {
            let cell = collectionViewJobType.dequeueReusableCell(withReuseIdentifier: "JobTypeCollectionViewCell", for: indexPath) as! JobTypeCollectionViewCell
            
            cell.tag = jobtypeKey[indexPath.row]
            cell.lblJobtypeValue.text = jobtypeValuerr[indexPath.row]
            cell.lblJobtypeValue.layer.borderWidth = 1
            cell.lblJobtypeValue.layer.borderColor = UIColor(hex: appColorNew!).cgColor
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView.isDragging {
            cell.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 0.8, animations: {
                cell.transform = CGAffineTransform.identity
            })
        }
    }
    
//    @objc func nokri_jobShiftClicked(_ sender: UIButton){
//        print(sender.tag)
//        jobShiftInt = sender.tag
//
//        if sender.tag == jobShiftInt{
//            sender.layer.borderWidth = 0
//            sender.layer.borderColor = UIColor(hex: appColorNew!).cgColor
//        }else{
//            sender.layer.borderWidth = 1
//            sender.layer.borderColor = UIColor(hex: appColorNew!).cgColor
//        }
//
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
   
        if collectionView == collectionViewJobShift{
            let cell = collectionView.cellForItem(at: indexPath) as! JobShiftCollectionViewCell
            jobShiftInt = cell.tag
            self.isJobShift = true
            cell.lblJobShiftValue.layer.borderWidth = 3
            cell.lblJobShiftValue.layer.borderColor = UIColor(hex: appColorNew!).cgColor
            print(jobShiftInt)

        }else{
            let cell = collectionView.cellForItem(at: indexPath) as! JobTypeCollectionViewCell
            jobTypeInt = cell.tag
            self.isjobType = true
            cell.lblJobtypeValue.layer.borderWidth = 3
            cell.lblJobtypeValue.layer.borderColor = UIColor(hex: appColorNew!).cgColor
            print(jobTypeInt)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if collectionView == collectionViewJobShift{
            let cell = collectionView.cellForItem(at: indexPath) as! JobShiftCollectionViewCell
            cell.lblJobShiftValue.layer.borderWidth = 1
            cell.lblJobShiftValue.layer.borderColor = UIColor(hex: appColorNew!).cgColor
        }else{
            let cell = collectionView.cellForItem(at: indexPath) as! JobTypeCollectionViewCell
            cell.lblJobtypeValue.layer.borderWidth = 1
            cell.lblJobtypeValue.layer.borderColor = UIColor(hex: appColorNew!).cgColor
        }

    }
    
    //MARK:- Custome Functions
    
    func nokri_dropDownIcons(){
        iconJobCat.image = iconJobCat.image?.withRenderingMode(.alwaysTemplate)
        iconJobCat.tintColor = UIColor(hex: appColorNew!)
        iconJobSubCat.image = iconJobSubCat.image?.withRenderingMode(.alwaysTemplate)
        iconJobSubCat.tintColor = UIColor(hex: appColorNew!)
        iconJobSubCatTwo.image = iconJobSubCatTwo.image?.withRenderingMode(.alwaysTemplate)
        iconJobSubCatTwo.tintColor = UIColor(hex:appColorNew!)
        iconJobSubCatThree.image = iconJobSubCatThree.image?.withRenderingMode(.alwaysTemplate)
        iconJobSubCatThree.tintColor = UIColor(hex: appColorNew!)
        iconQulification.image = iconQulification.image?.withRenderingMode(.alwaysTemplate)
        iconQulification.tintColor = UIColor(hex: appColorNew!)
        //iconJobType.image = iconJobType.image?.withRenderingMode(.alwaysTemplate)
        //iconJobType.tintColor = UIColor(hex: appColorNew!)
        iconSalaryCurrency.image = iconSalaryCurrency.image?.withRenderingMode(.alwaysTemplate)
        iconSalaryCurrency.tintColor = UIColor(hex:appColorNew!)
        //iconJobShift.image = iconJobShift.image?.withRenderingMode(.alwaysTemplate)
        //iconJobShift.tintColor = UIColor(hex: appColorNew!)
        iconJobLevel.image = iconJobLevel.image?.withRenderingMode(.alwaysTemplate)
        iconJobLevel.tintColor = UIColor(hex: appColorNew!)
        iconJobSkill.image = iconJobSkill.image?.withRenderingMode(.alwaysTemplate)
        iconJobSkill.tintColor = UIColor(hex: appColorNew!)
        iconCountry.image = iconCountry.image?.withRenderingMode(.alwaysTemplate)
        iconCountry.tintColor = UIColor(hex: appColorNew!)
        iconState.image = iconState.image?.withRenderingMode(.alwaysTemplate)
        iconState.tintColor = UIColor(hex: appColorNew!)
        iconCity.image = iconCity.image?.withRenderingMode(.alwaysTemplate)
        iconCity.tintColor = UIColor(hex: appColorNew!)
        iconTown.image = iconTown.image?.withRenderingMode(.alwaysTemplate)
        iconTown.tintColor = UIColor(hex: appColorNew!)
        
    }
    
    func nokri_boolChecks(){
        isShow2 = true
        isShow = true
        isShowSec = true
        isShowSecond = true
        isShowThi = true
        isShowThird = true
    }
    
    func nokri_populateData(){
    
        for obj in extraArray{
            if obj.fieldTypeName == "job_post_btn"{
                lblSearchNow.text = obj.key
                //btnSearchNow.setTitle(obj.key, for: .normal)
                resultButton.setTitle(obj.key, for: .normal)
                
                
            }
            if obj.fieldTypeName == "job_title"{
               txtFieldSearch.placeholder = obj.value
            }
            if obj.fieldTypeName == "job_search_cat"{
                lblSubCatKey.text = obj.key
                lblSubCatTwoKey.text = obj.key
                lblSubCatThreeKey.text = obj.key
            }
            if obj.fieldTypeName == "country"{
                lblCountryKey.text = obj.key
            }
            if obj.fieldTypeName == "city"{
                lblCityKey.text = obj.key
            }
            if obj.fieldTypeName == "state"{
                lblStateKey.text = obj.key
            }
            if obj.fieldTypeName == "town"{
                lblTownKey.text = obj.key
            }
            if obj.fieldTypeName == "page_title"{
                //self.title = obj.key
            }
            if obj.fieldTypeName == "is_job_alert"{
                isAlertShow = obj.value
            }
            if obj.fieldTypeName == "job_alerts_exp"{
                isShowJobExp = obj.value
            }
            if obj.fieldTypeName == "job_alerts_type"{
                isShowJobType = obj.value
            }
            if obj.fieldTypeName == "job_alerts_cat"{
                isShowJobCat = obj.value
            }
        }
        lblJobCategoryValue.text = selectOption
        self.lblSubCatValue.text = selectOption
        self.lblSubCatValueTwo.text = selectOption
        self.lblSubCatThreeValue.text = selectOption
        lblCountryValue.text = selectOption
        lblCityValue.text = selectOption
        lblStateValue.text = selectOption
    }
    
    func nokri_dropDownSetup(){
        
        var jobCat = [String]()
        var keyArray = [Int]()
        var childArr = [Bool]()
        for obj in searchField{
            if obj.fieldTypeName == "job_category"{
                lblJobCategoryKey.text = obj.key
                //lblJobCategoryValue.text = obj.column
                selectOption = obj.column
                valueArray = obj.valueAr
                for innerObj in valueArray{
                    jobCat.append(innerObj.value)
                    keyArray.append(innerObj.key)
                    childArr.append(innerObj.hasChild)
                    if innerObj.hasChild == true{
                
                    }
                }
            }
        }
        dropDownJobCategory.dataSource = jobCat
        dropDownJobCategory.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.isJobCat = true
            self.lblJobCategoryValue.text = item
            self.dropDownJobCategory.tag = keyArray[index]
            self.jobCatInt = keyArray[index]
            if childArr[index] == true{
               self.nokri_subCategories(id: keyArray[index])
               self.lblJobCategoryValue.text = item
                if self.isShow == true{

                    self.nokri_subCategories(id: keyArray[index])
                    self.viewSubCat.isHidden = false
                    self.heightConstraintSubCatView.constant += 58
                    self.isShow2 = false
                    self.isShow = false

                }
            }else{
                
                if self.viewSubCat.isHidden == false && self.viewSubCatTwo.isHidden == false && self.ViewSubCatThree.isHidden == false{
                  
                    self.viewSubCat.isHidden = true
                    self.viewSubCatTwo.isHidden = true
                    self.ViewSubCatThree.isHidden = true
                    self.heightConstraintSubCatView.constant -= 180
                    self.isShow2 = true
                    self.isShow = true
                    self.isShowThi = true
                    self.isShowThird = true
                    self.isShowSec = true
                    self.isShowSecond = true
                    
                }
                if self.viewSubCatTwo.isHidden == false && self.ViewSubCatThree.isHidden == false{
                    
                    self.viewSubCatTwo.isHidden = true
                    self.ViewSubCatThree.isHidden = true
                    self.heightConstraintSubCatView.constant -= 120
                    self.isShow2 = true
                    self.isShow = true
                    self.isShowThi = true
                    self.isShowThird = true
                    self.isShowSec = true
                    self.isShowSecond = true
                    
                }
                
                if self.isShow == false && self.isShow2 == false {
                  
                    self.isShow = true
                    self.isShow2 = true
                    self.heightConstraintSubCatView.constant -= 58
                    self.viewSubCat.isHidden = true

                }
            }
        }

        
        var subCateValue = [String]()
        var subCateKey = [Int]()
        var subchildArr = [Bool]()
        
        let subCategory = self.subCategoryArray as? [NSDictionary]
        for itemDict in subCategory! {
            if let catObj = itemDict["value"] as? String{
                if catObj == ""{
                    continue
                }
                subCateValue.append(catObj)
            }
            if let keyObj = itemDict["key"] as? Int{
                subCateKey.append(keyObj)
            }
            if let hasChild = itemDict["has_child"] as? Bool{
                print(hasChild)
                if hasChild == true {
                   
                }
                subchildArr.append(hasChild)
            }
        }
        dropDownSubCategoryTwo.dataSource = subCateValue
        dropDownSubCategoryTwo.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.isSubCat = true
            self.lblSubCatValue.text = item
            self.dropDownSubCategoryTwo.tag = subCateKey[index]
            self.jobCatInt = subCateKey[index]
            if subchildArr[index] == true{
                self.nokri_subCategoriesTwo(id: subCateKey[index])
                
                if self.isShowSecond == true{
                   
                    self.nokri_subCategoriesTwo(id: subCateKey[index])
                    self.viewSubCatTwo.isHidden = false
                    self.heightConstraintSubCatView.constant += 62
                    //self.view.frame.size.height += 60
                    self.isShowSec = false
                    self.isShowSecond = false
                    
                }
            }else{
                
                if self.viewSubCatTwo.isHidden == false && self.ViewSubCatThree.isHidden == false {
                   
                    self.viewSubCatTwo.isHidden = true
                    self.ViewSubCatThree.isHidden = true
                    self.heightConstraintSubCatView.constant -= 60
                    
                }
                
                if self.isShowSecond == false && self.isShowSec == false{
                   
                    self.heightConstraintSubCatView.constant -= 62
                    self.view.frame.size.height -= 60
                    self.viewSubCatTwo.isHidden = true
                    self.isShowSec = true
                    self.isShowSecond = true
                    
                }
            }
        }
        
        var subCateValueThree = [String]()
        var subCateKeyThree = [Int]()
        var subchildArrThree = [Bool]()
        var _:Int = 0
        
        let subCategoryThree = self.subCategoryArrayTwo as? [NSDictionary]
        for itemDict in subCategoryThree! {
            if let catObj = itemDict["value"] as? String{
                if catObj == ""{
                    continue
                }
                subCateValueThree.append(catObj)
            }
            if let keyObj = itemDict["key"] as? Int{
                subCateKeyThree.append(keyObj)
            }
            if let hasChild = itemDict["has_child"] as? Bool{
                print(hasChild)
                if hasChild == true {
                    // childCategories(id: catID!)
                }
                subchildArrThree.append(hasChild)
            }
        }
        
        dropDownSubCategoryThree.dataSource = subCateValueThree
        dropDownSubCategoryThree.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item : \(item) at index: \(index)")
            self.isSubCatTwo = true
            self.jobCatInt = subCateKeyThree[index]
            self.lblSubCatValueTwo.text = item
            self.dropDownSubCategoryThree.tag = subCateKeyThree[index]
            if subchildArrThree[index] == true{
              
                self.nokri_subCategoriesThree(id: subCateKeyThree[index])
                if self.isShowThird == true{
                    
                    self.ViewSubCatThree.isHidden = false
                    self.heightConstraintSubCatView.constant += 60
                    self.isShowThird = false
                    self.isShowThi = false
                    
                }
            }else{
                
                if self.isShowThird == false && self.isShowThi == false{
                    
                    self.heightConstraintSubCatView.constant -= 60
                    self.ViewSubCatThree.isHidden = true
                    self.isShowThird = true
                    self.isShowThi = true
                    
                    
                }
            }
        }
        
        var subCateValueFour = [String]()
        var subCateKeyFour = [Int]()
        var subchildArrFour = [Bool]()
        
        let subCategoryFour = self.subCategoryArrayThree as? [NSDictionary]
        for itemDict in subCategoryFour! {
            if let catObj = itemDict["value"] as? String{
                if catObj == ""{
                    continue
                }
                subCateValueFour.append(catObj)
            }
            if let keyObj = itemDict["key"] as? Int{
                subCateKeyFour.append(keyObj)
            }
            if let hasChild = itemDict["has_child"] as? Bool{
                print(hasChild)
                if hasChild == true {
                    // childCategories(id: catID!)
                }
                subchildArrFour.append(hasChild)
            }
        }
        self.lblSubCatThreeValue.text = selectOption
        dropDownSubCategoryFour.dataSource = subCateValueFour
        dropDownSubCategoryFour.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.lblSubCatThreeValue.text = item
            self.isSubCatThree  = true
            self.jobCatInt = subCateKeyFour[index]
        }
        
        var qualificationKey = [Int]()
        for obj in searchField{
            
            if obj.fieldTypeName == "job_qualifications"{
                lblJobQualificationKey.text = obj.key
                lblJobQualificationValue.text = selectOption
                jobCat.removeAll()
                valueArray = obj.valueAr
                for innerObj in valueArray{
                    jobCat.append(innerObj.value)
                    qualificationKey.append(innerObj.key)
                }
            }
        }
        
        dropDownJobQualification.dataSource =  jobCat
        dropDownJobQualification.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.lblJobQualificationValue.text = item
            self.isQulificaton = true
            self.qualificationInt = qualificationKey[index]
            
        }
        
        //var jobTypeKey = [Int]()
        for obj in searchField{
            
               if obj.fieldTypeName == "job_type"{
                lblJobTypeKey.text = obj.key
                jobTypeText = obj.key
                //lblJobTypeValue.text = selectOption
                jobCat.removeAll()
                valueArray = obj.valueAr
                for innerObj in valueArray{
                    jobtypeValuerr.append(innerObj.value)
                    jobtypeKey.append(innerObj.key)
                }
            }
        }
        
        dropDownJobType.dataSource = jobCat
        dropDownJobType.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            //self.lblJobTypeValue.text = item
            self.isjobType = true
            self.jobTypeInt = self.jobtypeKey[index]
        }
        
        var salaryCurrKey = [Int]()
        for obj in searchField{
            
            if obj.fieldTypeName == "salary_currency"{
                lblSalaryCurencyKey.text = obj.key
                lblSalaryCurencyValue.text = selectOption
                jobCat.removeAll()
                valueArray = obj.valueAr
                for innerObj in valueArray{
                    jobCat.append(innerObj.value)
                    salaryCurrKey.append(innerObj.key)
                }
            }
            
        }
        dropDownSalaryCurrency.dataSource = jobCat
        dropDownSalaryCurrency.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.lblSalaryCurencyValue.text = item
            self.isSalarCurrency = true
            self.salarCurrencyInt = salaryCurrKey[index]
        }
        
        for obj in searchField{

            if obj.fieldTypeName == "job_shift"{
                lblJobShiftKey.text = obj.key
                //lblJobShiftValue.text = selectOption
                jobCat.removeAll()
                valueArray = obj.valueAr
                for innerObj in valueArray{
                    jobshiftValuerr.append(innerObj.value)
                    jobShiftKey.append(innerObj.key)
                }
            }
        }
        dropDownJobShift.dataSource = jobCat
        dropDownJobShift.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.lblJobShiftValue.text = item
            self.jobShiftInt = self.jobShiftKey[index]
        }
        
        var jobLevelKey = [Int]()
        for obj in searchField{
            
            if obj.fieldTypeName == "job_level"{
                lblJoblevelKey.text = obj.key
                lblJoblevelValue.text = selectOption
                jobCat.removeAll()
                valueArray = obj.valueAr
                for innerObj in valueArray{
                    jobCat.append(innerObj.value)
                    jobLevelKey.append(innerObj.key)
                }
            }
        }
        dropDownJobLevel.dataSource = jobCat
        dropDownJobLevel.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.lblJoblevelValue.text = item
            self.isJobLevel = true
            self.jobLevelInt = jobLevelKey[index]
        }
        
        var jobSkillKey = [Int]()
        for obj in searchField{
            if obj.fieldTypeName == "job_tags"{
                lblJobSkillKey.text = obj.key
                lblJobSkillValue.text = selectOption
                jobCat.removeAll()
                valueArray = obj.valueAr
                for innerObj in valueArray{
                    jobCat.append(innerObj.value)
                    jobSkillKey.append(innerObj.key)
                }
            }
        }
        dropDownJobSkill.dataSource = jobCat
        dropDownJobSkill.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.lblJobSkillValue.text = item
            self.isSkill = true
            self.skillInt = jobSkillKey[index]
        }
        
        var countryKey = [Int]()
        var childArrr = [Bool]()
        for obj in searchField{
            if obj.fieldTypeName == "job_location"{
                categoryArray.removeAll()
                valueArray = obj.valueAr
                for innerObj in valueArray{
                    categoryArray.append(innerObj.value)
                    countryKey.append(innerObj.key)
                    childArrr.append(innerObj.hasChild)
                }
            }
            //categoryArray.removeAll()
        }
        
        dropDownCountry.dataSource =  categoryArray
        dropDownCountry.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.lblCountryValue.text = item
            self.dropDownCountry.tag = countryKey[index]
            self.isCountry = true
            self.countryInt = countryKey[index]
            if childArrr[index] == true{
                //self.lblCountryValue.text = item
                self.nokri_countryCategories(id: countryKey[index])
                if self.isShow == true{
                    self.tableView.rowHeight += 58
                    self.nokri_countryCategories(id: countryKey[index])
                    //self.lblCountryValue.text = item
                    self.viewState.isHidden = false
                    self.heightConstraintCCT.constant += 58
                    self.isShow2 = false
                    self.isShow = false
                }
            }else{
                if self.viewState.isHidden == false && self.viewCity.isHidden == false && self.viewTown.isHidden == false{
                    self.viewState.isHidden = true
                    self.viewCity.isHidden = true
                    self.viewTown.isHidden = true
                    self.heightConstraintCCT.constant -= 180
                    self.tableView.rowHeight -= 180
                    self.isShow2 = true
                    self.isShow = true
                    self.isShowThi = true
                    self.isShowThird = true
                    self.isShowSec = true
                    self.isShowSecond = true
                }
                if self.viewCity.isHidden == false && self.viewState.isHidden == false{
                    self.viewState.isHidden = true
                    self.viewCity.isHidden = true
                    self.heightConstraintCCT.constant -= 120
                    self.tableView.rowHeight -= 120
                    self.isShow2 = true
                    self.isShow = true
                    self.isShowThi = true
                    self.isShowThird = true
                    self.isShowSec = true
                    self.isShowSecond = true
                }
                if self.isShow == false && self.isShow2 == false {
                    self.isShow = true
                    self.isShow2 = true
                    self.heightConstraintCCT.constant -= 58
                    self.tableView.rowHeight -= 58
                    //self.heightContraintMain.constant -= 58
                    self.viewState.isHidden = true
                }
            }
        }
        
        var statValue = [String]()
        var stateKey = [Int]()
        var stateChildArr = [Bool]()
        let subCategoryy = self.statArray as? [NSDictionary]
        for itemDict in subCategoryy! {
            if let catObj = itemDict["value"] as? String{
                if catObj == ""{
                    continue
                }
                statValue.append(catObj)
            }
            if let keyObj = itemDict["key"] as? Int{
                stateKey.append(keyObj)
            }
            if let hasChild = itemDict["has_child"] as? Bool{
                print(hasChild)
                if hasChild == true {
                    
                }
                stateChildArr.append(hasChild)
            }
        }
        
        dropDownState.dataSource = statValue
        dropDownState.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.isState = true
            self.lblStateValue.text = item
            self.dropDownState.tag = stateKey[index]
            self.countryInt = stateKey[index]
            if stateChildArr[index] == true{
                // self.lblStateValue.text = item
                self.nokri_cityCategories(id: stateKey[index])
                if self.isShowSecond == true{
                    //self.lblStateValue.text = item
                    self.nokri_cityCategories(id: stateKey[index])
                    self.viewCity.isHidden = false
                    self.heightConstraintCCT.constant += 62
                    self.tableView.rowHeight += 62
                    self.isShowSec = false
                    self.isShowSecond = false
                }
            }else{
                if self.viewCity.isHidden == false && self.viewTown.isHidden == false {
                    self.viewCity.isHidden = true
                    self.viewTown.isHidden = true
                    self.heightConstraintCCT.constant -= 60
                    self.tableView.rowHeight -= 60
                    self.isShowSec = true
                    self.isShowSecond = true
                }
                if self.isShowSecond == false && self.isShowSec == false{
                    self.heightConstraintCCT.constant -= 62
                    self.tableView.rowHeight -= 62
                    self.viewCity.isHidden = true
                    self.isShowSec = true
                    self.isShowSecond = true
                    //                  self.isShowThird = true
                    //                  self.isShowThi = true
                    
                }
            }
        }
        
        var cityValue = [String]()
        var cityKey = [Int]()
        var cityChildArr = [Bool]()
        let citybCategory = self.cityArray as? [NSDictionary]
        for itemDict in citybCategory! {
            if let catObj = itemDict["value"] as? String{
                if catObj == ""{
                    continue
                }
                cityValue.append(catObj)
            }
            if let keyObj = itemDict["key"] as? Int{
                cityKey.append(keyObj)
            }
            if let hasChild = itemDict["has_child"] as? Bool{
                print(hasChild)
                if hasChild == true {
                    
                }
                cityChildArr.append(hasChild)
            }
        }
        dropDownCity.dataSource = cityValue
        dropDownCity.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.isCity = true
            self.lblCityValue.text = item
            self.dropDownCity.tag = cityKey[index]
            self.countryInt = cityKey[index]
            if cityChildArr[index] == true{
                // self.lblCityValue.text = item
                self.nokri_townCategories(id: cityKey[index])
                if self.isShowThird == true{
                    // self.lblCityValue.text = item
                    self.nokri_townCategories(id: cityKey[index])
                    self.viewTown.isHidden = false
                    self.heightConstraintCCT.constant += 62
                    self.tableView.rowHeight += 62
                    self.isShowThird = false
                    self.isShowThi = false
                }
            }else{
                if self.isShowThird == false && self.isShowThi == false{
                    self.heightConstraintCCT.constant -= 62
                    self.tableView.rowHeight -= 62
                    self.viewCity.isHidden = true
                    self.isShowThird = true
                    self.isShowThi = true
                }
            }
        }
        
        var townValue = [String]()
        var townKey = [Int]()
        var townChildArr = [Bool]()
        let townCategory = self.townArray as? [NSDictionary]
        for itemDict in townCategory! {
            if let catObj = itemDict["value"] as? String{
                if catObj == ""{
                    continue
                }
                townValue.append(catObj)
            }
            if let keyObj = itemDict["key"] as? Int{
                townKey.append(keyObj)
                
                if let hasChild = itemDict["has_child"] as? Bool{
                    print(hasChild)
                    if hasChild == true {
                        
                    }
                    townChildArr.append(hasChild)
                }
            }
        }
        self.lblTownValue.text = selectOption
        dropDownTown.dataSource = townValue
        dropDownTown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.countryInt = townKey[index]
            self.isTown = true
            self.lblTownValue.text = item
            self.dropDownTown.tag = townKey[index]
            self.isShow2 = false
            self.isShow = false
            self.isShowThi = false
            self.isShowThird = false
            self.isShowSec = false
            self.isShowSecond = false
            
        }
    
       
        for obj in searchField{
            
            if obj.fieldTypeName == "email_freq"{
                valueArray = obj.valueAr
                for innerObj in valueArray{
                    jobFrequencyValue.append(innerObj.value)
                    jobFrequencyKey.append(innerObj.key)
                }
            }
            
            if obj.fieldTypeName == "job_experience"{
               // lblJoblevelKey.text = obj.key
                jobExpTxt = obj.key
               // lblJoblevelValue.text = selectOption
                jobCat.removeAll()
                   valueArray = obj.valueAr
                for innerObj in valueArray{
                    jobExpValArr.append(innerObj.value)
                    jobExpKeyArr.append(innerObj.key)
                }
            }
            
       
        }
    
        
        dropDownJobCategory.anchorView = btnDropDownJobCategory
        dropDownSubCategoryTwo.anchorView = btnDropDownSubCategory
        dropDownSubCategoryThree.anchorView = btnSubCatTwoClicked
        dropDownSubCategoryFour.anchorView = btnSubCatThree
        dropDownJobQualification.anchorView = btnDropDownJobQualification
        dropDownJobType.anchorView = btnDropDownJobType
        dropDownSalaryCurrency.anchorView = btnDropDownSalaryCurrency
        //dropDownJobShift.anchorView = btnDropDownJobShift
        dropDownJobLevel.anchorView = btnDropDownJobLevel
        dropDownJobSkill.anchorView = btnDropDownJobSkill
        dropDownSubCategory.anchorView = btnDropDownSubCategory
        dropDownCountry.anchorView = btnCountry
        dropDownState.anchorView = btnState
        dropDownCity.anchorView = btnCity
        dropDownTown.anchorView = btnTown
        
        
        DropDown.startListeningToKeyboard()
        DropDown.appearance().textColor = UIColor.black
        DropDown.appearance().textFont = UIFont.systemFont(ofSize: 12)
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor(hex:appColorNew!)
        DropDown.appearance().cellHeight = 40
        
    }
  

    func nokri_viewShadow(){
    
        viewJobCategory.layer.borderColor = UIColor.lightGray.cgColor
        viewJobCategory.layer.cornerRadius = 0
        viewJobCategory.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
        viewJobCategory.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewJobCategory.layer.shadowOpacity = 0.6
        viewJobCategory.layer.shadowRadius = 2
        
        viewSubCatTwo.layer.borderColor = UIColor.lightGray.cgColor
        viewSubCatTwo.layer.cornerRadius = 0
        viewSubCatTwo.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
        viewSubCatTwo.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewSubCatTwo.layer.shadowOpacity = 0.6
        viewSubCatTwo.layer.shadowRadius = 2
        
        ViewSubCatThree.layer.borderColor = UIColor.lightGray.cgColor
        ViewSubCatThree.layer.cornerRadius = 0
        ViewSubCatThree.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
        ViewSubCatThree.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        ViewSubCatThree.layer.shadowOpacity = 0.6
        ViewSubCatThree.layer.shadowRadius = 2
        
        viewJobQualification.layer.borderColor = UIColor.lightGray.cgColor
        viewJobQualification.layer.cornerRadius = 0
        viewJobQualification.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
        viewJobQualification.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewJobQualification.layer.shadowOpacity = 0.6
        viewJobQualification.layer.shadowRadius = 2
        
        viewJobType.layer.borderColor = UIColor.lightGray.cgColor
        viewJobType.layer.cornerRadius = 0
        viewJobType.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
        viewJobType.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewJobType.layer.shadowOpacity = 0.6
        viewJobType.layer.shadowRadius = 2
        
        viewSalaryCurrency.layer.borderColor = UIColor.lightGray.cgColor
        viewSalaryCurrency.layer.cornerRadius = 0
        viewSalaryCurrency.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
        viewSalaryCurrency.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewSalaryCurrency.layer.shadowOpacity = 0.6
        viewSalaryCurrency.layer.shadowRadius = 2
        
        viewJobShift.layer.borderColor = UIColor.lightGray.cgColor
        viewJobShift.layer.cornerRadius = 0
        viewJobShift.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
        viewJobShift.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewJobShift.layer.shadowOpacity = 0.6
        viewJobShift.layer.shadowRadius = 2
        
        viewJobLevel.layer.borderColor = UIColor.lightGray.cgColor
        viewJobLevel.layer.cornerRadius = 0
        viewJobLevel.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
        viewJobLevel.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewJobLevel.layer.shadowOpacity = 0.8
        viewJobLevel.layer.shadowRadius = 2
        
        viewJobSkill.layer.borderColor = UIColor.lightGray.cgColor
        viewJobSkill.layer.cornerRadius = 0
        viewJobSkill.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
        viewJobSkill.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewJobSkill.layer.shadowOpacity = 0.6
        viewJobSkill.layer.shadowRadius = 2
        
        viewSubCat.layer.borderColor = UIColor.lightGray.cgColor
        viewSubCat.layer.cornerRadius = 0
        viewSubCat.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
        viewSubCat.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewSubCat.layer.shadowOpacity = 0.6
        viewSubCat.layer.shadowRadius = 2
        
        viewCountry.layer.borderColor = UIColor.gray.cgColor
        viewCountry.layer.cornerRadius = 0
        viewCountry.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
        viewCountry.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewCountry.layer.shadowOpacity = 0.6
        viewCountry.layer.shadowRadius = 2
        
        viewState.layer.borderColor = UIColor.gray.cgColor
        viewState.layer.cornerRadius = 0
        viewState.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
        viewState.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewState.layer.shadowOpacity = 0.6
        viewState.layer.shadowRadius = 2
        
        viewCity.layer.borderColor = UIColor.gray.cgColor
        viewCity.layer.cornerRadius = 0
        viewCity.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
        viewCity.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewCity.layer.shadowOpacity = 0.6
        viewCity.layer.shadowRadius = 2
        
        viewTown.layer.borderColor = UIColor.gray.cgColor
        viewTown.layer.cornerRadius = 0
        viewTown.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
        viewTown.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewTown.layer.shadowOpacity = 0.6
        viewTown.layer.shadowRadius = 2
    
    }
    
    //MARK:- API Calls
    
    func nokri_advanceSearchData() {
        
        self.showLoader()
       
        self.viewJobCategory.isHidden = true
        self.viewSubCat.isHidden = true
        self.viewSubCatTwo.isHidden = true
        self.ViewSubCatThree.isHidden = true
        self.viewJobQualification.isHidden = true
        self.viewJobType.isHidden = true
        self.viewSalaryCurrency.isHidden = true
        self.viewJobShift.isHidden = true
        self.viewJobLevel.isHidden = true
        self.viewJobSkill.isHidden = true
        //self.btnSearchNow.isHidden = true
        self.viewSearchKeyWord.isHidden = true
        
        UserHandler.nokri_advanceSearch(success: { (successResponse) in
            
            self.stopAnimating()
            if successResponse.success {
                self.viewJobCategory.isHidden = false
                self.viewSubCat.isHidden = false
                self.viewSubCatTwo.isHidden = false
                self.ViewSubCatThree.isHidden = false
                self.viewJobQualification.isHidden = false
                self.viewJobType.isHidden = false
                self.viewSalaryCurrency.isHidden = false
                self.viewJobShift.isHidden = false
                self.viewJobLevel.isHidden = false
                self.viewJobSkill.isHidden = false
                //self.btnSearchNow.isHidden = false
                self.viewSearchKeyWord.isHidden = false
                self.searchField = successResponse.data.searchFields
                self.extraArray = successResponse.extra
                self.nokri_dropDownSetup()
                self.collectionViewJobShift.reloadData()
                self.collectionViewJobType.reloadData()
                self.nokri_populateData()
                
            }
            else {
//                let alert = Constants.showBasicAlert(message: successResponse.message)
//                self.present(alert, animated: true, completion: nil)
                self.showLoader()
                self.viewJobCategory.isHidden = true
                self.viewSubCat.isHidden = true
                self.viewSubCatTwo.isHidden = true
                self.ViewSubCatThree.isHidden = true
                self.viewJobQualification.isHidden = true
                self.viewJobType.isHidden = true
                self.viewSalaryCurrency.isHidden = true
                self.viewJobShift.isHidden = true
                self.viewJobLevel.isHidden = true
                self.viewJobSkill.isHidden = true
                //self.btnSearchNow.isHidden = true
                self.viewSearchKeyWord.isHidden = true
                
            }
        }) { (error) in
            self.showLoader()
            self.viewJobCategory.isHidden = true
            self.viewSubCat.isHidden = true
            self.viewSubCatTwo.isHidden = true
            self.ViewSubCatThree.isHidden = true
            self.viewJobQualification.isHidden = true
            self.viewJobType.isHidden = true
            self.viewSalaryCurrency.isHidden = true
            self.viewJobShift.isHidden = true
            self.viewJobLevel.isHidden = true
            self.viewJobSkill.isHidden = true
            //self.btnSearchNow.isHidden = true
            self.viewSearchKeyWord.isHidden = true
            
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
        
    }
    

    func nokri_subCategories(id:Int){
        
        self.showLoader()
        
        var email = ""
        var password = ""
        
        if UserDefaults.standard.bool(forKey: "isSocial") == true {
            if let userEmail = UserDefaults.standard.string(forKey: "email") {
                email = userEmail
            }
            if let userPassword = UserDefaults.standard.string(forKey: "password") {
                password = userPassword
            }
            let emailPass = "\(email):\(password)"
            let encodedString = emailPass.data(using: String.Encoding.utf8)!
            let base64String = encodedString.base64EncodedString(options: [])
            
            let headers = [
                
                "Content-Type":Constants.customCodes.contentType,
                "Authorization" : "Basic \(base64String)",
                "Purchase-Code" : Constants.customCodes.purchaseCode,
                "Custom-Security": Constants.customCodes.securityCode,
                "Nokri-Request-From" : Constants.customCodes.requestFrom,
                "Nokri-Login-Type" : "social"
            ]
            
            let param: [String: Any] = [
                "cat_id": id,
                ]
            print(param)
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.subCategory, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    let responseData = response.value as! NSArray
                    print(responseData)
                    
                    self.nokri_subCatDataParser(jobCatArr: responseData)
                    self.nokri_dropDownSetup()
                    self.stopAnimating()
                    
            }
        }else{
            if let userEmail = UserDefaults.standard.string(forKey: "email") {
                email = userEmail
            }
            if let userPassword = UserDefaults.standard.string(forKey: "password") {
                password = userPassword
            }
            let emailPass = "\(email):\(password)"
            let encodedString = emailPass.data(using: String.Encoding.utf8)!
            let base64String = encodedString.base64EncodedString(options: [])
            
            let headers = [
                
                "Content-Type":Constants.customCodes.contentType,
                "Authorization" : "Basic \(base64String)",
                "Purchase-Code" : Constants.customCodes.purchaseCode,
                "Custom-Security": Constants.customCodes.securityCode,
                "Nokri-Request-From" : Constants.customCodes.requestFrom
            ]
            
            let param: [String: Any] = [
                "cat_id": id,
                ]
            print(param)
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.subCategory, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    let responseData = response.value as! NSArray
                    print(responseData)
                    
                    self.nokri_subCatDataParser(jobCatArr: responseData)
                    self.nokri_dropDownSetup()
                    self.stopAnimating()
                    
            }
        }
        
       
    }
    
    func nokri_subCatDataParser(jobCatArr:NSArray){
        
        self.subCategoryArray.removeAllObjects()
        for item in jobCatArr{
            self.subCategoryArray.add(item)
        }
        
        
    }
    
    func nokri_subCategoriesTwo(id:Int){

        self.showLoader()
        var email = ""
        var password = ""
        
        if UserDefaults.standard.bool(forKey: "isSocial") == true {
            if let userEmail = UserDefaults.standard.string(forKey: "email") {
                email = userEmail
            }
            if let userPassword = UserDefaults.standard.string(forKey: "password") {
                password = userPassword
            }
            let emailPass = "\(email):\(password)"
            let encodedString = emailPass.data(using: String.Encoding.utf8)!
            let base64String = encodedString.base64EncodedString(options: [])
            
            let headers = [
                
                "Content-Type":Constants.customCodes.contentType,
                "Authorization" : "Basic \(base64String)",
                "Purchase-Code" : Constants.customCodes.purchaseCode,
                "Custom-Security": Constants.customCodes.securityCode,
                "Nokri-Request-From" : Constants.customCodes.requestFrom,
                "Nokri-Login-Type" : "social"
            ]
            
            let param: [String: Any] = [
                "cat_id": id,
                ]
            print(param)
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.subCategory, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    let responseData = response.value as! NSArray
                    print(responseData)
                    
                    self.nokri_subCatDataParserTwo(jobCatArr: responseData)
                    self.nokri_dropDownSetup()
                    self.stopAnimating()
                    
            }
        }else{
            if let userEmail = UserDefaults.standard.string(forKey: "email") {
                email = userEmail
            }
            if let userPassword = UserDefaults.standard.string(forKey: "password") {
                password = userPassword
            }
            let emailPass = "\(email):\(password)"
            let encodedString = emailPass.data(using: String.Encoding.utf8)!
            let base64String = encodedString.base64EncodedString(options: [])
            
            let headers = [
                
                "Content-Type":Constants.customCodes.contentType,
                "Authorization" : "Basic \(base64String)",
                "Purchase-Code" : Constants.customCodes.purchaseCode,
                "Custom-Security": Constants.customCodes.securityCode,
                "Nokri-Request-From" : Constants.customCodes.requestFrom
            ]
            
            let param: [String: Any] = [
                "cat_id": id,
                ]
            print(param)
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.subCategory, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    let responseData = response.value as! NSArray
                    print(responseData)
                    
                    self.nokri_subCatDataParserTwo(jobCatArr: responseData)
                    self.nokri_dropDownSetup()
                    self.stopAnimating()
                    
            }
        }
        
       
    }

    func nokri_subCatDataParserTwo(jobCatArr:NSArray){

        self.subCategoryArrayTwo.removeAllObjects()
        for item in jobCatArr{
            self.subCategoryArrayTwo.add(item)
        }
        
    }
    
    func nokri_subCategoriesThree(id:Int){
        
        self.showLoader()
        
        var email = ""
        var password = ""
        
        if UserDefaults.standard.bool(forKey: "isSocial") == true {
            if let userEmail = UserDefaults.standard.string(forKey: "email") {
                email = userEmail
            }
            if let userPassword = UserDefaults.standard.string(forKey: "password") {
                password = userPassword
            }
            let emailPass = "\(email):\(password)"
            let encodedString = emailPass.data(using: String.Encoding.utf8)!
            let base64String = encodedString.base64EncodedString(options: [])
            
            let headers = [
                
                "Content-Type":Constants.customCodes.contentType,
                "Authorization" : "Basic \(base64String)",
                "Purchase-Code" : Constants.customCodes.purchaseCode,
                "Custom-Security": Constants.customCodes.securityCode,
                "Nokri-Request-From" : Constants.customCodes.requestFrom,
                "Nokri-Login-Type" : "social"
            ]
            
            let param: [String: Any] = [
                "cat_id": id,
                ]
            print(param)
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.subCategory, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    let responseData = response.value as! NSArray
                    print(responseData)
                    
                    self.nokri_subCatDataParserThree(jobCatArr: responseData)
                    self.nokri_dropDownSetup()
                    self.stopAnimating()
                    
            }
        }else{
            if let userEmail = UserDefaults.standard.string(forKey: "email") {
                email = userEmail
            }
            if let userPassword = UserDefaults.standard.string(forKey: "password") {
                password = userPassword
            }
            let emailPass = "\(email):\(password)"
            let encodedString = emailPass.data(using: String.Encoding.utf8)!
            let base64String = encodedString.base64EncodedString(options: [])
            
            let headers = [
                
                "Content-Type":Constants.customCodes.contentType,
                "Authorization" : "Basic \(base64String)",
                "Purchase-Code" : Constants.customCodes.purchaseCode,
                "Custom-Security": Constants.customCodes.securityCode,
                "Nokri-Request-From" : Constants.customCodes.requestFrom
            ]
            
            let param: [String: Any] = [
                "cat_id": id,
                ]
            print(param)
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.subCategory, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    let responseData = response.value as! NSArray
                    print(responseData)
                    
                    self.nokri_subCatDataParserThree(jobCatArr: responseData)
                    self.nokri_dropDownSetup()
                    self.stopAnimating()
                    
            }
        }
        
      
    }
    
    func nokri_subCatDataParserThree(jobCatArr:NSArray){
        
        self.subCategoryArrayThree.removeAllObjects()
        for item in jobCatArr{
            self.subCategoryArrayThree.add(item)
        }
    
    }
    
    
    func nokri_jobData(){
        
        var isTimeOut = false
       
        var email = ""
        var password = ""
        btnSearchKeyword.isEnabled = false
        if UserDefaults.standard.bool(forKey: "isSocial") == true {
            if let userEmail = UserDefaults.standard.string(forKey: "email") {
                email = userEmail
            }
            if let userPassword = UserDefaults.standard.string(forKey: "password") {
                password = userPassword
            }
            
            let emailPass = "\(email):\(password)"
            
            let encodedString = emailPass.data(using: String.Encoding.utf8)!
            let base64String = encodedString.base64EncodedString(options: [])
            
            let headers = [
                "Content-Type":Constants.customCodes.contentType,
                "Authorization" : "Basic \(base64String)",
                "Purchase-Code" : Constants.customCodes.purchaseCode,
                "Custom-Security": Constants.customCodes.securityCode,
                "Nokri-Request-From" : Constants.customCodes.requestFrom,
                "Nokri-Login-Type" : "social"
            ]
            
            let param: [String: Any] = [
                
                "page_number" : "1",
                "job_title" : txtFieldSearch.text!
                
            ]
            print(param)
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.advanceSearch, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    guard let res = response.value else{return}
                    self.btnSearchKeyword.isEnabled = true
                    let responseData = res as! NSDictionary
                    self.message = responseData["message"] as? String
                    
                    let success = responseData["success"] as! Bool
                    if success == true{
                        self.viewJobCategory.isHidden = false
                        self.viewSubCat.isHidden = false
                        self.viewSubCatTwo.isHidden = false
                        self.ViewSubCatThree.isHidden = false
                        self.viewJobQualification.isHidden = false
                        self.viewJobType.isHidden = false
                        self.viewSalaryCurrency.isHidden = false
                        self.viewJobShift.isHidden = false
                        self.viewJobLevel.isHidden = false
                        self.viewJobSkill.isHidden = false
                        //self.btnSearchNow.isHidden = false
                        self.viewSearchKeyWord.isHidden = false

                        isTimeOut = true
                        var pageTitle:String?
                        let data = responseData["data"] as! NSDictionary
                        if let page = data["page_title"]  as? String{
                            pageTitle = page
                        }
                        if let noOfJob = data["no_txt"]  as? String{
                            self.noOfJobs = noOfJob
                        }
                        if let JobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParser(jobsArr: JobArr)
                        }
                        if let pagination = responseData["pagination"] as? NSDictionary{
                            self.hasNextPage = pagination["has_next_page"] as? Bool
                            self.nextPage = pagination["next_page"] as? Int
                        }
                        if self.hasNextPage == true{
                            print(self.hasNextPage!)
                            //self.btnLoadMore.isHidden = false
                        }
                        print(self.nextPage!)
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SearchedJobViewController") as! SearchedJobViewController
                        nextViewController.jobsArray = self.jobsArray
                        nextViewController.message = self.message
                        nextViewController.pageTitle = pageTitle
                        nextViewController.hasNextPage = self.hasNextPage!
                        nextViewController.nextPage = self.nextPage
                        nextViewController.searchedText = self.txtFieldSearch.text!
                        nextViewController.noOfJobText = self.noOfJobs
                        
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                        
                    }else{
                        self.viewJobCategory.isHidden = true
                        self.viewSubCat.isHidden = true
                        self.viewSubCatTwo.isHidden = true
                        self.ViewSubCatThree.isHidden = true
                        self.viewJobQualification.isHidden = true
                        self.viewJobType.isHidden = true
                        self.viewSalaryCurrency.isHidden = true
                        self.viewJobShift.isHidden = true
                        self.viewJobLevel.isHidden = true
                        self.viewJobSkill.isHidden = true
                       // self.btnSearchNow.isHidden = true
                        self.viewSearchKeyWord.isHidden = true
                        
                        let hud = JGProgressHUD(style: .dark)
                        hud.textLabel.text = self.message
                        hud.detailTextLabel.text = nil
                        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                        hud.position = .bottomCenter
                        hud.show(in: self.view)
                        hud.dismiss(afterDelay: 2.0)
                        //self.view.makeToast(self.message, duration: 1.5, position: .center)
                    }
                    
                    self.stopAnimating()
                    if isTimeOut == false{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                            self.stopAnimating()
                            self.view.makeToast("Network Time out", duration: 1.5, position: .center)
                        }
                        
                    }
                    
            }
        }else{
            if let userEmail = UserDefaults.standard.string(forKey: "email") {
                email = userEmail
            }
            if let userPassword = UserDefaults.standard.string(forKey: "password") {
                password = userPassword
            }
            
            let emailPass = "\(email):\(password)"
            
            let encodedString = emailPass.data(using: String.Encoding.utf8)!
            let base64String = encodedString.base64EncodedString(options: [])
            
            let headers = [
                "Content-Type":Constants.customCodes.contentType,
                "Authorization" : "Basic \(base64String)",
                "Purchase-Code" : Constants.customCodes.purchaseCode,
                "Custom-Security": Constants.customCodes.securityCode,
                "Nokri-Request-From" : Constants.customCodes.requestFrom
            ]
            
            let param: [String: Any] = [
                
                "page_number" : "1",
                "job_title" : txtFieldSearch.text!
                
            ]
            print(param)
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.advanceSearch, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    self.btnSearchKeyword.isEnabled = true
                    guard let res = response.value else{return}
                    
                    let responseData = res as! NSDictionary
                    self.message = responseData["message"] as? String
                    
                    let success = responseData["success"] as! Bool
                    if success == true{
                        isTimeOut = true
                        var pageTitle:String?
                        let data = responseData["data"] as! NSDictionary
                        if let page = data["page_title"]  as? String{
                            pageTitle = page
                        }
                        if let noOfJob = data["no_txt"]  as? String{
                            self.noOfJobs = noOfJob
                        }
                        if let JobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParser(jobsArr: JobArr)
                        }
                        if let pagination = responseData["pagination"] as? NSDictionary{
                            self.hasNextPage = pagination["has_next_page"] as? Bool
                            self.nextPage = pagination["next_page"] as? Int
                        }
                        if self.hasNextPage == true{
                            print(self.hasNextPage!)
                            //self.btnLoadMore.isHidden = false
                        }
                        print(self.nextPage!)
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SearchedJobViewController") as! SearchedJobViewController
                        nextViewController.jobsArray = self.jobsArray
                        nextViewController.message = self.message
                        nextViewController.pageTitle = pageTitle
                        nextViewController.hasNextPage = self.hasNextPage!
                        nextViewController.nextPage = self.nextPage
                        nextViewController.searchedText = self.txtFieldSearch.text!
                        nextViewController.noOfJobText = self.noOfJobs
                        
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                        
                    }else{
                        let hud = JGProgressHUD(style: .dark)
                        hud.textLabel.text = self.message
                        hud.detailTextLabel.text = nil
                        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                        hud.position = .bottomCenter
                        hud.show(in: self.view)
                        hud.dismiss(afterDelay: 2.0)
                        //self.view.makeToast(self.message, duration: 1.5, position: .center)
                    }
                    
                    self.stopAnimating()
                    if isTimeOut == false{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                            self.stopAnimating()
                            self.view.makeToast("Network Time out", duration: 1.5, position: .center)
                        }
                        
                    }
                    
            }
        }
        
       
        
    }
    
    func nokri_jobDataParser(jobsArr:NSArray){
        
        self.jobsArray.removeAllObjects()
        for item in jobsArr{
            print(item)
            var arrayOfDictionaries = [NSDictionary]();
            if let innerArray = item as? NSArray{
                for innerItem in innerArray{
                    
                    print(innerItem);
                    if let innerDictionary = innerItem as? NSDictionary{
                        arrayOfDictionaries.append(innerDictionary);
                    }
                }
            }
            self.jobsArray.add(arrayOfDictionaries);
        }
      
    }
    
    
    func nokri_jobDataWithFilters(){
        
        var isTimeOut = false
        self.showLoader()
        
        var email = ""
        var password = ""
        
        if UserDefaults.standard.bool(forKey: "isSocial") == true {
            if let userEmail = UserDefaults.standard.string(forKey: "email") {
                email = userEmail
            }
            if let userPassword = UserDefaults.standard.string(forKey: "password") {
                password = userPassword
            }
            
            let emailPass = "\(email):\(password)"
            
            let encodedString = emailPass.data(using: String.Encoding.utf8)!
            let base64String = encodedString.base64EncodedString(options: [])
            
            let headers = [
                "Content-Type":Constants.customCodes.contentType,
                "Authorization" : "Basic \(base64String)",
                "Purchase-Code" : Constants.customCodes.purchaseCode,
                "Custom-Security": Constants.customCodes.securityCode,
                "Nokri-Request-From" : Constants.customCodes.requestFrom,
                "Nokri-Login-Type" : "social"
            ]
            
            var params : [String:Any] = [:]
        
            if isJobCat == true{
                params["job_category"] = jobCatInt
            }
            if isjobType == true{
                params["job_type"] = jobTypeInt
            }
            if isQulificaton == true{
                params["job_qualifications"] = qualificationInt
            }
            if isSalarCurrency == true{
                params["job_currency"] = salarCurrencyInt
            }
            if isJobShift == true{
                params["job_shift"] = jobShiftInt
            }
            if isJobLevel == true{
                params["job_level"] = jobLevelInt
            }
            if isSkill == true{
                params["job_skills"] = skillInt
            }
            if isCountry == true{
                params["job_location"] = countryInt
            }
            params["page_number"] = "1"
            
            
            print(params)
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.advanceSearch, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    guard let res = response.value else{return}
                    
                    let responseData = res as! NSDictionary
                    self.message = responseData["message"] as? String
                    
                    let success = responseData["success"] as! Bool
                    if success == true{
                        
                        isTimeOut = true
                        var pageTitle:String?
                        let data = responseData["data"] as! NSDictionary
                        if let page = data["page_title"]  as? String{
                            pageTitle = page
                        }
                        if let JobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParserWithFilters(jobsArr: JobArr)
                        }
                        if let noOfJob = data["no_txt"]  as? String{
                            self.noOfJobs = noOfJob
                        }
                        
                        if let pagination = responseData["pagination"] as? NSDictionary{
                            self.hasNextPage = pagination["has_next_page"] as? Bool
                            self.nextPage = pagination["next_page"] as? Int
                        }
                        if self.hasNextPage == true{
                            print(self.hasNextPage!)
                            //self.btnLoadMore.isHidden = false
                        }
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SearchedJobViewController") as! SearchedJobViewController
                        nextViewController.jobsArray = self.jobsArray
                        nextViewController.message = self.message
                        nextViewController.pageTitle = pageTitle
                        nextViewController.hasNextPage = self.hasNextPage!
                        nextViewController.nextPage = self.nextPage
                        nextViewController.isfromFilter = true
                        nextViewController.isJobCat = self.isJobCat
                        nextViewController.isQulificaton = self.isQulificaton
                        nextViewController.isSalarCurrency = self.isSalarCurrency
                        nextViewController.isJobShift = self.isJobShift
                        nextViewController.isJobLevel = self.isJobLevel
                        nextViewController.isSkill = self.isSkill
                        nextViewController.jobCatInt = self.jobCatInt
                        nextViewController.qualificationInt = self.qualificationInt
                        nextViewController.salarCurrencyInt = self.salarCurrencyInt
                        nextViewController.jobShiftInt = self.jobShiftInt
                        nextViewController.jobLevelInt = self.jobLevelInt
                        nextViewController.skillInt = self.skillInt
                        nextViewController.noOfJobText = self.noOfJobs
                        
                        
                        
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                    }else{
                        let hud = JGProgressHUD(style: .dark)
                        hud.textLabel.text = self.message
                        hud.detailTextLabel.text = nil
                        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                        hud.position = .bottomCenter
                        hud.show(in: self.view)
                        hud.dismiss(afterDelay: 2.0)
                        //self.view.makeToast(self.message, duration: 1.5, position: .center)
                    }
                    
                    self.stopAnimating()
                    if isTimeOut == false{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                            self.stopAnimating()
                            self.view.makeToast("Network Time out", duration: 1.5, position: .center)
                        }
                        
                    }
                    
            }
            
        }else{
            if let userEmail = UserDefaults.standard.string(forKey: "email") {
                email = userEmail
            }
            if let userPassword = UserDefaults.standard.string(forKey: "password") {
                password = userPassword
            }
            
            let emailPass = "\(email):\(password)"
            
            let encodedString = emailPass.data(using: String.Encoding.utf8)!
            let base64String = encodedString.base64EncodedString(options: [])
            
            let headers = [
                "Content-Type":Constants.customCodes.contentType,
                "Authorization" : "Basic \(base64String)",
                "Purchase-Code" : Constants.customCodes.purchaseCode,
                "Custom-Security": Constants.customCodes.securityCode,
                "Nokri-Request-From" : Constants.customCodes.requestFrom
            ]
            
            var params : [String:Any] = [:]
            
            if isJobCat == true{
                params["job_category"] = jobCatInt
            }
            
            if isQulificaton == true{
                params["job_qualifications"] = qualificationInt
            }
            if isjobType == true{
                params["job_type"] = jobTypeInt
            }
            if isSalarCurrency == true{
                params["job_currency"] = salarCurrencyInt
            }
            if isJobShift == true{
                params["job_shift"] = jobShiftInt
            }
            if isJobLevel == true{
                params["job_level"] = jobLevelInt
            }
            if isSkill == true{
                params["job_skills"] = skillInt
            }
            if isCountry == true{
                params["ad_location"] = countryInt
            }
            params["page_number"] = "1"
            
            print(params)
            
            
            
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.advanceSearch, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    guard let res = response.value else{return}
                    
                    let responseData = res as! NSDictionary
                    self.message = responseData["message"] as? String
                    
                    let success = responseData["success"] as! Bool
                    if success == true{
                        
                        isTimeOut = true
                        var pageTitle:String?
                        let data = responseData["data"] as! NSDictionary
                        if let page = data["page_title"]  as? String{
                            pageTitle = page
                        }
                        if let noOfJob = data["no_txt"]  as? String{
                            self.noOfJobs = noOfJob
                        }
                        if let JobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParserWithFilters(jobsArr: JobArr)
                        }
                        if let pagination = responseData["pagination"] as? NSDictionary{
                            self.hasNextPage = pagination["has_next_page"] as? Bool
                            self.nextPage = pagination["next_page"] as? Int
                        }
                        if self.hasNextPage == true{
                            print(self.hasNextPage!)
                            //self.btnLoadMore.isHidden = false
                        }
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SearchedJobViewController") as! SearchedJobViewController
                        nextViewController.jobsArray = self.jobsArray
                        nextViewController.message = self.message
                        nextViewController.pageTitle = pageTitle
                        nextViewController.hasNextPage = self.hasNextPage!
                        nextViewController.nextPage = self.nextPage
                        nextViewController.isfromFilter = true
                        nextViewController.isJobCat = self.isJobCat
                        nextViewController.isQulificaton = self.isQulificaton
                        nextViewController.isSalarCurrency = self.isSalarCurrency
                        nextViewController.isJobShift = self.isJobShift
                        nextViewController.isJobLevel = self.isJobLevel
                        nextViewController.isSkill = self.isSkill
                        nextViewController.jobCatInt = self.jobCatInt
                        nextViewController.qualificationInt = self.qualificationInt
                        nextViewController.salarCurrencyInt = self.salarCurrencyInt
                        nextViewController.jobShiftInt = self.jobShiftInt
                        nextViewController.jobLevelInt = self.jobLevelInt
                        nextViewController.skillInt = self.skillInt
                        nextViewController.noOfJobText = self.noOfJobs
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                    }else{
                        let hud = JGProgressHUD(style: .dark)
                        hud.textLabel.text = self.message
                        hud.detailTextLabel.text = nil
                        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                        hud.position = .bottomCenter
                        hud.show(in: self.view)
                        hud.dismiss(afterDelay: 2.0)
                        //self.view.makeToast(self.message, duration: 1.5, position: .center)
                    }
                    
                    self.stopAnimating()
                    if isTimeOut == false{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                            self.stopAnimating()
                            self.view.makeToast("Network Time out", duration: 1.5, position: .center)
                        }
                        
                    }
                    
            }
            
        }
        
       
    }
    
    func nokri_jobDataParserWithFilters(jobsArr:NSArray){
        
        self.jobsArray.removeAllObjects()
        for item in jobsArr{
            print(item)
            var arrayOfDictionaries = [NSDictionary]();
            if let innerArray = item as? NSArray{
                for innerItem in innerArray{
                    print(innerItem);
                    if let innerDictionary = innerItem as? NSDictionary{
                        arrayOfDictionaries.append(innerDictionary);
                    }
                }
            }
            self.jobsArray.add(arrayOfDictionaries);
        }
        
    }
    
    func nokri_countryCategories(id:Int){
        self.showLoader()
        var email = ""
        var password = ""
        
        if UserDefaults.standard.bool(forKey: "isSocial") == true {
            if let userEmail = UserDefaults.standard.string(forKey: "email") {
                email = userEmail
            }
            if let userPassword = UserDefaults.standard.string(forKey: "password") {
                password = userPassword
            }
            let emailPass = "\(email):\(password)"
            let encodedString = emailPass.data(using: String.Encoding.utf8)!
            let base64String = encodedString.base64EncodedString(options: [])
            
            let headers = [
                
                "Content-Type":Constants.customCodes.contentType,
                "Authorization" : "Basic \(base64String)",
                "Purchase-Code" : Constants.customCodes.purchaseCode,
                "Custom-Security": Constants.customCodes.securityCode,
                "Nokri-Request-From" : Constants.customCodes.requestFrom,
                "Nokri-Login-Type" : "social"
                
            ]
            let param: [String: Any] = [
                "country_id": id,
                ]
            print(param)
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.countryCat, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    let responseData = response.value as! NSArray
                    print(responseData)
                    self.nokri_stateDataParser(stateArr: responseData)
                    self.nokri_dropDownSetup()
                    self.stopAnimating()
            }
        }else{
            if let userEmail = UserDefaults.standard.string(forKey: "email") {
                email = userEmail
            }
            if let userPassword = UserDefaults.standard.string(forKey: "password") {
                password = userPassword
            }
            let emailPass = "\(email):\(password)"
            let encodedString = emailPass.data(using: String.Encoding.utf8)!
            let base64String = encodedString.base64EncodedString(options: [])
            
            let headers = [
                
                "Content-Type":Constants.customCodes.contentType,
                "Authorization" : "Basic \(base64String)",
                "Purchase-Code" : Constants.customCodes.purchaseCode,
                "Custom-Security": Constants.customCodes.securityCode,
                "Nokri-Request-From" : Constants.customCodes.requestFrom
                
            ]
            let param: [String: Any] = [
                "country_id": id,
                ]
            print(param)
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.countryCat, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    let responseData = response.value as! NSArray
                    print(responseData)
                    self.nokri_stateDataParser(stateArr: responseData)
                    self.nokri_dropDownSetup()
                    self.stopAnimating()
            }
        }
        
        
    }
    
    func nokri_stateDataParser(stateArr:NSArray){
        self.statArray.removeAllObjects()
        for item in stateArr{
            self.statArray.add(item)
        }
    }
    
    func nokri_cityCategories(id:Int){
        self.showLoader()
        var email = ""
        var password = ""
        
        
        if UserDefaults.standard.bool(forKey: "isSocial") == true {
            if let userEmail = UserDefaults.standard.string(forKey: "email") {
                email = userEmail
            }
            if let userPassword = UserDefaults.standard.string(forKey: "password") {
                password = userPassword
            }
            let emailPass = "\(email):\(password)"
            let encodedString = emailPass.data(using: String.Encoding.utf8)!
            let base64String = encodedString.base64EncodedString(options: [])
            
            let headers = [
                
                "Content-Type":Constants.customCodes.contentType,
                "Authorization" : "Basic \(base64String)",
                "Purchase-Code" : Constants.customCodes.purchaseCode,
                "Custom-Security": Constants.customCodes.securityCode,
                "Nokri-Request-From" : Constants.customCodes.requestFrom,
                "Nokri-Login-Type" : "social"
                
            ]
            let param: [String: Any] = [
                "country_id": id,
                ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.countryCat, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    let responseData = response.value as! NSArray
                    print(responseData)
                    self.nokri_cityDataParser(cityArr: responseData)
                    self.nokri_dropDownSetup()
                    self.stopAnimating()
            }
        }else{
            if let userEmail = UserDefaults.standard.string(forKey: "email") {
                email = userEmail
            }
            if let userPassword = UserDefaults.standard.string(forKey: "password") {
                password = userPassword
            }
            let emailPass = "\(email):\(password)"
            let encodedString = emailPass.data(using: String.Encoding.utf8)!
            let base64String = encodedString.base64EncodedString(options: [])
            
            let headers = [
                
                "Content-Type":Constants.customCodes.contentType,
                "Authorization" : "Basic \(base64String)",
                "Purchase-Code" : Constants.customCodes.purchaseCode,
                "Custom-Security": Constants.customCodes.securityCode,
                "Nokri-Request-From" : Constants.customCodes.requestFrom
                
            ]
            let param: [String: Any] = [
                "country_id": id,
                ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.countryCat, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    let responseData = response.value as! NSArray
                    print(responseData)
                    self.nokri_cityDataParser(cityArr: responseData)
                    self.nokri_dropDownSetup()
                    self.stopAnimating()
            }
            
        }
        
        
    }
    
    func nokri_cityDataParser(cityArr:NSArray){
        self.cityArray.removeAllObjects()
        for item in cityArr{
            self.cityArray.add(item)
        }
    }
    
    func nokri_townCategories(id:Int){
        self.showLoader()
        var email = ""
        var password = ""
        
        if UserDefaults.standard.bool(forKey: "isSocial") == true {
            if let userEmail = UserDefaults.standard.string(forKey: "email") {
                email = userEmail
            }
            if let userPassword = UserDefaults.standard.string(forKey: "password") {
                password = userPassword
            }
            let emailPass = "\(email):\(password)"
            let encodedString = emailPass.data(using: String.Encoding.utf8)!
            let base64String = encodedString.base64EncodedString(options: [])
            let headers = [
                "Content-Type":Constants.customCodes.contentType,
                "Authorization" : "Basic \(base64String)",
                "Purchase-Code" : Constants.customCodes.purchaseCode,
                "Custom-Security": Constants.customCodes.securityCode,
                "Nokri-Request-From" : Constants.customCodes.requestFrom,
                "Nokri-Login-Type" : "social"
            ]
            let param: [String: Any] = [
                "country_id": id,
                ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.countryCat, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    let responseData = response.value as! NSArray
                    print(responseData)
                    self.nokri_townDataParser(townArr: responseData)
                    self.nokri_dropDownSetup()
                    self.stopAnimating()
            }
        }else{
            if let userEmail = UserDefaults.standard.string(forKey: "email") {
                email = userEmail
            }
            if let userPassword = UserDefaults.standard.string(forKey: "password") {
                password = userPassword
            }
            let emailPass = "\(email):\(password)"
            let encodedString = emailPass.data(using: String.Encoding.utf8)!
            let base64String = encodedString.base64EncodedString(options: [])
            let headers = [
                "Content-Type":Constants.customCodes.contentType,
                "Authorization" : "Basic \(base64String)",
                "Purchase-Code" : Constants.customCodes.purchaseCode,
                "Custom-Security": Constants.customCodes.securityCode,
                "Nokri-Request-From" : Constants.customCodes.requestFrom
            ]
            let param: [String: Any] = [
                "country_id": id,
                ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.countryCat, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    let responseData = response.value as! NSArray
                    print(responseData)
                    self.nokri_townDataParser(townArr: responseData)
                    self.nokri_dropDownSetup()
                    self.stopAnimating()
            }
        }
        
        
    }
    
    func nokri_townDataParser(townArr:NSArray){
        self.townArray.removeAllObjects()
        for item in townArr{
            self.townArray.add(item)
        }
    }
    
    
}
