//
//  BlogDetailExtra.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/27/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct  BlogDetailExtra{
    
    var commentForm : BlogDetailCommentForm!
    var commentTitle : String!
    var loadMore : String!
    var pageTitle : String!
    var publish : BlogDetailPublish!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        if let commentFormData = dictionary["comment_form"] as? [String:Any]{
            commentForm = BlogDetailCommentForm(fromDictionary: commentFormData)
        }
        commentTitle = dictionary["comment_title"] as? String
        loadMore = dictionary["load_more"] as? String
        pageTitle = dictionary["page_title"] as? String
        if let publishData = dictionary["publish"] as? [String:Any]{
            publish = BlogDetailPublish(fromDictionary: publishData)
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if commentForm != nil{
            dictionary["comment_form"] = commentForm.toDictionary()
        }
        if commentTitle != nil{
            dictionary["comment_title"] = commentTitle
        }
        if loadMore != nil{
            dictionary["load_more"] = loadMore
        }
        if pageTitle != nil{
            dictionary["page_title"] = pageTitle
        }
        if publish != nil{
            dictionary["publish"] = publish.toDictionary()
        }
        return dictionary
    }
    
}
