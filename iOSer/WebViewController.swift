//
//  WebViewController.swift
//  iOSer
//
//  Created by medicool on 15/1/26.
//  Copyright (c) 2015年 ZK. All rights reserved.
//

import UIKit
import Social

class WebViewController: UIViewController, UIWebViewDelegate {

    var urlStr : String?
    var siteName :String?
    var webView : UIWebView?
    
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    
    var toolBar : UIToolbar?
    var jumpUrl : NSURL?
    
    var leftButton : UIButton?
    var centerButton : UIButton?
    var rightButton : UIButton?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addWebViewAndLoadData(urlStr!)
        
        addActivityIndicator()
        
        addToolBar()

    }

    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        navigationController?.navigationBar.hidden = true
        
    }
    
    func addWebViewAndLoadData(str: String)
    {
        
        webView = UIWebView(frame: self.view.frame)
        webView?.backgroundColor = UIColor.whiteColor()
        view.addSubview(webView!)
        webView?.delegate = self
        
        var url = NSURL(string: str)
        var urlRequest = NSURLRequest(URL: url!)
        webView!.loadRequest(urlRequest)
        
    }
    
    func addActivityIndicator ()
    {
        activityIndicator.frame = CGRect(origin: view.center, size: CGSize(width: 15, height: 15))
        view.addSubview(activityIndicator)
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool
    {
        jumpUrl = request.URL
        activityIndicator.startAnimating()
        return true
    }

    func webViewDidFinishLoad(webView: UIWebView)
    {
        activityIndicator.stopAnimating()
        
        if webView.canGoForward
        {
            centerButton!.setImage(UIImage(named: "News_Navigation_Forward_Highlight"), forState: UIControlState.Normal)
        }
        else
        {
            centerButton!.setImage(UIImage(named: "News_Navigation_Forward"), forState: UIControlState.Normal)
        }

    }
    
    func addToolBar()
    {
        let weight : CGFloat = 50.0
        let height : CGFloat = 40.0
        
        toolBar = UIToolbar(frame: CGRect(origin: CGPoint(x: 0, y: self.view.frame.height - height), size: CGSize(width: self.view.frame.width, height: height)))
        toolBar?.backgroundColor = UIColor.whiteColor()
        view.addSubview(toolBar!)

        leftButton = UIButton(frame: CGRectMake(0, 0, weight, height))
        leftButton!.setImage(UIImage(named: "News_Navigation_Back_Highlight"), forState: UIControlState.Normal)
        leftButton!.addTarget(self, action: "goBack", forControlEvents: UIControlEvents.TouchUpInside)
        var leftBarButton = UIBarButtonItem(customView: leftButton!)
        
        centerButton = UIButton(frame: CGRectMake(0, 0, weight, height))
        centerButton!.setImage(UIImage(named: "News_Navigation_Forward"), forState: UIControlState.Normal)
        centerButton!.addTarget(self, action: "forward", forControlEvents: UIControlEvents.TouchUpInside)
        var centerBarButton = UIBarButtonItem(customView: centerButton!)
        
        rightButton = UIButton(frame: CGRectMake(0, 0, weight, height))
        rightButton!.setImage(UIImage(named: "News_Navigation_Share_Highlight"), forState: UIControlState.Normal)
        rightButton!.addTarget(self, action: "share", forControlEvents: UIControlEvents.TouchUpInside)
        var rightBarButton = UIBarButtonItem(customView: rightButton!)
        
        var fillBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        toolBar?.setItems([leftBarButton, fillBarButton, centerBarButton, fillBarButton, rightBarButton], animated: true)
        
    }
    
    // MARK: - Operation on toolBar
    
    func goBack ()
    {
        webView?.goBack()
        
        if !webView!.canGoBack
        {
            navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func forward ()
    {
        activityIndicator.stopAnimating()
        webView?.goForward()
    }
    
    func share ()
    {
        var slcVC = SLComposeViewController(forServiceType: SLServiceTypeSinaWeibo)
        slcVC.setInitialText("“\(siteName!)”中的这篇博客写的真好，快来围观吧～")
        slcVC.addImage(UIImage(named: "ImageForSharing"))
        slcVC.addURL(jumpUrl!)
        presentViewController(slcVC, animated: true, completion: nil)
    }
    
}
