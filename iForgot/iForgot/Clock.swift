//
//  Clock.swift
//  iForgot
//
//  Created by Jeremy on 4/11/17.
//  Copyright © 2017 Jeremy. All rights reserved.
//

import UIKit

struct Point {
    static var pointZero: Point {
        return Point.init(x: 0, y: 0)
    }
    
    var x: Double?
    var y: Double?
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}

enum RepeatType: Int {
    case once
    case weekDay
    case everyDay
    case weekend
}

class Clock: NSObject, NSCoding {
    var time: String?
    var interval: Int?
    var location: Point?
    private var x: Double {
        return (self.location?.x)!
    }
    private var y: Double {
        return (self.location?.y)!
    }
    var radius: Int?
    var repeatType: RepeatType?
    var switchStatus: Bool = true
    
    init(time: String, interval: Int, location: Point, radius: Int, repeatType: RepeatType) {
        self.time = time
        self.interval = interval
        self.location = location
        self.radius = radius
        self.repeatType = repeatType
    }
    
    override init() {
        self.time = ""
        self.interval = 0
        self.location = Point.pointZero
        self.radius = 0
        self.repeatType = RepeatType.once
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(time, forKey: "time")
        aCoder.encode(interval, forKey: "interval")
        aCoder.encode(x, forKey: "x")
        aCoder.encode(y, forKey: "y")
        aCoder.encode(radius, forKey: "radius")
        aCoder.encode(repeatType?.rawValue, forKey: "repeatType")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.time = aDecoder.decodeObject(forKey: "time") as! String
        self.interval = aDecoder.decodeInteger(forKey: "interval")
        let x = aDecoder.decodeDouble(forKey: "x")
        let y = aDecoder.decodeDouble(forKey: "y")
        self.location = Point(x: x, y: y)
        self.radius = aDecoder.decodeInteger(forKey: "radius")
        self.repeatType = aDecoder.decodeObject(forKey: "repeatType") as! RepeatType
    }
}
