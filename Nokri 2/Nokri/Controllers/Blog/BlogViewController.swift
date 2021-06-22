//
//  BlogViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/13/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit


class BlogViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    

    //MARK:- IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var heightConstraintBanner: NSLayoutConstraint!
   // @IBOutlet weak var adBannerView: GADBannerView!
   // @IBOutlet weak var bannerViewBottom: GADBannerView!
    @IBOutlet weak var heightConstraintBottomBanner: NSLayoutConstraint!
    
    
    //MARK:- Proporties
    
    var blogArr = [BlogPost]()
    var extra:BlogExtra?
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nokri_adMob()
        nokri_blogData()
        collectionView.delegate = self
        collectionView.dataSource = self
        nokri_ltrRtl()
    }

    //MARK:- Custome Functions
    
  func nokri_ltrRtl(){
        let isRtl = UserDefaults.standard.string(forKey: "isRtl")
        if isRtl == "0"{
            self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }else{
            self.addRightBarButtonWithImage(#imageLiteral(resourceName: "menu"))
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
//                SwiftyAd.shared.delegate = self
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
                    //SwiftyAd.shared.setup(withBannerID: (objData?.banner_id)!, interstitialID: "", rewardedVideoID: "")
                    //self.tableView.translatesAutoresizingMaskIntoConstraints = false
                    
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
    
    //MARK:- AdMob Delegate Methods
    
//    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
//        print("Fail to receive ads")
//        print(error)
//    }
//
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
//
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
//                    //print(objData?.banner_id!)
//                    SwiftyAd.shared.setup(withBannerID: (objData?.banner_id)!, interstitialID: "", rewardedVideoID: "")
//                    //self.tableView.translatesAutoresizingMaskIntoConstraints = false
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
    
    
    //MARK:- CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return blogArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BlogCollectionViewCell", for: indexPath) as! BlogCollectionViewCell
        let obj = blogArr[indexPath.row]
        if let name = obj.title{
           // cell.lblName.text = name
            
            let myString = name
//            let myAttribute = [ NSAttributedStringKey.font: UIFont(name: "Montserrat-SemiBold", size: 12.0)! ]
//            let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
//
            
            
//            let data = name.data(using: String.Encoding.unicode)! // mind "!"
//            let attrStr = try? NSAttributedString( // do catch
//                data: data,
//                options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
//                documentAttributes: nil)
//            cell.lblName.font = UIFont(name:"OpenSans",size:12)
            cell.lblName.text = myString
        }
        if let date = obj.date{
            cell.lblDate.text = date
        }
        if let image = URL(string: obj.image){
            cell.imageViewBlog.sd_setImage(with: image, completed: nil)
            if Constants.isiPadDevice{
                cell.heightConstraintImage.constant += 140
                
            }
        }
        
        //print(obj.comments)
        //print(obj.commentInt)
        
        
        if let comment = obj.comments{
           // if obj.comments == 0{
                cell.lblCommentCount.text = String(comment) +  " \(String(describing: extra!.commentTitle!))"
            //}else{
              //  cell.lblCommentCount.text = "\(comment)" + "\(String(describing: extra!.commentTitle!))"
            //}
        }
       // if let detail = obj.excerpt{
             //cell.lblDetail.text = detail
//            let data = detail.data(using: String.Encoding.unicode)! // mind "!"
//            let attrStr = try? NSAttributedString( // do catch
//                data: data,
//                options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
//                documentAttributes: nil)
//            cell.lblDetail.font = UIFont(name:"OpenSans-Regular",size:12)
//            cell.lblDetail.attributedText = attrStr
     //   }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let obj = blogArr[indexPath.row]
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "BlogDetailViewController") as! BlogDetailViewController
        nextViewController.id = obj.postId
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  0
        let collectionViewSize = collectionView.frame.size.width - padding
        if Constants.isiPadDevice{
            return CGSize(width: collectionViewSize/2 - 3, height:350)
        }
        else{
            return CGSize(width: collectionViewSize/2 - 3, height:232)
        }
    
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView.isDragging {
            cell.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 0.3, animations: {
                cell.transform = CGAffineTransform.identity
            })
        }
    }
    
    //MARK:- Blog
    
    func nokri_blogData() {
        let param : [String:Any] = [
            "page_num":"1"
        ]
        self.showLoader()
        UserHandler.nokri_blog(parameter: param as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true{
                self.blogArr = successResponse.data.post
                self.title = successResponse.extra.pageTitle
                self.extra = successResponse.extra
                self.collectionView.reloadData()
                
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
