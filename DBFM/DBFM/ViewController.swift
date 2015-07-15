//
//  ViewController.swift
//  DBFM
//
//  Created by 彭程 on 15/7/4.
//  Copyright © 2015年 Roc. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var iv: UIImageView!
    @IBOutlet weak var playTime: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var tableView: UITableView!
    
//    var
    let identity: String = "douban"
    var useData = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: identity)
//        dispatch_async(dispatch_get_main_queue()) { () -> Void in
//            
//        }
        requestData()
    }
    
    func requestData() {
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(NSURL(string: "http://douban.fm/j/mine/playlist?channel=0")!) { (data, response, error) -> Void in
            
            if error == nil {
////
            do {
                
                let jsonReslut: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                print(jsonReslut)
            }catch {
                print(error)
            }
            }
        }
        task?.resume()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(identity)
        if cell == nil {
            
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: identity)
        }
        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

