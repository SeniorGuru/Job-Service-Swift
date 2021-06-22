//
//  JobCatThreeViewController.swift
//  Nokri
//
//  Created by apple on 1/8/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit
import Alamofire

class JobCatThreeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

       @IBOutlet weak var tableView: UITableView!
         
        
        var jobSubCatArrat = NSMutableArray()

          
          var jobSubCatArr = [String]()
          var childArr = [Bool]()
          var keyArray = [Int]()
        
          var key:Int = 0
        
          
          override func viewDidLoad() {
              super.viewDidLoad()

              // Do any additional setup after loading the view.
              tableView.dataSource = self
              tableView.delegate = self
              nokri_childCategories(id: key)
          }
          

          func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              return  jobSubCatArr.count
          }
          
          func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              
              let cell = tableView.dequeueReusableCell(withIdentifier: "JobCatThreeTableViewCell", for: indexPath) as! JobCatThreeTableViewCell
              
              let cat  = jobSubCatArr[indexPath.row]
              cell.lblTitle.text = cat
              let key = keyArray[indexPath.row]
              cell.btnNext.tag = key
              let child = childArr[indexPath.row]
              cell.btnNext.setTitle(child.description, for: .normal)

              if cell.btnNext.currentTitle == "true" {
                  cell.imgView.image = UIImage(named: "next")
                  
              }else{
                  cell.imgView.image = UIImage(named: "")
              }
              
              cell.btnNext.addTarget(self, action: #selector(JobCatThreeViewController.btnNext), for: .touchUpInside)
              return cell
          }
          
          func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
              return 50
          }
        
        
        @objc func btnNext(sender: UIButton!){
                
             UserDefaults.standard.set(sender.tag, forKey:"ca3Key")
            
                if sender.currentTitle == "false"{
                   let appColorNew = UserDefaults.standard.string(forKey: "app_Color")
                    sender.titleLabel?.textColor = UIColor(hex: appColorNew!)
                    self.perform(#selector(self.nokri_showNavController1), with: nil, afterDelay: 1)
        
                }else{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "JobCatFourViewController") as? JobCatFourViewController
                    
                      vc?.key = sender.tag
                    
                    self.navigationController?.pushViewController(vc!, animated: true)
                }
                
               
            }
        
    @objc func nokri_showNavController1(){
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 4], animated: true)
    }
        
        func nokri_childCategories(id:Int){
            
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
                
                Alamofire.request(Constants.URL.baseUrl+Constants.URL.childCat, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                    .responseJSON { response in
                        
                        let responseData = response.value as! NSArray
                        print(responseData)
                        
                        self.nokri_jobSubCatDataParser(jobCatArr: responseData)
                        self.nokeri_dropDownSetup()
                        self.stopAnimating()
                        self.tableView.reloadData()
                        
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
                
                Alamofire.request(Constants.URL.baseUrl+Constants.URL.childCat, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                    .responseJSON { response in
                        
                        let responseData = response.value as! NSArray
                        print(responseData)
                        
                        self.nokri_jobSubCatDataParser(jobCatArr: responseData)
                        self.nokeri_dropDownSetup()
                        self.stopAnimating()
                        self.tableView.reloadData()
                        
                }
            }
            
          
        }
        
        
        func nokri_jobSubCatDataParser(jobCatArr:NSArray){
               
              self.jobSubCatArrat.removeAllObjects()
               for item in jobCatArr{
                self.jobSubCatArrat.add(item)
               }
               
           }

        func nokeri_dropDownSetup(){
            

            let jobSubCategory = self.jobSubCatArrat as? [NSDictionary]

            for itemDict in jobSubCategory! {
                if let catObj = itemDict["value"] as? String{
                    if catObj == ""{
                       continue
                    }
                    jobSubCatArr.append(catObj)
                }
                if let keyObj = itemDict["key"] as? Int{
                    keyArray.append(keyObj)
                }


                if let hasChild = itemDict["has_child"] as? Bool{
                    print(hasChild)
                    childArr.append(hasChild)
                
                }

               
            }
            
            
           
                
        }
        

    }
