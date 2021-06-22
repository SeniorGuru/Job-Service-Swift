//
//  PackagesViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/18/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import DropDown
import SwiftyStoreKit
//import Stripe
import JGProgressHUD

var sharedSecret = "f15ca9f2986f47989445806737ef0c96"
 var inApp_id = ""

class NetworkActivityIndicatorManager:NSObject{
    
    private static var loadingCount = 0
    class func networkOperationStart(){
        if loadingCount == 0{
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        loadingCount += 1
    }
    
    class func networkOperationFinish(){
        if loadingCount > 0{
            loadingCount -= 1
        }
        if loadingCount == 0{
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
}

class PackagesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource/*PayPalPaymentDelegate*/ {

//    var environment:String = PayPalEnvironmentSandbox {
//        willSet(newEnvironment) {
//            if (newEnvironment != environment) {
//                PayPalMobile.preconnect(withEnvironment: newEnvironment)
//            }
//        }
//    }
//    var payPalConfig = PayPalConfiguration() // default
    
    //MARK:- IBOutlets

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightConstraintBanner: NSLayoutConstraint!
   // @IBOutlet weak var adBannerView: GADBannerView!
   // @IBOutlet weak var bannerViewBottom: GADBannerView!
    @IBOutlet weak var heightConstraintBottomBanner: NSLayoutConstraint!
    
    
    //MARK:- Proporties
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var lblText:String?
    var productsArray = [BuyPackageProduct]()
    var premiumArr = [BuyPackagePremiumJob]()
    let dropDownPackages = DropDown()
    var paymentTypeArray = [BuyPackagePaymentType]()
    var packageId :Int?
    var payPal:BuyPackagePaypal?
    var buyPackageExtraIos:BuyPackageExtraIos?
    var packagePrice:String?
    var priceFull :String?
    var onlyPrice:String?
    var productName:String?
    var productName2:String?
    var payPalParameters = [String:Any]()
    var bundleID = "com.scriptsbundle.jobZone"
    var isButtonHide = true
    var isBuyPkgFree = false

    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        nokri_ltrRtl()
        nokri_adMob()
        //showSearchButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         nokri_buyPackageData()
    }
    
    func nokri_ltrRtl(){
        let isRtl = UserDefaults.standard.string(forKey: "isRtl")
        if isRtl == "0"{
            self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }else{
            self.addRightBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }
    }
    
    //MARK:- AdMob Delegate Methods
    
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
    
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        return adBannerView
    //    }
    //
    //    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        return adBannerView!.frame.height
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
    
    //MARK:- InApp Purchase
    
    func nokri_MoveToInAppPurchases() {
        self.purchaseProduct(productID: inApp_id)
    }
    
    func getInfo() {
        NetworkActivityIndicatorManager.networkOperationStart()
        self.showLoader()
        SwiftyStoreKit.retrieveProductsInfo([inApp_id], completion: {
            result in
            NetworkActivityIndicatorManager.networkOperationFinish()
            self.stopAnimating()
            self.showAlert(alert: self.alertForProductRetrivalInfo(result: result))
        })
    }
    
    func purchaseProduct(productID: String) {
        NetworkActivityIndicatorManager.networkOperationStart()
        self.showLoader()
        print(productID)
        SwiftyStoreKit.purchaseProduct(productID, completion: {
            result in
          
            NetworkActivityIndicatorManager.networkOperationFinish()
            self.stopAnimating()
            if case .success(let product) = result {
                if product.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(product.transaction)
                }
                self.showAlert(alert: self.alertForPurchasedResult(result: result))
                let param: [String: Any] = [
                    "package_id": self.packageId!,
                    "payment_from": "cash_on_delivery"
                ]
                self.nokri_paymentPost(parameter: param as NSDictionary)
            }
            else{
                self.showAlert(alert: self.alertForPurchasedResult(result: result))
            }
        })
    }
    
    func restorePurchase() {
        NetworkActivityIndicatorManager.networkOperationStart()
        self.showLoader()
        SwiftyStoreKit.restorePurchases(atomically: true,  completion: {
            result in
            NetworkActivityIndicatorManager.networkOperationFinish()
            self.stopAnimating()
            for product in result.restoredPurchases {
                if product.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(product.transaction)
                }
            }
            self.showAlert(alert: self.alertForRestorePurchase(result: result))
        })
    }
    
    func verifyReceipt() {
        NetworkActivityIndicatorManager.networkOperationStart()
        self.showLoader()
        let validator = AppleReceiptValidator(service: .production, sharedSecret: sharedSecret)
        SwiftyStoreKit.verifyReceipt(using: validator, completion: {
            result in
            NetworkActivityIndicatorManager.networkOperationFinish()
            self.stopAnimating()
            self.showAlert(alert: self.alertForVerifyReceipt(result: result))
            
            
            if case .error(let error)  = result {
                if case .noReceiptData = error {
                    self.refreshReceipt()
                }
            }
        })
    }
    
    func verifyPurchase() {
        NetworkActivityIndicatorManager.networkOperationStart()
        self.showLoader()
        let validator = AppleReceiptValidator(service: .production, sharedSecret: sharedSecret)
        SwiftyStoreKit.verifyReceipt(using: validator, completion: {
            result in
            switch result {
            case .success(let receipt):
                let productID = inApp_id
                let purchaseResult = SwiftyStoreKit.verifyPurchase(productId: productID, inReceipt: receipt)
                self.showAlert(alert: self.alertForVerifyPurchase(result: purchaseResult))
                
            case .error(let error):
                self.showAlert(alert: self.alertForVerifyReceipt(result: result))
                
                if case .noReceiptData = error {
                    self.refreshReceipt()
                }
            }
        })
    }
    
    func refreshReceipt() {
        let validator = AppleReceiptValidator(service: .production, sharedSecret: sharedSecret)
        SwiftyStoreKit.verifyReceipt(using: validator, completion: {
            result in
            self.showAlert(alert: self.alertForRefreshReceipt(result: result))
        })
    }

    //MARK:- Custome Functions
    
    //Convert data to json string
    func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    func nokri_dropDownSetup(){
        
        var valueArr = [String]()
        //var keyArr = [String]()
        /*
        for obj in paymentTypeArray{
            if obj.value == "InApp Purchase"{
                valueArr.append(obj.value)
                keyArr.append(obj.value)
            }
            break
        }
 */
        
        if buyPackageExtraIos?.payment_type == "InApp Purchases"{
            if buyPackageExtraIos?.in_app_on == true{
                 valueArr.append((buyPackageExtraIos?.title_text)!)
            }else{
                for index in 0..<productsArray.count {
                    if let cell  = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? PackagesTableViewCell {
                        
                        
                        cell.viewDropDown.isHidden = true
                        
                    }
                }
            }
            
           
        }
        //dropDownPackages.dataSource = keyArr
         dropDownPackages.dataSource = valueArr
          dropDownPackages.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.lblText = item
            if item == "Payment By Check"{
                let param: [String: Any] = [
                    "package_id": self.packageId!,
                    "payment_from": "cheque"
                ]
                self.nokri_paymentPost(parameter: param as NSDictionary)
            }
            
            if item == "InApp Purchases"{
                self.purchaseProduct(productID: inApp_id)
            }
            
            if item == "Bank Transfer"{
                let param: [String: Any] = [
                    "package_id": self.packageId!,
                    "payment_from": "bank_transfer"
                ]
                self.nokri_paymentPost(parameter: param as NSDictionary)
            }
            
            if item == "Cash On Deleivery"{
                let param: [String: Any] = [
                    "package_id": self.packageId!,
                    "payment_from": "cash_on_delivery"
                ]
                self.nokri_paymentPost(parameter: param as NSDictionary)
            }
            
            if item == "PayPal"{
           /*     let item1 = PayPalItem(name: self.productName!, withQuantity: 1, withPrice: NSDecimalNumber(string: self.onlyPrice), withCurrency: (self.payPal?.currency)!, withSku: nil)

                print(self.productName!)
                let items = [item1]
                let subtotal = PayPalItem.totalPrice(forItems: items)

                // Optional: include payment details
                let shipping = NSDecimalNumber(string: "0.0")
                let tax = NSDecimalNumber(string: "0.0")
                let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)

                let total = subtotal.adding(shipping).adding(tax)

                let payment = PayPalPayment(amount: total, currencyCode: (self.payPal?.currency)!, shortDescription: self.productName!, intent: .sale)

                payment.items = items
                payment.paymentDetails = paymentDetails

                let amountInString = String(describing: payment.amount)
                //parameters to send in final server call
                self.payPalParameters = ["amount": amountInString, "currency_code": payment.currencyCode, "short_description": payment.shortDescription, "intent": "sale"]


                if (payment.processable) {
                    let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: self.payPalConfig, delegate: self)
                    self.present(paymentViewController!, animated: true, completion: nil)
                }
                else {
                    // This particular payment will always be processable. If, for
                    // example, the amount was negative or the shortDescription was
                    // empty, this payment wouldn't be processable, and you'd want
                    // to handle that here.
                    print("Payment not processalbe: \(payment)")
                }*/
            }
            
            if item == "Stripe"{
                //if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                    /*
                    let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                    let dataTabs = SplashRoot(fromDictionary: objData)
                    let obj = dataTabs.data.extra.stripePkey
                    if let stripeKey = obj {
                        STPPaymentConfiguration.shared().publishableKey = stripeKey
                    }
                    let stripeController = self.storyboard?.instantiateViewController(withIdentifier: "StripeViewController") as! StripeViewController
                    stripeController.packageId = self.packageId!
                    stripeController.packageName = item
                    self.navigationController?.pushViewController(stripeController, animated: true)*/

              //  }
            }
        }
        dropDownPackages.reloadAllComponents()
        
        DropDown.startListeningToKeyboard()
        DropDown.appearance().textColor = UIColor.black
        DropDown.appearance().textFont = UIFont.systemFont(ofSize: 12)
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor(hex:appColorNew!)
        DropDown.appearance().cellHeight = 40
    }
    /*
    func payPalConfigueration(){
    
        if payPal?.mode == "sandbox"{
            PayPalMobile.initializeWithClientIds(forEnvironments: [
                PayPalEnvironmentSandbox: payPal?.apiKey! as Any ])
        }else{
            PayPalMobile .initializeWithClientIds(forEnvironments: [PayPalEnvironmentProduction: payPal?.apiKey! as Any])
        }
      //  [PayPalMobile preconnectWithEnvironment:PayPal_Environment];
        PayPalMobile.preconnect(withEnvironment: environment)
        payPalConfig.acceptCreditCards = false
        payPalConfig.merchantName = "Glixes Technologies."
        payPalConfig.merchantPrivacyPolicyURL = URL(string:(payPal?.privecyUrl)!)
        payPalConfig.merchantUserAgreementURL = URL(string: (payPal?.agreementUrl)!)
        payPalConfig.languageOrLocale = Locale.preferredLanguages[0]
        payPalConfig.payPalShippingAddressOption = .payPal
    
    }
    
    // PayPalPaymentDelegate
    
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
       
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        print("PayPal Payment Success !")
        paymentViewController.dismiss(animated: true, completion: { () -> Void in
            // send completed confirmaion to your server
            print("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
            
            let resultDictionary = completedPayment.confirmation as NSDictionary
            
            let response: AnyObject  = resultDictionary.object(forKey: "response") as AnyObject
            let payPalToken = response.object(forKey: "id")
            let paymentClient  = self.json(from: self.payPalParameters)
            let param: [String: Any] = [
                "package_id": self.packageId!,
                "payment_from": "paypal",
                "source_token":payPalToken!,
                "payment_client": paymentClient!
            ]
            print(param)
            self.paymentPost(parameter: param as NSDictionary)
            
        })
    }
    */
    //MARK:- TableView
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PackagesTableViewCell", for: indexPath) as! PackagesTableViewCell
        let obj = productsArray[indexPath.row]
    
        if obj.isFree == "1"{
            cell.lblTitle.text = obj.productTitle
            cell.lblProductPrice.text = obj.productPriceOnly
            cell.lblDropDown.text = obj.productBtn
            cell.iconDropDown.isHidden = true
            cell.btnDropDown.titleLabel?.text = obj.isFree //obj.productPriceOnly
            //cell.lblDropDown.textAlignment = NSTextAlignment.right
        }else{
            cell.lblTitle.text = obj.productTitle
            let pr = obj.productPrice
            if let index = pr!.range(of: ".")?.lowerBound {
                let substring = pr![..<index]
                let string = String(substring)
                print(string)  // "ora"
                cell.lblProductPrice.text = pr
                cell.iconDropDown.isHidden = false
                //cell.lblDropDown.textAlignment = NSTextAlignment.center
            }
            cell.lblDropDown.text = obj.productBtn //lblText ?? "Select Option"
            cell.btnDropDown.setTitle(obj.product_ios_inapp, for: .normal)
        }
        
        cell.btnDropDown.addTarget(self, action: #selector(PackagesViewController.nokri_btnDropDownClicked), for: .touchUpInside)
        cell.btnDropDown.tag = Int(obj.productId)!
       // print(obj.premiumJobs)
        cell.premiumArray = obj.premiumJobs
        cell.lblDays.text = obj.daysValue
        cell.lblTxtValidity.text = obj.daysText
        let freeAdVal = String(obj.freeAdsValue)
        cell.lblNoOfCand.text = freeAdVal
        cell.lblCandSearch.text = obj.freeAdsText
        print(isButtonHide)
        if isButtonHide == true{
            cell.viewDropDown.isHidden = false
        }
        //cell.tableView.reloadData()
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 506
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.isDragging {
            cell.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 0.3, animations: {
                cell.transform = CGAffineTransform.identity
            })
        }
    }
    
    @objc func nokri_btnDropDownClicked(_ sender: UIButton){
       
        print("Pkg id: \(String(describing: packageId))")
        if sender.titleLabel?.text == "1" {
            print("It is Free .")
            isBuyPkgFree = true
            let param: [String: Any] = [
                "package_id": sender.tag, //self.packageId!,
                "payment_from": "free"
            ]
            self.nokri_paymentPost(parameter: param as NSDictionary)
        }else{
            dropDownPackages.anchorView = sender
            packageId = sender.tag
            print(packageId!)
            packagePrice = sender.titleLabel?.text!
            inApp_id = packagePrice!
            print("Price is : \(inApp_id)")
            dropDownPackages.show()
        }
   /*
        let price = packagePrice
        let fullNameArr = price?.components(separatedBy: " ")
        priceFull  = fullNameArr?[0]
        onlyPrice = fullNameArr?[1]
        productName = fullNameArr![2]
        if productName == "Stripe"{
             productName = "stripe"
        }else if productName == "Paypal"{
             productName = "paypal"
        }else if productName == "Bank Transfer"{
             productName = "bank_transfer"
        }else if productName == "cash_on_deleivery"{
            productName = "Cash On Deleivery"
        }else if productName == "Payment By Check"{
             productName = "cheque"
        }else if productName == "Payu"{
             productName = "Payu"
        }else if productName == "Paystack"{
             productName = "Paystack"
        }else{
             productName = "authorize.net"
        }
        */
        
    }
    
    //MARK:- API Calls
    
    func nokri_buyPackageData() {
        self.showLoader()
        UserHandler.nokri_buyPackage(success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success {
                self.productsArray = successResponse.data.products
                self.title = successResponse.extra.pageTitle
                self.paymentTypeArray = successResponse.data.paymentTypes
                self.payPal = successResponse.data.paypal
                self.buyPackageExtraIos = successResponse.extra.extraIos
                self.isButtonHide = successResponse.extra.extraIos.in_app_on
                for obj in successResponse.data.products{
                    self.premiumArr = obj.premiumJobs
                }
                self.nokri_dropDownSetup()
                //self.payPalConfigueration()
                self.tableView.reloadData()
            }
            else {
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
            }
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
    
    func nokri_paymentPost(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_payment(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true{
             
                if self.isBuyPkgFree == false{
                    self.perform(#selector(self.nokri_showPaymentComplete), with: nil, afterDelay: 1.5)
                }else{
                    print("Nothing.")
                    let hud = JGProgressHUD(style: .dark)
                    hud.textLabel.text = successResponse.message
                    hud.detailTextLabel.text = nil
                    hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                    hud.position = .bottomCenter
                    hud.show(in: self.view)
                    hud.dismiss(afterDelay: 2.0)

                  //self.view.makeToast(successResponse.message, duration: 1.5, position: .bottom)
                }
             
            }
            else {
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
            }
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
    
    @objc func nokri_showPaymentComplete(){
        let paymentCompleteController = self.storyboard?.instantiateViewController(withIdentifier: "PaymentCompleteViewController") as! PaymentCompleteViewController
        self.navigationController?.pushViewController(paymentCompleteController, animated: true)
    }
}

extension PackagesViewController {
    func alertWithTitle(title: String, message: String)-> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
    }
    
    func showAlert(alert: UIAlertController) {
        guard let _ = self.presentedViewController else {
            self.present(alert, animated: true, completion: nil)
            return
        }
    }
    
    func alertForProductRetrivalInfo(result: RetrieveResults)-> UIAlertController {
        if let product = result.retrievedProducts.first {
            let priceString = product.localizedPrice!
            return alertWithTitle(title: product.localizedTitle, message: "\(product.localizedDescription) - \(priceString)")
        }
        else if let invalidProductID = result.invalidProductIDs.first {
            return alertWithTitle(title: "Could Not retrieve Info", message: "Invalid Product ID: \(invalidProductID)")
        }
        else {
            let errorString = result.error?.localizedDescription ?? "Unknown Error. Please Contact Support"
            return alertWithTitle(title: "Could not retrieve info", message: errorString)
        }
    }
    
    func alertForPurchasedResult(result: PurchaseResult)-> UIAlertController {
        
        switch result {
        case .success(let purchase):
            print("Purchase SuccessFfull: \(purchase.productId)")
            return alertWithTitle(title: "Thank You", message: "Purchase Completed")
        case .error(let error):
            return alertWithTitle(title: "Error", message: "\(error)")
        }
    }
    
    func alertForRestorePurchase(result: RestoreResults)-> UIAlertController {
        
        if result.restoredPurchases.count > 0 {
            print("restore Failed \(result.restoredPurchases)")
            return alertWithTitle(title: "Restore Failed", message: "Error. Please Contact Support")
        }
        else if result.restoredPurchases.count > 0 {
            return alertWithTitle(title: "Purchase Restored", message: "All Purchases Have been restored")
        }
        else {
            return alertWithTitle(title: "Nothing to restore", message: "No previous purchases were made")
        }
    }
    
    
    func alertForVerifyReceipt(result: VerifyReceiptResult)-> UIAlertController {
        
        switch result {
        case .success( _):
            return alertWithTitle(title: "Receipt Verified", message: "Receipt Verified Remotely")
        case .error(let error):
            switch error {
            case .noReceiptData:
                return alertWithTitle(title: "Receipt Verification", message: "No receipt data found, application will try to get a new one. Try again")
            default:
                return alertWithTitle(title: "Receipt Verification", message: "Receipt Verification Failed.")
            }
        }
    }
    
    
    func alertForVerifySubscription(result: VerifySubscriptionResult)-> UIAlertController {
        switch result {
        case .purchased(let expiryDate):
            return alertWithTitle(title: "Product is Purchased", message: "Product is valid until \(expiryDate)")
        case .notPurchased:
            return alertWithTitle(title: "Not Purchased", message: "This product has never been purchased")
        case .expired(let expiryDate):
            return alertWithTitle(title: "Product Expired", message: "Product is expire since \(expiryDate)")
        }
    }
    
    
    func alertForVerifyPurchase(result: VerifyPurchaseResult)-> UIAlertController {
        switch result {
        case .purchased:
            return alertWithTitle(title: "Product is purchased", message: "Product will not expire")
        case .notPurchased:
            return alertWithTitle(title: "Product not purchased", message: "Product has never been purchased")
        }
    }
    
    func alertForRefreshReceipt(result: VerifyReceiptResult) -> UIAlertController {
        switch result {
        case .success( _):
            return alertWithTitle(title: "Receipt refresh", message: "receipt refresh successfully")
        case .error( _):
            return alertWithTitle(title: "Receipt refresh failed", message: "Receipt refresh failed")
        }
    }
}
