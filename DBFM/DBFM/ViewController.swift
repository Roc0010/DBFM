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
    
    let identity: String = "douban"
    var tableData = NSArray() //歌曲列表数组
    
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
        let task = session.dataTaskWithURL(NSURL(string: "http://douban.fm/j/mine/playlist?channel=0")!) { [unowned self] (data, response, error) -> Void in
            
            if error == nil {
////
            do {
                
                let jsonReslut: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                self.tableData = jsonReslut.objectForKey("song") as! NSArray
                self.tableView.reloadData()
                print(jsonReslut)
//                NSLog("%@",jsonReslut)
            }
            catch {
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
        
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(identity)
        if cell == nil {
            
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: identity)
        }
        
        let rowData = self.tableData[indexPath.row]
        cell?.textLabel?.text = rowData["title"] as? String
        cell?.detailTextLabel?.text = rowData["artist"] as? String
        let imgUrl = rowData["picture"] as! String
        cell?.imageView?.image = UIImage(named: "detail")
        let imgU = NSURL(string: imgUrl)!
        let imgData = NSData(contentsOfURL: imgU)
        let img = UIImage(data: imgData!)
        cell?.imageView?.image = img
        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

