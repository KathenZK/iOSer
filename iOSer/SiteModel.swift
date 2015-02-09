//
//  SiteModel.swift
//  iOSer
//
//  Created by medicool on 15/1/26.
//  Copyright (c) 2015年 ZK. All rights reserved.
//

import Foundation

class SiteModel: NSObject {
   
    var id : String
    var siteName : String
    var siteURL : String
    
    init(id: String, siteName: String, siteURL: String)
    {
        self.id = id
        self.siteName = siteName
        self.siteURL = siteURL
        super.init()
    }

    convenience init(dic: NSDictionary)
    {
        self.init(id: dic["id"] as String, siteName: dic["siteName"] as String, siteURL: dic["siteURL"] as String)
    }
}
