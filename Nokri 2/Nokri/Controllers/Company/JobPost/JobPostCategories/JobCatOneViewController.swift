//
//  JobCatOneViewController.swift
//  Nokri
//
//  Created by apple on 1/8/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit



class JobCatOneViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
   

    let appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var jobCatArr = [String]()
    var childArr = [Bool]()
    var keyArray = [Int]()
    var customeDataArray = [JobPostCCustomData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        UserDefaults.standard.set("false", forKey: "custData")
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobCatArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobCatOneTableViewCell", for: indexPath) as! JobCatOneTableViewCell
        
        let cat  = jobCatArr[indexPath.row]
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
        
        cell.btnNext.addTarget(self, action: #selector(JobCatOneViewController.btnNext), for: .touchUpInside)
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    @objc func btnNext(sender: UIButton!){
        
        UserDefaults.standard.set(sender.tag, forKey:"caKey")
        UserDefaults.standard.set("true", forKey: "custData")
        if sender.currentTitle == "false"{
         self.perform(#selector(self.nokri_showNavController1), with: nil, afterDelay: 1)
        }else{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "JobCatSecondViewController") as? JobCatSecondViewController
            vc?.key = sender.tag
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
       
    
    }
    
    @objc func nokri_showNavController1(){
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true)
    }
    

}
