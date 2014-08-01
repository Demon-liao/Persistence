//
//  ViewController.swift
//  Persistence
//
//  Created by demon on 14-7-29.
//  Copyright (c) 2014年 demon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //@IBOutlet var lineFields:[UITextField]
    //需要strong 否则会报错
    @IBOutlet strong var lineFields: NSArray!
    let kRootKey="kRootKey"
    
    var dataFilePath:NSString{
        get{
            var paths:NSArray=NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
            var documentsDirectory:NSString=paths.objectAtIndex(0) as NSString
//            return documentsDirectory.stringByAppendingPathComponent("data.plist") as NSString
            return documentsDirectory.stringByAppendingPathComponent("data.archive") as NSString
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println(22)
        var filePath:NSString=self.dataFilePath
        if(NSFileManager.defaultManager().fileExistsAtPath(filePath)){
            
            /*
            var array:NSArray=NSArray(contentsOfFile: filePath)
            for(var i=0; i<4; i++){
                var theField:UITextField=self.lineFields[i] as UITextField
                theField.text=array[i] as String
            }
            */
            var data:NSData=NSMutableData(contentsOfFile: filePath)
            var unarchiver:NSKeyedUnarchiver=NSKeyedUnarchiver(forReadingWithData: data)
            var fourLines:BIDFourLine=unarchiver.decodeObjectForKey(kRootKey) as BIDFourLine
            unarchiver.finishDecoding()
            for(var i=0; i<4; i++){
                var theField:UITextField=self.lineFields[i] as UITextField
                theField.text=fourLines.lines![i] as String
            }
            
        }
        var app:UIApplication=UIApplication.sharedApplication()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("applicationWillResignActive:"), name: UIApplicationWillResignActiveNotification, object: app)
        // Do any additional setup after loading the view, typically from a nib.
    }
    func applicationWillResignActive(notification:NSNotification){
        var filePath:NSString=self.dataFilePath
//        var array:NSArray=(self.lineFields as NSArray).valueForKey("text") as NSArray
//        array.writeToFile(filePath, atomically: true)
        
        var fourLines:BIDFourLine=BIDFourLine()
        fourLines.lines=(self.lineFields as NSArray).valueForKey("text") as? NSArray
        var data:NSMutableData=NSMutableData()
        var archiver:NSKeyedArchiver=NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(fourLines, forKey: kRootKey)
        archiver.finishEncoding()
        data.writeToFile(filePath, atomically: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

