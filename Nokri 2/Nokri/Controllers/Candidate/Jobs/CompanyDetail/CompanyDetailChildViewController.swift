//
//  CompanyDetailChildViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/1/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Alamofire
import GoogleMaps
import GooglePlaces

class CompanyDetailChildViewController: UIViewController,IndicatorInfoProvider,UITableViewDelegate,UITableViewDataSource {

    //MARK:- IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightContraint: NSLayoutConstraint!
    @IBOutlet var mainView: UIView!
    
    
    //MARK:- Proporties
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var infoArray = NSMutableArray()
    var aboutCellHeight : CGFloat = 0.0;
    var titleAboutCompany:String?
    var titleProfileDetail:String?
    var keyArray = [String]()
    var valueArray = [String]()
    var latitude:String?
    var longitude:String?
    var latCheck:Bool = true
    //var isMapHide = false
    
    //View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate  = self
        tableView.dataSource = self
        
        //self.view.heightAnchor = tableView.contentSize.height
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        tableViewHeightContraint.constant = 1400
        print("\(tableViewHeightContraint.constant)")
        keyArray = UserDefaults.standard.stringArray(forKey: "arr")!
        valueArray = UserDefaults.standard.stringArray(forKey: "arr2")!
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        var title:String?
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            title = dataTabs.data.compnyPublicJobs.details
        }
        return IndicatorInfo(title: title)
    }

    //MARK:- Custome Functions
    
    func nokri_PopulateData(){
        
       
    }
    
    //MARK:- Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return 1
        }else if section == 1{
            return valueArray.count
        }
        else{
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutCompanyTableViewCell", for: indexPath) as! AboutCompanyTableViewCell
            
            
            let valueAbout = UserDefaults.standard.string(forKey: "valueAbout")
            if valueAbout == nil{
                let alert = Constants.showBasicAlert(message: "Please try again")
                self.present(alert, animated: true, completion: nil)
            }else{
                let htmlString = valueAbout
                let data = htmlString?.data(using: String.Encoding.unicode)! // mind "!"
                let attrStr = try? NSAttributedString( // do catch
                    data: data!,
                    options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                    documentAttributes: nil)
                
                if let ab = attrStr{
                    cell.lblAbout.attributedText = ab
                }
                
                self.aboutCellHeight = (cell.lblAbout.attributedText?.height(withConstrainedWidth: self.view.frame.size.width))!+16;
            }
           
            //cell.lblAbout.text = "not provided"
            return cell
            
        }else if indexPath.section == 1{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileDetailTableViewCell", for: indexPath) as! ProfileDetailTableViewCell
            
            //if keyArray.count == valueArray.count{
                cell.lblKey.text = keyArray[indexPath.row]
                cell.lblValue.text = valueArray[indexPath.row]
//            }else{
//                let alert = Constants.showBasicAlert(message: "Please try again")
//                self.present(alert, animated: true, completion: nil)
//            }
     
            return cell
            
        }else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell", for: indexPath) as! LocationTableViewCell
            
            var markerDict: [Int: GMSMarker] = [:]
            let zoom: Float = 20
     
            //MARKL:- Map
            
            struct Place {
                let id: Int
                let name: String
                let lat: CLLocationDegrees
                let lng: CLLocationDegrees
                let icon: String
            }

            latitude = UserDefaults.standard.string(forKey: "lat")
            longitude = UserDefaults.standard.string(forKey: "long")
            
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
                Place(id: 0, name: "MrMins", lat: (latitude! as NSString).doubleValue, lng: (longitude! as NSString).doubleValue, icon: "i01"),
                ]
            
            for place in places {
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: place.lat, longitude: place.lng)
                marker.title = place.name
                marker.snippet = "Custom snipet message \(place.name)"
                marker.map = cell.mapView
                markerDict[place.id] = marker
            }
      
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let about = UserDefaults.standard.string(forKey: "keyAbout")
        let detail = UserDefaults.standard.string(forKey: "detail")
        let location = UserDefaults.standard.string(forKey: "loc")
        
        if section == 0{
            return about
        }else if section == 1 {
            return detail
        }else{
            return location
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let isMapHide = UserDefaults.standard.string(forKey: "isEmpMapShow")
        if indexPath.section == 0 {
            return aboutCellHeight
        }else if indexPath.section == 1 {
            return 40
        }
        else{
            if isMapHide == "1"{
                return 800
            }else{
                return 0
            }
            
        }
        
    }
   
}
