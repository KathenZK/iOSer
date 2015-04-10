//
//  ForeignTableViewController.swift
//  iOSer
//
//  Created by medicool on 15/1/26.
//  Copyright (c) 2015年 ZK. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchDisplayDelegate{

    var chineseSiteList : [SiteModel] = []
    var englishSiteLite : [SiteModel] = []
    var titleForHeaderInSection : [String] = ["中文","英文"]
    var fliteredSiteNames : [SiteModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 35/255.0, green: 156/255.0, blue: 237/255.0, alpha: 1.0)
        
        var contentOffset = tableView.contentOffset
        contentOffset.y += searchDisplayController!.searchBar.frame.size.height
        tableView.contentOffset = contentOffset
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.hidden = false
        
        chineseSiteList.removeAll(keepCapacity: false)
        englishSiteLite.removeAll(keepCapacity: false)
        modelGetData()
    }
    
    // MARK: - Model get data
    
    func modelGetData()
    {
        var plistPath = NSBundle.mainBundle().pathForResource("ChineseSite", ofType: "plist")
        var data = NSArray(contentsOfFile: plistPath!)
        for dic in data!
        {
            var site = SiteModel(dic: dic as NSDictionary);
            chineseSiteList.append(site)
        }
        
        var plistPath2 = NSBundle.mainBundle().pathForResource("EnglishSite", ofType: "plist")
        var data2 = NSArray(contentsOfFile: plistPath2!)
        for dic in data2!
        {
            var site = SiteModel(dic: dic as NSDictionary);
            englishSiteLite.append(site)
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        if tableView == searchDisplayController?.searchResultsTableView
        {
            return 1
        }
        else
        {
            return 2
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == searchDisplayController?.searchResultsTableView
        {
            return fliteredSiteNames.count
        }
        else
        {
            if section == 0
            {
                return chineseSiteList.count
            }
            else
            {
                return englishSiteLite.count
            }
            
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("reuseIdentifier") as UITableViewCell
        
        var model : SiteModel!
        
        if tableView == searchDisplayController?.searchResultsTableView
        {
            model = fliteredSiteNames[indexPath.row] as SiteModel
            
        }
        else
        {
            if indexPath.section == 0
            {
                model = chineseSiteList[indexPath.row] as SiteModel
            }
            else
            {
                model = englishSiteLite[indexPath.row] as SiteModel
            }
        }
            cell.textLabel?.text = model.siteName
            return cell
        
    }
    
    // MARK: - Table view delegate

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        var model : SiteModel?
        
        if tableView == self.tableView
        {
            if indexPath.section == 0
            {
                model = chineseSiteList[indexPath.row] as SiteModel
            }
            else
            {
                model = englishSiteLite[indexPath.row] as SiteModel
            }

        }
        else
        {
            model = fliteredSiteNames[indexPath.row]
        }
        
        var webVC = WebViewController()
        webVC.urlStr = model!.siteURL
        webVC.siteName = model!.siteName
        navigationController?.pushViewController(webVC, animated:true)
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if tableView == self.tableView
        {
        return 40.0
        }
        else
        {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 55
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
            var view = UIView()
            view.backgroundColor = UIColor(red: 234/255.0, green: 234/255.0, blue: 242/255.0, alpha: 0.7)
            var label = UILabel(frame: CGRectMake(self.view.center.x - 25, 0, 100, 40))
            label.text = titleForHeaderInSection[section]
            view.addSubview(label)
            return view
}
    
    // MARK: - UISearchDisplayDelegate
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool
    {
        
        fliteredSiteNames = chineseSiteList.filter(){
            ($0.siteName.lowercaseString).rangeOfString(searchString.lowercaseString) != nil
        }
        
        var arr = englishSiteLite.filter(){
            ($0.siteName.lowercaseString).rangeOfString(searchString.lowercaseString) != nil
        }
        
        for index in 0 ..< arr.count
        {
            fliteredSiteNames.append(arr[index] as SiteModel)
        }
            return true
    }

}
