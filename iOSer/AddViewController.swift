//
//  AddViewController.swift
//  iOSer
//
//  Created by medicool on 15/2/1.
//  Copyright (c) 2015年 ZK. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var siteName: UITextField!
    
    @IBOutlet weak var siteUrl: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backOrAddData(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        siteName.resignFirstResponder()
        siteUrl.resignFirstResponder()
    }
    
    @IBAction func saveBtnClicked(sender: UIButton) {
//        siteName.text;
//        siteUrl.text;
        
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
