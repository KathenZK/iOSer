//
//  AddViewController.swift
//  iOSer
//
//  Created by medicool on 15/2/1.
//  Copyright (c) 2015年 ZK. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var siteName: UITextField!
    
    @IBOutlet weak var siteUrl: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        siteName.resignFirstResponder()
        siteUrl.resignFirstResponder()
    }
    
    @IBAction func saveBtnClicked(sender: UIButton) {
        
        var temDic : Dictionary<String, String> = ["id":"1", "siteName":siteName.text, "siteURL":siteUrl.text]
        
        if segmentedControl.selectedSegmentIndex == 0
        {
            println("0")
            var plistPath = NSBundle.mainBundle().pathForResource("ChineseSite", ofType: "plist")
            var data = NSMutableArray(contentsOfFile: plistPath!)
            data?.addObject(temDic);
            data?.writeToFile(plistPath!, atomically: true)
        }
        else
        {
            println("1")
            var plistPath2 = NSBundle.mainBundle().pathForResource("EnglishSite", ofType: "plist")
            var data2 = NSMutableArray(contentsOfFile: plistPath2!)
            data2?.addObject(temDic);
            data2?.writeToFile(plistPath2!, atomically: true)
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
