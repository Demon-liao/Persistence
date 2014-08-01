//
//  BIDFourLine.swift
//  Persistence
//
//  Created by demon on 14-7-31.
//  Copyright (c) 2014年 demon. All rights reserved.
//

import UIKit

class BIDFourLine: NSObject ,NSCoding,NSCopying{
    var lines:NSArray?
    let kLinesKey:NSString="kLinesKey"
    
    init() {
        
    }
    init(coder aDecoder: NSCoder!) {
        self.lines = aDecoder.decodeObjectForKey(kLinesKey) as? NSArray
    }
    func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(self.lines, forKey: kLinesKey)
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject! {
        var copy:BIDFourLine=BIDFourLine()
        var linesCopy:NSMutableArray=NSMutableArray.array()
        for line in self.lines!{
            linesCopy.addObject(line.copyWithZone(zone))
        }
        copy.lines=linesCopy
        return copy
    }
}
