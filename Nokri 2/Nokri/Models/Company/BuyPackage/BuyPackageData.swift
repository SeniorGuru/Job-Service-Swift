//
//  BuyPackageData.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 6/12/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct BuyPackageData{
    
    var isPaypalKey : Bool!
    var isPayuKey : Bool!
    var paymentTypes : [BuyPackagePaymentType]!
    var paypal : BuyPackagePaypal!
    var payu : BuyPackagePayU!
    var products : [BuyPackageProduct]!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        isPaypalKey = dictionary["is_paypal_key"] as? Bool
        isPayuKey = dictionary["is_payu_key"] as? Bool
        paymentTypes = [BuyPackagePaymentType]()
        if let paymentTypesArray = dictionary["payment_types"] as? [[String:Any]]{
            for dic in paymentTypesArray{
                let value = BuyPackagePaymentType(fromDictionary: dic)
                paymentTypes.append(value)
            }
        }
        if let paypalData = dictionary["paypal"] as? [String:Any]{
            paypal = BuyPackagePaypal(fromDictionary: paypalData)
        }
        if let payuData = dictionary["payu"] as? [String:Any]{
            payu = BuyPackagePayU(fromDictionary: payuData)
        }
        products = [BuyPackageProduct]()
        if let productsArray = dictionary["products"] as? [[String:Any]]{
            for dic in productsArray{
                let value = BuyPackageProduct(fromDictionary: dic)
                products.append(value)
            }
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if isPaypalKey != nil{
            dictionary["is_paypal_key"] = isPaypalKey
        }
        if isPayuKey != nil{
            dictionary["is_payu_key"] = isPayuKey
        }
        if paymentTypes != nil{
            var dictionaryElements = [[String:Any]]()
            for paymentTypesElement in paymentTypes {
                dictionaryElements.append(paymentTypesElement.toDictionary())
            }
            dictionary["payment_types"] = dictionaryElements
        }
        if paypal != nil{
            dictionary["paypal"] = paypal.toDictionary()
        }
        if payu != nil{
            dictionary["payu"] = payu.toDictionary()
        }
        if products != nil{
            var dictionaryElements = [[String:Any]]()
            for productsElement in products {
                dictionaryElements.append(productsElement.toDictionary())
            }
            dictionary["products"] = dictionaryElements
        }
        return dictionary
    }
    
}
