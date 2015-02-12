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
        
        var tableVC : TableViewController = TableViewController()
        var model : SiteModel = SiteModel(id: "1", siteName: siteName.text, siteURL: siteUrl.text)
        
        if segmentedControl.selectedSegmentIndex == 0
        {
            println(0)
            tableVC.chineseSiteList.append(model)
    
        }
        else
        {
            println(1)
            tableVC.englishSiteLite.append(model)
        }
        
//        tableVC.tableView.reloadData()
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
