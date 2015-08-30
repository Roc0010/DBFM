//
//  ViewController.swift
//  DBFM
//
//  Created by 彭程 on 15/7/4.
//  Copyright © 2015年 Roc. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var iv: UIImageView!
    @IBOutlet weak var playTime: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var tableView: UITableView!
    
    let identity: String = "douban"
    let audioPlay = MPMoviePlayerController()
    var tableData = NSArray() //歌曲列表数组
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: identity)
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
        }
        requestData()
    }
    
    func requestData() {
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(NSURL(string: "http://douban.fm/j/mine/playlist?channel=0")!) { [unowned self] (data, response, error) -> Void in
            
            if error == nil {
                do {
                    
                    let jsonReslut: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    dispatch_async(dispatch_get_main_queue()) { () -> Void in
                        
                        self.tableData = jsonReslut.objectForKey("song") as! NSArray
                        self.tableView.reloadData()
                        print(jsonReslut)
                        let firDict:NSDictionary = self.tableData[0] as! NSDictionary
                        //获取歌曲文件地址
                        let audioUrl:String = firDict["url"] as! String
                        //播放歌曲
                        let imgUrl:String=firDict["picture"] as! String
                        self.onSetAudio(audioUrl)
                        self.iv.image = UIImage(data: NSData(contentsOfURL: NSURL(string: imgUrl)!)!)
                    }
                }
                 catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func onSetAudio(url: String) {
        
        audioPlay.stop()
        audioPlay.contentURL = NSURL(string: url)
        audioPlay.play()
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
        let imgData = NSData(contentsOfURL: NSURL(string: imgUrl)!)
        cell?.imageView?.image = UIImage(data: imgData!)
        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let rowData = self.tableData[indexPath.row]
        //获取歌曲文件地址
        let audioUrl:String = rowData["url"] as! String
        //播放歌曲
        let imgUrl:String = rowData["picture"] as! String
        onSetAudio(audioUrl)
        iv.image = UIImage(data: NSData(contentsOfURL: NSURL(string: imgUrl)!)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

