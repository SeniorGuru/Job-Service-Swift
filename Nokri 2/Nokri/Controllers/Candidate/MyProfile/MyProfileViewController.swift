//
//  MyProfileViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/12/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import Alamofire
import YoutubePlayer_in_WKWebView
import TGPControls
import RangeSeekSlider
import JGProgressHUD
import  GoogleMaps
import GooglePlaces
import JGProgressHUD


class MyProfileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, imagesDelegate {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            
            tableView.showsVerticalScrollIndicator = false
            tableView.addSubview(refreshControl)
        }
    }
    @IBOutlet weak var heightConstraintBanner: NSLayoutConstraint!
   // @IBOutlet weak var adBannerView: GADBannerView!
   // @IBOutlet weak var bannerViewBottom: GADBannerView!
    @IBOutlet weak var heightConstraintBottomBanner: NSLayoutConstraint!
    
    //MARK:- Proporties
    
    @IBOutlet weak var lblMessage: UILabel!
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var isFromCan:Bool?
    var userId:Int?
    var basicInfoKeyArr = NSMutableArray()
    var customArr = NSMutableArray()
    var basicInfoValueArr = NSMutableArray()
    var skillsArray = NSMutableArray()
    var extraArray = NSMutableArray()
    var certificationArr = NSMutableArray()
    var eductionArr = NSMutableArray()
    var professionalArr = NSMutableArray()
    var portfolioArr = NSMutableArray()
    var certificationExtraArr = NSMutableArray()
    var educationExtraArray = NSMutableArray()
    var professionalExtraArray = NSMutableArray()
    var portfolioExtraArray = NSMutableArray()
    var profileImage:String?
    var keyArray = [String]()
    var valueArray = [String]()
    var keyArrayCustom = [String]()
    var valueArrayCustom = [String]()
    var idCheck:Int?
    var notSkills:String?
    var notAbout:String?
    var notCer:String?
    var notEducation:String?
    var notPro:String?
    var notPortfolio:String?
    var notVideo:String?
    var facebook:String?
    var google:String?
    var linkedIn:String?
    var twitter:String?
    var txtSkills:String?
    var txtAbout:String?
    var txtEducation:String?
    var txtCertification:String?
    var txtProfessional:String?
    var txtPortfolio:String?
    var txtVideo:String?
    var isFromFollower:Bool = false
    var aboutCellHeight : CGFloat = 0.0;
    var aboutCellHeightEdu : CGFloat = 0.0;
    var aboutCellHeightPro : CGFloat = 0.0;
    var aboutCellHeightCer : CGFloat = 0.0;
    var skillCellHeight : CGFloat = 0.0;
    var videoCellHeight : CGFloat = 0.0;
    var certTitleHeight : CGFloat = 0.0;
    var certKeyHeight : CGFloat = 0.0;
    
    var proTitleHeight : CGFloat = 0.0;
    var proKeyHeight : CGFloat = 0.0;
    
    var eduTitleHeight : CGFloat = 0.0;
    var eduKeyHeight : CGFloat = 0.0;
    
    var videoUrl:String = ""
    var slider = RangeSeekSlider()
    var skillNewArr = [String]()
    var percentArr = [Int]()
    
    var recId :Int = 0
    var recName:String = ""
    var recvEmail :String = ""
    var sender_name :String = ""
    var sender_email :String = ""
    var sender_subject :String = ""
    var sender_message :String = ""
    var btn_txt :String = ""
    var withOutLogin = UserDefaults.standard.string(forKey: "aType")
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var isData = false
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(refreshTableView),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor(hex: appColorNew!)
        
        return refreshControl
    }()
    var isFromCandSearch = false
    var txtBtnResu = ""
    var scoringKey = ""
    var scoringValue = ""
    var fullKeyArr = [String]()
    var fullValueArr = [String]()
    var latCheck:Bool = true
    var longCheck:Bool = true
    var image:String?
    var latitude:String?
    var longitude:String?
    var isMapHide = "0"
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.isHidden = true
        //tableView.delegate = self
        //tableView.dataSource = self
        if withOutLogin == "5"{
            
            var login = ""
            if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                let dataTabs = SplashRoot(fromDictionary: objData)
                let obj = dataTabs.data.extra
                login = (obj?.isLogin)!
                //self.view.makeToast(login, duration: 1.5, position: .center)
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = login
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
            }
            
            //tableView.isHidden = true
            self.perform(#selector(self.nokri_showNavController1), with: nil, afterDelay: 2)
        }else{
            tableView.isHidden = false
            let type = UserDefaults.standard.integer(forKey: "usrTyp")
            if type == 1 && isFromCandSearch == false{
                appDelegate.nokri_moveToCompanyDashboard()
            }else{
                tableView.isHidden = false
                nokri_ProfileData()
            }
        }
        nokri_adMob()
        nokri_ltrRtl()
        //showSearchButton()
        if isFromCandSearch == true{
            self.showBackButton()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let obj = dataTabs.data.tabs
            self.navigationController?.navigationBar.topItem?.title = obj?.profile
        }
    }
    
    @objc func refreshTableView() {
        isData = true
        nokri_ProfileData()
    }
    
    @objc func nokri_showNavController1(){
        appDelegate.nokri_moveToSignIn()
    }
    
    func nokri_images(img: [String]) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ImagesScreenViewController") as! ImagesScreenViewController
        nextViewController.imagesArray = img
        self.present(nextViewController, animated: true, completion: nil)
        
    }
    
    //MARK:- AdMob Delegate Methods
    
//    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
//        print("Banner loaded successfully")
//        let translateTransform = CGAffineTransform(translationX: 0, y: -bannerView.bounds.size.height)
//        bannerView.transform = translateTransform
//
//        UIView.animate(withDuration: 0.5) {
//            bannerView.transform = CGAffineTransform.identity
//        }
//        if UserHandler.sharedInstance.objSaplash?.adMob != nil {
//            let objData = UserHandler.sharedInstance.objSaplash?.adMob
//            var isShowAd = false
//            if let adShow = objData?.show {
//                isShowAd = adShow
//            }
//            isShowAd = true
//            if isShowAd {
//
//                SwiftyAd.shared.delegate = self
//                var isShowBanner = false
//                var isShowInterstital = false
//                if let banner = objData?.is_show_banner {
//                    isShowBanner = banner
//                }
//                if let intersitial = objData?.is_show_initial {
//                    isShowInterstital = intersitial
//                }
//                if isShowBanner {
//                   // print(objData?.banner_id!!)
//                    SwiftyAd.shared.setup(withBannerID: (objData?.banner_id)!, interstitialID: "", rewardedVideoID: "")
//                    self.tableView.translatesAutoresizingMaskIntoConstraints = false
//                    if objData?.position == "top" {
//                        heightConstraintBanner.constant = 65
//                        heightConstraintBottomBanner.constant = 0
//                        //tableView.tableHeaderView?.frame = bannerView.frame
//                        //tableView.tableHeaderView = bannerView
//
//                    }
//                    else {
//                        heightConstraintBottomBanner.constant = 65
//                        heightConstraintBanner.constant = 0
//                        //tableView.tableFooterView?.frame = bannerView.frame
//                        //tableView.tableFooterView = bannerView
//                    }
//                }
//                if isShowInterstital {
//                    SwiftyAd.shared.setup(withBannerID: "", interstitialID: (objData?.ad_id)!, rewardedVideoID: "")
//                    SwiftyAd.shared.showInterstitial(from: self)
//                }
//            }
//        }
//    }
    
//    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
//        print("Fail to receive ads")
//        print(error)
//    }
    
//    func swiftyAdDidOpen(_ swiftyAd: SwiftyAd) {
//        print("Open")
//    }
//
//    func swiftyAdDidClose(_ swiftyAd: SwiftyAd) {
//        print("Close")
//    }
//
//    func swiftyAd(_ swiftyAd: SwiftyAd, didRewardUserWithAmount rewardAmount: Int) {
//        print(rewardAmount)
//    }
    
    
    //MARK:- IBActions
    
    @IBAction func btnCloseClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- Custome Functions
    
    func nokri_ltrRtl(){
        if isFromFollower == false{
            let isRtl = UserDefaults.standard.string(forKey: "isRtl")
            if isRtl == "0"{
                self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
            }else{
                self.addRightBarButtonWithImage(#imageLiteral(resourceName: "menu"))
            }
        }
        
    }
    
    func nokri_adMob(){
        heightConstraintBanner.constant = 0
        heightConstraintBottomBanner.constant = 0
        if UserHandler.sharedInstance.objSaplash?.adMob != nil {
            let objData = UserHandler.sharedInstance.objSaplash?.adMob
            var isShowAd = false
            if let adShow = objData?.show {
                isShowAd = adShow
            }
            //isShowAd = false
            if isShowAd == true {
                let objData = UserHandler.sharedInstance.objSaplash?.adMob
//                let req = GADRequest()
//                //adBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
//                adBannerView?.adUnitID = objData?.banner_id
//                adBannerView?.delegate = self
//                adBannerView?.rootViewController = self
//                adBannerView!.load(req)
//                bannerViewBottom?.adUnitID = objData?.banner_id
//                bannerViewBottom?.delegate = self
//                bannerViewBottom?.rootViewController = self
//                bannerViewBottom!.load(req)
                //SwiftyAd.shared.delegate = self
                var isShowBanner = false
                var isShowInterstital = false
                if let banner = objData?.is_show_banner {
                    isShowBanner = banner
                }
                if let intersitial = objData?.is_show_initial {
                    isShowInterstital = intersitial
                }
                if isShowBanner {
                    //print(objData?.banner_id!)
                   // SwiftyAd.shared.setup(withBannerID: (objData?.banner_id)!, interstitialID: "", rewardedVideoID: "")
                    self.tableView.translatesAutoresizingMaskIntoConstraints = false
                    
                }
                if objData?.position == "top"{
                    heightConstraintBottomBanner.constant = 0
                    heightConstraintBanner.constant = 65
                }else{
                    heightConstraintBanner.constant = 0
                    heightConstraintBottomBanner.constant = 65
                }
                if isShowInterstital {
//                    SwiftyAd.shared.setup(withBannerID: "", interstitialID: (objData?.ad_id)!, rewardedVideoID: "")
//                    SwiftyAd.shared.showInterstitial(from: self)
                }
            }else{
                heightConstraintBanner.constant = 0
                heightConstraintBottomBanner.constant = 0
            }
        }
        
    }
    
    func nokri_populateData(){
        
        if isData == true{
            basicInfoKeyArr.removeAllObjects()
            extraArray.removeAllObjects()
            certificationArr.removeAllObjects()
            educationExtraArray.removeAllObjects()
            skillsArray.removeAllObjects()
        }
        
        let customArr = self.customArr as? [NSDictionary]
        for itemDict in customArr! {
            
            if let val = itemDict["value"] as? String{
                
                if val != ""{
                    self.valueArrayCustom.append(val)
                    if let key = itemDict["key"] as? String {
                        //if key != ""{
                        self.keyArrayCustom.append(key)
                        //}
                    }
                }
            }
            
        }
        
        let bascArr = self.basicInfoKeyArr as? [NSDictionary]
        for itemDict in bascArr! {
            if let obj = itemDict["field_type_name"] as? String{
                
                if obj == "cand_email"{
                    
                    if let value = itemDict["value"] as? String {
                        if value != ""{
                            self.valueArray.append(value)
                            if let key = itemDict["key"] as? String {
                                if key != ""{
                                    self.keyArray.append(key)
                                }
                            }
                        }
                    }
                }
                if obj == "cand_phone"{
                    
                    if let value = itemDict["value"] as? String {
                        if value != ""{
                            self.valueArray.append(value)
                            if let key = itemDict["key"] as? String {
                                if key != ""{
                                    self.keyArray.append(key)
                                }
                            }
                        }
                    }
                }
                if obj == "cand_rgstr"{
                    
                    if let value = itemDict["value"] as? String {
                        if value != ""{
                            //self.valueArray.append(value)
                            if let key = itemDict["key"] as? String {
                                if key != ""{
                                    //self.keyArray.append(key)
                                }
                            }
                        }
                    }
                }
                if obj == "cand_dob"{
                    
                    if let value = itemDict["value"] as? String {
                        if value != ""{
                            self.valueArray.append(value)
                            if let key = itemDict["key"] as? String {
                                if key != ""{
                                    self.keyArray.append(key)
                                }
                            }
                        }
                    }
                }
                if obj == "last_esdu"{
                    if let value = itemDict["value"] as? String {
                        if value != ""{
                            self.valueArray.append(value)
                            if let key = itemDict["key"] as? String {
                                if key != ""{
                                    self.keyArray.append(key)
                                }
                            }
                        }
                    }
                }
                if obj == "cand_adress"{
                    
                    if let value = itemDict["value"] as? String {
                        if value != ""{
                            self.valueArray.append(value)
                            if let key = itemDict["key"] as? String {
                                if key != ""{
                                    self.keyArray.append(key)
                                }
                            }
                        }
                    }
                }
                if obj == "cand_type"{
                    
                    if let value = itemDict["value"] as? String {
                        if value != ""{
                            self.valueArray.append(value)
                            if let key = itemDict["key"] as? String {
                                if key != ""{
                                    self.keyArray.append(key)
                                }
                            }
                        }
                    }
                }
                if obj == "cand_level"{
                    
                    if let value = itemDict["value"] as? String {
                        if value != ""{
                            self.valueArray.append(value)
                            if let key = itemDict["key"] as? String {
                                if key != ""{
                                    self.keyArray.append(key)
                                }
                            }
                        }
                    }
                }
                if obj == "cand_hand"{
                    
                    if let value = itemDict["value"] as? String {
                        if value != ""{
                            self.valueArray.append(value)
                            if let key = itemDict["key"] as? String {
                                if key != ""{
                                    self.keyArray.append(key)
                                }
                            }
                        }
                    }
                }
                
                if obj == "cand_experience"{
                    
                    if let value = itemDict["value"] as? String {
                        if value != ""{
                            self.valueArray.append(value)
                            if let key = itemDict["key"] as? String {
                                if key != ""{
                                    self.keyArray.append(key)
                                }
                            }
                        }
                    }
                }
            }
            
            
            fullKeyArr = keyArrayCustom + keyArray
            fullValueArr = valueArrayCustom + valueArray
        }
        
        let bascArray = self.basicInfoKeyArr as? [NSDictionary]
        for itemDict in bascArray! {
            if let obj = itemDict["field_type_name"] as? String{
                if obj == "about_me"
                {
                    if let key = itemDict["key"] as? String {
                        txtAbout = key
                    }
                }
                if obj == "saving_resumes"
                {
                    if let key = itemDict["key"] as? String {
                        //txtAbout = key
                    }
                }
                
            }
        }
        let extraArr = self.extraArray as? [NSDictionary]
        for itemDict in extraArr! {
            if let obj = itemDict["field_type_name"] as? String{
                if obj == "cand_skills"{
                    if let value = itemDict["value"] as? String {
                        notSkills = value
                    }
                }
                if obj == "cand_about"{
                    if let value = itemDict["value"] as? String {
                        notAbout = value
                    }
                }
                if obj == "map_switch"{
                    if let value = itemDict["value"] as? String {
                        isMapHide = value
                    }
                }
            }
        }
        let certExtraArr = self.certificationExtraArr as? [NSDictionary]
        for itemDict in certExtraArr! {
            if let obj = itemDict["field_type_name"] as? String{
                if obj == "not_added"{
                    if let value = itemDict["value"] as? String {
                        notCer = value
                    }
                }
                if obj == "section_name"{
                    if let value = itemDict["value"] as? String {
                        txtCertification = value
                    }
                }
            }
        }
        let eduExtraArr = self.educationExtraArray as? [NSDictionary]
        for itemDict in eduExtraArr! {
            if let obj = itemDict["field_type_name"] as? String{
                if obj == "not_added"{
                    if let value = itemDict["value"] as? String {
                        notEducation = value
                        print(value)
                    }
                }
                if obj == "section_name"{
                    if let value = itemDict["value"] as? String {
                        txtEducation = value
                    }
                }
            }
        }
        let proExtraArr = self.professionalExtraArray as? [NSDictionary]
        for itemDict in proExtraArr! {
            if let obj = itemDict["field_type_name"] as? String{
                if obj == "not_added"{
                    if let value = itemDict["value"] as? String {
                        notPro = value
                    }
                }
                if obj == "section_name"{
                    if let value = itemDict["value"] as? String {
                        txtProfessional = value
                    }
                }
            }
        }
        let portfolioExtraArr = self.portfolioExtraArray as? [NSDictionary]
        for itemDict in portfolioExtraArr! {
            if let obj = itemDict["field_type_name"] as? String{
                if obj == "not_added"{
                    if let value = itemDict["value"] as? String {
                        notPortfolio = value
                    }
                }
                if obj == "section_name"{
                    if let value = itemDict["value"] as? String {
                        txtPortfolio = value
                    }
                }
                if obj == "video_url"{
                    if let value = itemDict["value"] as? String {
                        videoUrl = value
                    }
                    if let value = itemDict["key"] as? String {
                        txtVideo = value
                    }
                }
                if obj == "no_video_url"{
                    if let value = itemDict["value"] as? String {
                        notVideo = value
                    }
                }
                
            }
        }
        
        let skillArr = self.skillsArray as? [NSDictionary]
        for itemDict in skillArr! {
            print(skillArr!)
            
            let responseData = itemDict
            let value = responseData["name"] as? String
            skillNewArr.append(value!)
            let percent = responseData["Percent value"] as? Int
            percentArr.append(percent!)
        }
        
        //        if skillNewArr.count == 0{
        //            skillNewArr.append("1")
        //        }
        
        //        var skillNewArr = [String]()
        //        for itemDict in skillArr! {
        //            print(skillArr!)
        //            for (value) in itemDict.allValues{
        //
        //                skillNewArr.append("\(value)")
        //                //cell.lblSkill.text = obj.value as? String
        //                //skillNewArr.append(obj.value as! String)
        //            }
        //            let responseData = itemDict
        //            let value = responseData["value"] as? String
        //            skillNewArr.append(value!)
        //
        //
        //        }
        
    }
    
    //MARK:- TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return 1
        }else if section == 1{
            return 1
        }else if section == 2{
            return fullKeyArr.count //valueArray.count/2
        }else if section == 3{
            return 1
        }
        else if section == 4{
            if skillNewArr.count == 0{
                return 1
            }else{
                return skillNewArr.count
            }
        }else if section == 5{
            return eductionArr.count
        }else if section == 6{
            return professionalArr.count
        }
        else if section == 7{
            return certificationArr.count
        }
        else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyProfileHeaderTableViewCell", for: indexPath) as! MyProfileHeaderTableViewCell
            let bascArr = self.basicInfoKeyArr as? [NSDictionary]
            for itemDict in bascArr! {
                if let obj = itemDict["field_type_name"] as? String{
                    if obj == "cand_name"{
                        if let obj = itemDict["value"] as? String{
                            cell.lblName.text = obj
                        }
                    }
                    if obj == "cand_hand"{
                        if let obj = itemDict["value"] as? String{
                            cell.lblSubTitle.text = obj
                        }
                    }
                    if obj == "saving_resumes"{
                        if let obj = itemDict["key"] as? String{
                            cell.btnSave.setTitle(obj, for: .normal)
                        }
                    }
                    if let url = URL(string: profileImage!){
                        cell.imegViewHeader.sd_setImage(with: url, completed: nil)
                        cell.imegViewHeader.sd_setShowActivityIndicatorView(true)
                        cell.imegViewHeader.sd_setIndicatorStyle(.gray)
                    }
                  
                    if obj == "download_resumes"{
                        
                       
                        let objR = itemDict["key"] as? String
                        cell.btnDownload.setTitleColor(UIColor.clear, for: .normal)
                        cell.btnDownload.setTitle(objR, for: .normal)
                        
                        
                        if let obj = itemDict["is_show"] as? String{
                            if obj == "0"{
                                cell.btnDownload.isHidden = true
                                cell.btnDownload.isUserInteractionEnabled = false
                            }else{
                                cell.btnDownload.isHidden = false
                                cell.btnDownload.isUserInteractionEnabled = true
                            }
                            if objR == ""{
                                cell.btnDownload.isHidden = true
                            }
                        }
                        
                    }
                    
                    cell.btnSave.addTarget(self, action: #selector(MyProfileViewController.nokri_btnSaveClicked), for: .touchUpInside)
                    cell.btnDownload.addTarget(self, action: #selector(MyProfileViewController.nokri_btnDownloadClicked), for: .touchUpInside)
                    
                    
                }
            }
            return cell
            
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyProfileScoringTableViewCell", for: indexPath) as! MyProfileScoringTableViewCell
            
            if scoringValue != ""{
                cell.lblSkill.text = scoringKey
                cell.lblSkillValue.text = scoringValue + "%"
                print(scoringValue)
                let n = NumberFormatter().number(from: scoringValue)
                let f = CGFloat(truncating: n!)
                
                cell.rangeSlider.minValue = 0
                cell.rangeSlider.maxValue = 100
                cell.rangeSlider.selectedMinValue = 0
                cell.rangeSlider.selectedMaxValue = f
                cell.rangeSlider.maxLabelFont = UIFont(name: "ChalkboardSE-Regular", size: 14.0)!
                cell.rangeSlider.minLabelFont = UIFont(name: "ChalkboardSE-Regular", size: 14.0)!
                cell.rangeSlider.maxLabelColor = UIColor(hex: appColorNew!)
                cell.rangeSlider.minLabelColor = UIColor(hex: appColorNew!)
                cell.rangeSlider.handleBorderColor = UIColor(hex: appColorNew!)
                cell.rangeSlider.colorBetweenHandles = UIColor(hex:appColorNew!)
                cell.rangeSlider.handleColor = UIColor(hex: appColorNew!)
                cell.rangeSlider.handleDiameter = 25.0
                cell.rangeSlider.refresh()
            }
            return cell
        }
            
        else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyProfileFieldsTableViewCell", for: indexPath) as! MyProfileFieldsTableViewCell
            cell.lblKey.text = fullKeyArr[indexPath.row]
            cell.lblValue.text = fullValueArr[indexPath.row]
            return cell
        }
        else if indexPath.section == 3 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyProfileAboutMeTableViewCell", for: indexPath) as! MyProfileAboutMeTableViewCell
            let bascArr = self.basicInfoKeyArr as? [NSDictionary]
            for itemDict in bascArr! {
                if let obj = itemDict["field_type_name"] as? String{
                    if obj == "about_me"{
                        if let obj = itemDict["value"] as? String{
                            if obj == ""{
                                cell.lblAboutMe.text = notAbout
                                cell.lblAboutMe.font = UIFont(name:"Montserrat",size:12)
                                cell.lblAboutMe.textColor = UIColor.lightGray
                                self.aboutCellHeight = 40
                            }else{
                                let htmlString = obj
                                let strokeTextAttributes: [NSAttributedString.Key: Any] = [
                                    .foregroundColor : UIColor.gray,
                                    .font :  UIFont(name:"Open Sans",size:13)!
                                ]
                                let data = htmlString.data(using: String.Encoding.unicode)!
                                let attrStr = try? NSAttributedString(
                                    data: data,
                                    options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                                    documentAttributes: nil)
                                
                                cell.lblAboutMe.attributedText = NSMutableAttributedString(string: (attrStr?.string)!, attributes: strokeTextAttributes)
                                
                                self.aboutCellHeight = (cell.lblAboutMe.attributedText?.height(withConstrainedWidth: self.view.frame.size.width))!+16;
                            }
                        }
                    }
                }
            }
            return cell
        }else if indexPath.section == 4{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyProfileSkillTableViewCell", for: indexPath) as! MyProfileSkillTableViewCell
            
            if skillNewArr.count == 0{
               //  skillCellHeight = 40
                cell.rangeSlider.isHidden = true
                cell.lblSkill.text = notSkills
                cell.lblSkill.font = UIFont(name:"Montserrat",size:12)
                cell.lblSkill.textColor = UIColor.lightGray
            }else{
                
                let skil = skillNewArr[indexPath.row]
                cell.lblSkill.text = skil
                
                let percent = percentArr[indexPath.row]
                let myFloat = percent
                cell.rangeSlider.minValue = 0
                cell.rangeSlider.maxValue = 100
                cell.rangeSlider.selectedMinValue = 0
                cell.rangeSlider.selectedMaxValue = CGFloat(myFloat)
                cell.rangeSlider.maxLabelFont = UIFont(name: "ChalkboardSE-Regular", size: 14.0)!
                cell.rangeSlider.minLabelFont = UIFont(name: "ChalkboardSE-Regular", size: 14.0)!
                cell.rangeSlider.maxLabelColor = UIColor(hex: appColorNew!)
                cell.rangeSlider.minLabelColor = UIColor(hex: appColorNew!)
                cell.rangeSlider.handleBorderColor = UIColor(hex: appColorNew!)
                cell.rangeSlider.colorBetweenHandles = UIColor(hex:appColorNew!)
                cell.rangeSlider.handleColor = UIColor(hex: appColorNew!)
                cell.rangeSlider.handleDiameter = 25.0
                cell.rangeSlider.refresh()
                
                /*
                 var skillNewArr = [String]()
                 for itemDict in skillArr! {
                 print(skillArr!)
                 //                    for (value) in itemDict.allValues{
                 //
                 //                        skillNewArr.append("\(value)")
                 //                        //cell.lblSkill.text = obj.value as? String
                 //                        //skillNewArr.append(obj.value as! String)
                 //                    }
                 let responseData = itemDict
                 let value = responseData["name"] as? String
                 skillNewArr.append(value!)
                 }
                 cell.lblSkill.text = skillNewArr.joined(separator: ",")
                 let htmlString = skillNewArr.joined(separator: ",")
                 // works even without <html><body> </body></html> tags, BTW
                 let data = htmlString.data(using: String.Encoding.unicode)! // mind "!"
                 let attrStr = try? NSAttributedString( // do catch
                 data: data,
                 options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                 documentAttributes: nil)
                 cell.lblSkill.attributedText = attrStr
                 self.skillCellHeight = (cell.lblSkill.attributedText?.height(withConstrainedWidth: self.view.frame.size.width))!+16;
                 
                 
                 */
            }
            
            return cell
            
        }else if indexPath.section == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyProfileEducationalDetailTableViewCell", for: indexPath) as! MyProfileEducationalDetailTableViewCell
            var start = ""
            var end = ""
            var degreeName = ""
            var valueCheck = ""
            let education = self.eductionArr[indexPath.row] as? [NSDictionary];
            for itemDict in education! {
                let innerDict = itemDict ;
                if let field_type_name = innerDict["field_type_name"] as? String{
                    if field_type_name == "degree_institute" {
                        if let value = innerDict["value"] as? String {
                            if value == ""{
                                cell.lblInstituteName.text = notEducation
                                print(notEducation!)
                                valueCheck = ""
                                self.eduTitleHeight = 35.0
                                cell.lblInstituteName.textColor = UIColor.lightGray
                            }else{
                                //cell.lblInstituteName.text = value
                                valueCheck = "Not_Empty"
                                let htmlString = value
                                let data = htmlString.data(using: String.Encoding.unicode)!
                                let attrStr = try? NSAttributedString(
                                    data: data,
                                    options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                                    documentAttributes: nil)
                                cell.lblInstituteName.attributedText = attrStr
                                cell.lblInstituteName.font = UIFont(name:"Montserrat",size:12)
                                self.eduTitleHeight = (cell.lblInstituteName.attributedText?.height(withConstrainedWidth: self.view.frame.size.width))!;
                            }
                        }
                    }
                    if field_type_name == "degree_name" {
                        if let value = innerDict["value"] as? String {
                            // cell.lblDegreeOneKey.text = value
                            degreeName = value
                        }
                    }
                    if field_type_name == "degree_start" {
                        if let value = innerDict["value"] as? String {
                            start = value
                        }
                    }
                    if field_type_name == "degree_end" {
                        if let value = innerDict["value"] as? String {
                            end = value
                        }
                    }
                    if field_type_name == "degree_detail" {
                        if let value = innerDict["value"] as? String {
                            
                            if value != ""{
                                //                                let htmlString = value
                                //                                let data = htmlString.data(using: String.Encoding.unicode)!
                                //                                let attrStr = try? NSAttributedString(
                                //                                    data: data,
                                //                                    options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                                //                                    documentAttributes: nil)
                                //                                cell.lblDate.attributedText = attrStr
                                //                                cell.lblDate.font = UIFont(name:"OpenSans-Regular",size:12)
                                //                                self.aboutCellHeightEdu = (cell.lblDate.attributedText?.height(withConstrainedWidth: self.view.frame.size.width))!+16;
                                
                                let htmlString = value
                                let data = htmlString.data(using: String.Encoding.unicode)!
                                let attrStr = try? NSAttributedString(
                                    data: data,
                                    options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                                    documentAttributes: nil)
                                cell.lblDate.attributedText = attrStr
                                self.aboutCellHeightEdu = (cell.lblDate.attributedText?.height(withConstrainedWidth: self.view.frame.size.width))!+16;
                                cell.lblDate.font = UIFont(name:"OpenSans-Regular",size:12)
                                cell.lblDate.textColor = UIColor.darkGray
                            }else{
                                cell.lblDate.text = value
                                aboutCellHeightEdu = 0
                            }
                            
                        }
                    }
                }
            }
            if valueCheck == ""{
                print("empty")
                
            }else{
                //cell.lblDegreeOneKey.text = "\(degreeName)" + " | " + "\(start) to \(end)"
                let htmlString = "\(degreeName)" + " | " + "\(start) to \(end)"
                let data = htmlString.data(using: String.Encoding.unicode)!
                let attrStr = try? NSAttributedString(
                    data: data,
                    options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                    documentAttributes: nil)
                cell.lblDegreeOneKey.attributedText = attrStr
                self.eduKeyHeight = (cell.lblDegreeOneKey.attributedText?.height(withConstrainedWidth: self.view.frame.size.width))!;
            }
            return cell
        } else if  indexPath.section == 6{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyProfileProfessionalDetailTableViewCell", for: indexPath) as! MyProfileProfessionalDetailTableViewCell
            if self.professionalArr.count == 0{
                cell.textLabel?.text = notPro
                self.proTitleHeight = 35.0
                
                
            }else{
                var start = ""
                var end = ""
                var degreeName = ""
                var valueCheck = "Check"
                let professional = self.professionalArr[indexPath.row] as? [NSDictionary];
                for itemDict in professional! {
                    let innerDict = itemDict ;
                    if let field_type_name = innerDict["field_type_name"] as? String{
                        
                        if field_type_name == "project_organization" {
                            if let value = innerDict["value"] as? String {
                                if value == ""{
                                    cell.lblProfessionalInstituteName.text = notPro
                                    valueCheck = ""
                                    self.proTitleHeight = 35.0
                                    cell.lblProfessionalInstituteName.textColor = UIColor.lightGray
                                }else{
                                    //cell.lblProfessionalInstituteName.text = value
                                    let htmlString = value
                                    let data = htmlString.data(using: String.Encoding.unicode)!
                                    let attrStr = try? NSAttributedString(
                                        data: data,
                                        options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                                        documentAttributes: nil)
                                    cell.lblProfessionalInstituteName.attributedText = attrStr
                                    cell.lblProfessionalInstituteName.font = UIFont(name:"Montserrat",size:12)
                                    self.proTitleHeight = (cell.lblProfessionalInstituteName.attributedText?.height(withConstrainedWidth: self.view.frame.size.width))!;
                                    
                                }
                                
                            }
                        }
                        
                        if field_type_name == "project_role" {
                            if let value = innerDict["value"] as? String {
                                degreeName = value
                                
                            }
                        }
                        
                        if field_type_name == "project_name" {
                            if let value = innerDict["value"] as? String {
                                //degreeName = value
                                
                            }
                        }
                        if field_type_name == "project_start" {
                            if let value = innerDict["value"] as? String {
                                start = value
                            }
                        }
                        if field_type_name == "project_end" {
                            if let value = innerDict["value"] as? String {
                                end = value
                            }
                        }
                        if field_type_name == "project_desc" {
                            if let value = innerDict["value"] as? String {
                                // cell.lblDate.text = value
                                let htmlString = value
                                let data = htmlString.data(using: String.Encoding.unicode)!
                                let attrStr = try? NSAttributedString(
                                    data: data,
                                    options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                                    documentAttributes: nil)
                                cell.lblDate.attributedText = attrStr
                                cell.lblDate.textColor = UIColor.darkGray
                                cell.lblDate.font = UIFont(name:"OpenSans-Regular",size:12)
                                self.aboutCellHeightPro = (cell.lblDate.attributedText?.height(withConstrainedWidth: self.view.frame.size.width))!+16;
                                
                            }
                        }
                    }
                }
                if valueCheck == ""{
                    print("empty.")
                }else{
                    //cell.lblNameKey.text = "\(degreeName)" + " | " + "\(start) to \(end)"
                    let htmlString = "\(degreeName)" + " | " + "\(start) to \(end)"
                    let data = htmlString.data(using: String.Encoding.unicode)!
                    let attrStr = try? NSAttributedString(
                        data: data,
                        options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                        documentAttributes: nil)
                    cell.lblNameKey.attributedText = attrStr
                    cell.lblNameKey.font = UIFont(name:"OpenSans-Regular",size:10)
                    self.proKeyHeight = (cell.lblNameKey.attributedText?.height(withConstrainedWidth: self.view.frame.size.width))!;
                }
            }
            return cell
        } else if indexPath.section == 7 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyProfileCertificationDetailTableViewCell", for: indexPath) as! MyProfileCertificationDetailTableViewCell
            var start = ""
            var end = ""
            var degreeName = ""
            var valueCheck = "Check"
            let certification = self.certificationArr[indexPath.row] as? [NSDictionary];
            for itemDict in certification! {
                let innerDict = itemDict ;
                if let field_type_name = innerDict["field_type_name"] as? String{
                    if field_type_name == "certification_institute" {
                        if let value = innerDict["value"] as? String {
                            //cell.lblCertificationName.text = value
                            let htmlString = value
                            let data = htmlString.data(using: String.Encoding.unicode)!
                            let attrStr = try? NSAttributedString(
                                data: data,
                                options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                                documentAttributes: nil)
                            cell.lblCertificationName.attributedText = attrStr
                            cell.lblCertificationName.font = UIFont(name:"Montserrat",size:12)
                            self.certTitleHeight = (cell.lblCertificationName.attributedText?.height(withConstrainedWidth: self.view.frame.size.width))!;
                            print(self.certTitleHeight)
                            
                        }
                    }
                    if field_type_name == "certification_name" {
                        if let value = innerDict["value"] as? String {
                            if value == ""{
                                cell.lblCertificationName.text = notCer
                                self.aboutCellHeightCer = 100.0
                                cell.lblCertificationName.textColor = UIColor.lightGray
                                valueCheck = ""
                            }else{
                                degreeName = value
                            }
                        }
                    }
                    if field_type_name == "certification_desc" {
                        if let value = innerDict["value"] as? String {
                            //cell.lblDate.text = value
                            let htmlString = value
                            let data = htmlString.data(using: String.Encoding.unicode)!
                            let attrStr = try? NSAttributedString(
                                data: data,
                                options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                                documentAttributes: nil)
                            cell.lblDate.attributedText = attrStr
                            cell.lblDate.textColor = UIColor.darkGray
                            cell.lblDate.font = UIFont(name:"OpenSans-Regular",size:12)
                            self.aboutCellHeightCer = (cell.lblDate.attributedText?.height(withConstrainedWidth: self.view.frame.size.width))! + 16;
                        }
                    }
                    if field_type_name == "certification_start" {
                        if let value = innerDict["value"] as? String {
                            start = value
                            
                        }
                    }
                    if field_type_name == "certification_end" {
                        if let value = innerDict["value"] as? String {
                            end = value
                        }
                    }
                }
            }
            if valueCheck == ""{
                print("empty.")
                cell.lblCertificationName.text = notCer
                self.aboutCellHeightCer = 35.0
                cell.lblCertificationName.textColor = UIColor.lightGray
            }else{
                //cell.lblCertKey.text = "\(degreeName)" + " | " + "\(start) to \(end)"
                let htmlString = "\(degreeName)" + " | " + "\(start) to \(end)"
                let data = htmlString.data(using: String.Encoding.unicode)!
                let attrStr = try? NSAttributedString(
                    data: data,
                    options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                    documentAttributes: nil)
                cell.lblCertKey.attributedText = attrStr
                cell.lblCertKey.font = UIFont(name:"OpenSans-Regular",size:10)
                self.certKeyHeight = (cell.lblCertKey.attributedText?.height(withConstrainedWidth: self.view.frame.size.width))!;
                //cell.topConstraintDetail.constant += self.certKeyHeight
            }
            return cell
            
        }else if indexPath.section == 8{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyProfileMyPortfolioTableViewCell", for: indexPath) as! MyProfileMyPortfolioTableViewCell
            var arr = [String]()
            let portFolioArr = self.portfolioArr as? [NSDictionary]
            for itemDict in portFolioArr! {
                if let obj = itemDict["field_type_name"] as? String{
                    
                    if obj == "Img_url"{
                        if let obj = itemDict["value"] as? String{
                            
                            arr.append(obj)
                        }
                    }
                }
            }
            if arr.count == 0{
                cell.lblPortfolio.text = notPortfolio
                cell.lblPortfolio.font = UIFont(name:"Montserrat",size:12)
                cell.lblPortfolio.textColor = UIColor.lightGray
            }
            cell.dataArray = arr
            cell.delegate = self
            cell.notPortfo = notPortfolio
            cell.collectionView.reloadData()
            
            return cell
        }else if indexPath.section == 9{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyProfileVideoTableViewCell", for: indexPath) as! MyProfileVideoTableViewCell
            
            if videoUrl == ""{
                videoCellHeight = 70
                cell.youTubePlayer.isHidden = true
                cell.lblNotVideo.text = notVideo
            }else{
                cell.youTubePlayer.isHidden = false
                videoCellHeight = 250
                //let myVideoURL = NSURL(string: videoUrl)
                //cell.youTubePlayer.loadVideoURL(myVideoURL! as URL)
                 cell.youTubePlayer.load(withVideoId: videoUrl)  //loadVideoID(videoUrl)
            }
            
            return cell
        }else if indexPath.section == 10{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardLocationAndMapTableViewCell", for: indexPath) as! DashboardLocationAndMapTableViewCell
         
            var markerDict: [Int: GMSMarker] = [:]
            let zoom: Float = 20
            let selectedActiveJob = self.basicInfoKeyArr as? [NSDictionary];
            for itemDict in selectedActiveJob! {
                let innerDict = itemDict ;
                if let field_type_name = innerDict["field_type_name"] as? String{
                    if field_type_name == "cand_long" {
                        if let value = innerDict["value"] as? String {
                            longitude = value
                            longCheck = false
                        }
                    }
                    if field_type_name == "cand_lat" {
                        if let value = innerDict["value"] as? String {
                            latitude = value
                            latCheck = false
                        }
                    }
                }
            }
            if latitude != "" && latitude != nil && longitude != "" && longitude != nil{
            //MARKL:- Map
            
            var  la:Double = 0.0
            la = Double(latitude!)!
            var  lo:Double = 0.0
            lo = Double(longitude!)!
            var countr = ""
            
            let geoCoder = CLGeocoder()
            let location = CLLocation(latitude: la, longitude: lo)
            geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in

               // print("Response GeoLocation : \(String(describing: placemarks))")
                var placeMark: CLPlacemark!
                placeMark = placemarks?[0]
                
                // Country
                if let country = placeMark.addressDictionary!["Country"] as? String {
                    print("Country :- \(country)")
                    countr = country
                    // City
                    if let city = placeMark.addressDictionary!["City"] as? String {
                        print("City :- \(city)")
                        // State
                        if let state = placeMark.addressDictionary!["State"] as? String{
                            print("State :- \(state)")
                            // Street
                            if let street = placeMark.addressDictionary!["Street"] as? String{
                                print("Street :- \(street)")
                                let str = street
                                let streetNumber = str.components(
                                    separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "")
                                print("streetNumber :- \(streetNumber)" as Any)

                                // ZIP
                                if let zip = placeMark.addressDictionary!["ZIP"] as? String{
                                    print("ZIP :- \(zip)")
                                    // Location name
                                    if let locationName = placeMark?.addressDictionary?["Name"] as? String {
                                        print("Location Name :- \(locationName)")
                                        // Street address
                                        if let thoroughfare = placeMark?.addressDictionary!["Thoroughfare"] as? NSString {
                                        print("Thoroughfare :- \(thoroughfare)")

                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            })
            
            struct Place {
                let id: Int
                let name: String
                let lat: CLLocationDegrees
                let lng: CLLocationDegrees
                let icon: String
            }
        
            let camera = GMSCameraPosition.camera(withLatitude: (latitude! as NSString).doubleValue, longitude: (longitude! as NSString).doubleValue, zoom: zoom)
            cell.mapView.camera = camera
            do {
                if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                    cell.mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
                } else {
                    NSLog("Unable to find style.json")
                }
            } catch {
                NSLog("One or more of the map styles failed to load. \(error)")
            }
            let places = [
                Place(id: 0, name: countr, lat: (latitude! as NSString).doubleValue, lng: (longitude! as NSString).doubleValue, icon: "i01"),
            ]
                for place in places {
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude: place.lat, longitude: place.lng)
                    marker.title = place.name
                    marker.snippet = "\(countr)"
                    
                    marker.map = cell.mapView
                    markerDict[place.id] = marker
                }
                
            }
            
                        return cell
        }
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CandidateContactTableViewCell", for: indexPath) as! CandidateContactTableViewCell
            
            cell.txtName.placeholder = sender_name
            cell.txtEmail.placeholder = sender_email
            cell.txtSubject.placeholder = sender_subject
            cell.txtViewMsg.text = sender_message
            cell.btnSendMsg.setTitle(btn_txt, for: .normal)
            cell.recId = recId
            cell.recvName = recName
            cell.recvEmail = recvEmail
            
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 130
        }else if (indexPath.section == 1){
            if isFromCandSearch == true{
                 return 0
            }else{
                 return 110
            }
        }else if (indexPath.section == 2){
            return 45
        }else if indexPath.section == 3{
            return aboutCellHeight + 20
        }else if indexPath.section == 4 {
            return skillCellHeight + 90
        } else if indexPath.section == 5
        {
            return aboutCellHeightEdu + eduTitleHeight + eduKeyHeight + 40
        }else if indexPath.section == 6 {
            return aboutCellHeightPro + proTitleHeight + proKeyHeight + 40
        }
        else if indexPath.section == 7 {
            return  aboutCellHeightCer + certTitleHeight + certKeyHeight + 40
        }else if indexPath.section == 8{
            return 250
        }
        else if indexPath.section == 9{
            return videoCellHeight
        }else if indexPath.section == 10{
            if isMapHide == "0"{
                return 0
            }else{
                return 200
            }
        }
        else{
            return 322
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section:
        Int) -> String? {
        

        var locText = ""
        var skillText = ""
            if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
                let obj = dataTabs.data.candTabs
                locText = obj?.loca as! String
                skillText = obj?.skills as! String
        }
       
        if section == 0 {
            return ""
        }else if section == 1{
            return ""
        }
        else if section == 2{
            return ""
        }
        else if section == 3 {
            return txtAbout
        }else if section == 4 {
            return skillText
        }else if section == 5 {
            return txtEducation
        }else if section == 6 {
            return txtProfessional
        }else if section == 7{
            return txtCertification
        }  else if section == 8 {
            return txtPortfolio
        } else if section == 9{
            return txtVideo
        }else if section == 10{
             return locText
        }
        else {
             return recName
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
        }else if section == 1{
            return 0
        }
        else if section == 2{
            return 0
        }
        else{
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.isDragging {
            cell.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 0.3, animations: {
                cell.transform = CGAffineTransform.identity
            })
        }
    }
    
    
    @objc func nokri_btnSaveClicked(_ sender: UIButton){
        
        let user_id = UserDefaults.standard.integer(forKey: "id")
        let id:Int?
        if idCheck == 1 {
            id = userId
        }else{
            id = user_id
        }
        
        let param = ["cand_id":id]
        print(param)
        nokri_resumeSave(parameter: param as NSDictionary)
        
    }
    
    
    @objc func nokri_btnDownloadClicked(_ sender: UIButton){
        print(sender.currentTitle!)
        if let URL = NSURL(string: sender.currentTitle!) {
                load(url: URL as URL, to: URL as URL) {
                    print("ok")
                }
            }
    }
    
    //MARK:- API Calls
    
    
    public func adMob() {
        if UserHandler.sharedInstance.objSaplash?.adMob != nil {
            let objData = UserHandler.sharedInstance.objSaplash?.adMob
            var isShowAd = false
            if let adShow = objData?.show {
                isShowAd = adShow
            }
            if isShowAd {
                var isShowBanner = false
                // var isShowInterstital = false
                if let banner = objData?.is_show_banner {
                    isShowBanner = banner
                }
                //                if let intersitial = objData?.is_show_initial {
                //                    isShowInterstital = intersitial
                //                }
                if isShowBanner {
                   // SwiftyAd.shared.setup(withBannerID: (objData?.banner_id)!, interstitialID: "", rewardedVideoID: "")
                    self.tableView.translatesAutoresizingMaskIntoConstraints = false
                    if objData?.position == "top" {
                        self.view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
                        //SwiftyAd.shared.showBanner(from: self, at: .top)
                    }
                    else {
                        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 60).isActive = true
                        //SwiftyAd.shared.showBanner(from: self, at: .bottom)
                    }
                }
                //                if isShowInterstital {
                //                    SwiftyAd.shared.setup(withBannerID: "", interstitialID: (objData?.interstitalId)!, rewardedVideoID: "")
                //                    SwiftyAd.shared.showInterstitial(from: self)
                //                }
            }
        }
    }
    
    
    func nokri_ProfileData(){
        
        //self.tableView.isHidden = true
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
            let user_id = UserDefaults.standard.integer(forKey: "id")
            let id:Int?
            if idCheck == 1 {
                id = userId
            }else{
                id = user_id
            }
            let param: [String: Any] = [
                "user_id":id!,
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.candidateProfile, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    guard let res = response.value else{return}
                    let responseData = res as! NSDictionary
                    let message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        self.tableView.isHidden = false
                        let data = responseData["data"] as! NSDictionary
                        //let extra = data["extra"] as! NSDictionary
                        //self.title = extra["key"] as? String
                        let basicInfo = data["basic_ifo"] as! NSDictionary
                        self.profileImage = basicInfo["profile_img"] as? String
                        let social =  basicInfo ["social"] as! NSDictionary
                        self.facebook = social["facebook"] as? String
                        self.google = social["google_plus"] as? String
                        self.linkedIn = social["linkedin"] as? String
                        self.twitter = social["twitter"] as? String
                        let candidateContact = data["user_contact"] as! NSDictionary
                        self.recId = (candidateContact["receiver_id"] as? Int)!
                        self.recName = (candidateContact["receiver_name"] as? String)!
                        self.recvEmail = (candidateContact["receiver_email"] as? String)!
                        self.sender_name = (candidateContact["sender_name"] as? String)!
                        self.sender_email = (candidateContact["sender_email"] as? String)!
                        self.sender_subject = (candidateContact["sender_subject"] as? String)!
                        self.sender_message = (candidateContact["sender_message"] as? String)!
                        
                        let scoring = data["cand_scoring"] as! NSDictionary
                        self.scoringKey = (scoring["key"] as? String)!
                        self.scoringValue = (scoring["value"] as? String)!
                        
                        self.btn_txt = (candidateContact["btn_txt"] as? String)!
                        if let array = basicInfo["info"] as? NSArray {
                            self.nokri_basicInfoDataParser(basicInfoArr: array)
                        }
                        if let skilArr = basicInfo["skills"] as? NSArray {
                            self.nokri_skillDataParser(skillArray: skilArr)
                        }
                        let certification = data["certifications"] as! NSDictionary
                        if let certificationArr = certification["certification"] as? NSArray {
                            self.nokri_certificationDataParser(certificationArray: certificationArr)
                        }
                        if let certificationExtraArr = certification["extras"] as? NSArray {
                            self.nokri_certificatoinExtraDataParser(certExtraArray: certificationExtraArr)
                        }
                        let educational = data["Education"] as! NSDictionary
                        if let eduArr = educational["education"] as? NSArray {
                            self.nokri_educationDataParser(educationArray: eduArr)
                        }
                        if let eduArr = educational["extras"] as? NSArray {
                            self.nokri_educationExtraDataParser(eduExtraArray: eduArr)
                        }
                        let professional = data["Profession"] as! NSDictionary
                        if let proArr = professional["profession"] as? NSArray {
                            self.nokri_professionalDataParser(professionalArray: proArr)
                        }
                        if let proExtraArr = professional["extras"] as? NSArray {
                            self.nokri_professionalExtraDataParser(proExtraArray: proExtraArr)
                        }
                        let portfolio = data["portfolio"] as! NSDictionary
                        if let portFollioArr = portfolio["img"] as? NSArray {
                            self.nokri_portFolioDataParser(portfolioArray: portFollioArr)
                        }
                        if let portfolioExtraArr = portfolio["extra"] as? NSArray {
                            self.nokri_portfolioExtraDataParser(portExtraArray: portfolioExtraArr)
                        }
                        if let extraArr = basicInfo["extra"] as? NSArray {
                            self.nokri_extraDataParser(extraArray: extraArr)
                        }
                        
                        if let customFieldsArr = basicInfo["custom_fields"] as? NSArray {
                            self.nokri_customDataParser(customArray: customFieldsArr)
                        }
                        
                        self.nokri_populateData()
                    }else{
                        
                        //self.view.makeToast(message, duration: 1.5, position: .center)
                        self.tableView.isHidden = true
                        self.lblMessage.text = message
                        self.stopAnimating()
                        
                    }
                    
                    self.tableView.reloadData()
                    self.slider.refresh()
                    self.stopAnimating()
                    self.refreshControl.endRefreshing()
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
            
            let user_id = UserDefaults.standard.integer(forKey: "id")
            let id:Int?
            if idCheck == 1 {
                id = userId
            }else{
                id = user_id
            }
            let param: [String: Any] = [
                "user_id": id!,
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.candidateProfile, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    //  DispatchQueue.main.async {
                    guard let res = response.value else{return}
                    //let res = response.value
                    print(res)
                    let responseData = res as! NSDictionary
                    let message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        self.tableView.isHidden = false
                        let data = responseData["data"] as! NSDictionary
                        let extra = data["extra"] as! NSDictionary
                        // self.title = extra["key"] as? String
                       // self.navigationController?.navigationBar.topItem?.title = extra["key"] as? String
                        let basicInfo = data["basic_ifo"] as! NSDictionary
                        self.profileImage = basicInfo["profile_img"] as? String
                        let social =  basicInfo ["social"] as! NSDictionary
                        self.facebook = social["facebook"] as? String
                        self.google = social["google_plus"] as? String
                        self.linkedIn = social["linkedin"] as? String
                        self.twitter = social["twitter"] as? String
                        let candidateContact = data["user_contact"] as! NSDictionary
                        if candidateContact["receiver_id"] != nil{
                            //self.recId = (candidateContact["receiver_id"] as? Int)!
                        }
                        self.recName = (candidateContact["receiver_name"] as? String)!
                        self.recvEmail = (candidateContact["receiver_email"] as? String)!
                        self.sender_name = (candidateContact["sender_name"] as? String)!
                        self.sender_email = (candidateContact["sender_email"] as? String)!
                        self.sender_subject = (candidateContact["sender_subject"] as? String)!
                        self.sender_message = (candidateContact["sender_message"] as? String)!
                        self.btn_txt = (candidateContact["btn_txt"] as? String)!
                        
                        let scoring = data["cand_scoring"] as! NSDictionary
                        self.scoringKey = (scoring["key"] as? String)!
                        
                        if ((scoring["value"] as? String) != nil)  {
                            self.scoringValue = scoring["value"] as! String
                        }
                        
//                        if (scoring["value"] as? String)! != nil{
//                        self.scoringValue = (scoring["value"] as? String)!
//                        }
                        
                        
                        if let array = basicInfo["info"] as? NSArray {
                            self.nokri_basicInfoDataParser(basicInfoArr: array)
                        }
                        if let skilArr = basicInfo["skills"] as? NSArray {
                            self.nokri_skillDataParser(skillArray: skilArr)
                        }
                        let certification = data["certifications"] as! NSDictionary
                        if let certificationArr = certification["certification"] as? NSArray {
                            self.nokri_certificationDataParser(certificationArray: certificationArr)
                        }
                        if let certificationExtraArr = certification["extras"] as? NSArray {
                            self.nokri_certificatoinExtraDataParser(certExtraArray: certificationExtraArr)
                        }
                        let educational = data["Education"] as! NSDictionary
                        if let eduArr = educational["education"] as? NSArray {
                            self.nokri_educationDataParser(educationArray: eduArr)
                        }
                        if let eduArr = educational["extras"] as? NSArray {
                            self.nokri_educationExtraDataParser(eduExtraArray: eduArr)
                        }
                        let professional = data["Profession"] as! NSDictionary
                        if let proArr = professional["profession"] as? NSArray {
                            self.nokri_professionalDataParser(professionalArray: proArr)
                        }
                        if let proExtraArr = professional["extras"] as? NSArray {
                            self.nokri_professionalExtraDataParser(proExtraArray: proExtraArr)
                        }
                        let portfolio = data["portfolio"] as! NSDictionary
                        if let portFollioArr = portfolio["img"] as? NSArray {
                            self.nokri_portFolioDataParser(portfolioArray: portFollioArr)
                        }
                        if let portfolioExtraArr = portfolio["extra"] as? NSArray {
                            self.nokri_portfolioExtraDataParser(portExtraArray: portfolioExtraArr)
                        }
                        if let extraArr = basicInfo["extra"] as? NSArray {
                            self.nokri_extraDataParser(extraArray: extraArr)
                        }
                        if let customFieldsArr = data["custom_fields"] as? NSArray {
                            self.nokri_customDataParser(customArray: customFieldsArr)
                        }
                        self.nokri_populateData()
                    }else{
                        self.tableView.isHidden = true
                        self.lblMessage.text = message
                        //self.view.makeToast(message, duration: 1.5, position: .center)
                        self.stopAnimating()
                    }
                    self.tableView.delegate = self
                    self.tableView.dataSource = self
                    self.tableView.reloadData()
                    self.slider.refresh()
                    self.stopAnimating()
                    self.refreshControl.endRefreshing()
                  //  }
            }
        }
        
    }
    
    func nokri_customDataParser(customArray:NSArray){
        self.customArr.removeAllObjects()
        for item in customArray{
            self.customArr.add(item)
        }
        //self.nokri_populateData()
    }
    
    func nokri_basicInfoDataParser(basicInfoArr:NSArray){
        self.basicInfoKeyArr.removeAllObjects()
        for item in basicInfoArr{
            self.basicInfoKeyArr.add(item)
        }
        //self.nokri_populateData()
    }
    
    func nokri_portFolioDataParser(portfolioArray:NSArray){
        self.portfolioArr.removeAllObjects()
        for item in portfolioArray{
            self.portfolioArr.add(item)
        }
    }
    
    func nokri_skillDataParser(skillArray:NSArray){
        self.skillsArray.removeAllObjects()
        for item in skillArray{
            self.skillsArray.add(item)
        }
    }
    
    func nokri_educationExtraDataParser(eduExtraArray:NSArray){
        self.educationExtraArray.removeAllObjects()
        for item in eduExtraArray{
            self.educationExtraArray.add(item)
        }
    }
    
    func nokri_professionalExtraDataParser(proExtraArray:NSArray){
        self.professionalExtraArray.removeAllObjects()
        for item in proExtraArray{
            self.professionalExtraArray.add(item)
        }
    }
    
    func nokri_portfolioExtraDataParser(portExtraArray:NSArray){
        self.portfolioExtraArray.removeAllObjects()
        for item in portExtraArray{
            self.portfolioExtraArray.add(item)
        }
    }
    
    func nokri_certificatoinExtraDataParser(certExtraArray:NSArray){
        self.certificationExtraArr.removeAllObjects()
        for item in certExtraArray{
            self.certificationExtraArr.add(item)
        }
    }
    
    func nokri_extraDataParser(extraArray:NSArray){
        self.extraArray.removeAllObjects()
        for item in extraArray{
            self.extraArray.add(item)
        }
    }
    
    func nokri_certificationDataParser(certificationArray:NSArray){
        self.certificationArr.removeAllObjects()
        for item in certificationArray{
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
            self.certificationArr.add(arrayOfDictionaries);
        }
    }
    
    func nokri_educationDataParser(educationArray:NSArray){
        self.eductionArr.removeAllObjects()
        for item in educationArray{
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
            self.eductionArr.add(arrayOfDictionaries);
        }
    }
    
    func nokri_professionalDataParser(professionalArray:NSArray){
        self.professionalArr.removeAllObjects()
        for item in professionalArray{
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
            self.professionalArr.add(arrayOfDictionaries);
        }
    }
    
    
    func nokri_resumeSave(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_resumeSave(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true{
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
                self.stopAnimating()
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
    
    func load(url: URL, to localUrl: URL, completion: @escaping () -> ()) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = try! URLRequest(url: url, method: .get)
        showLoader()
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Success: \(statusCode)")
               
                    DispatchQueue.main.async {
                            self.perform(#selector(self.showSuccess), with: nil, afterDelay: 0.0)
                        self.stopAnimating()
                         
                    }
                }
                
//                do {
//                    try FileManager.default.copyItem(at: tempLocalUrl, to: localUrl)
//                    completion()
//                } catch (let writeError) {
//                    print("error writing file \(localUrl) : \(writeError)")
//                }
                
            } else {
                //print("Failure: %@", error?.localizedDescription);
            }
        }
        task.resume()
    }
    
    @objc func showSuccess(){
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Downloaded Successfully"
        hud.detailTextLabel.text = nil
        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
        hud.position = .bottomCenter
        hud.show(in: self.tableView)
        hud.dismiss(afterDelay: 2.0)
    }
    
}
