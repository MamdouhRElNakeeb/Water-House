//
//  DateFormat.swift
//  goldenrich
//
//  Created by Mamdouh El Nakeeb on 3/29/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit

class DateFormat {
    
    var formatterTime: DateFormatter
    var formatterDate: DateFormatter
    
    var monthes = ["Jan", "Feb", "Mar", "April", "May", "June", "July", "Aug", "Sep", "Oct", "Nov", "Dec"]
    
    init() {
        formatterTime = DateFormatter()
        formatterTime.timeZone = NSTimeZone(name: "UTC+2") as TimeZone!
        formatterTime.dateFormat = "hh:mm a"
        
        formatterDate = DateFormatter()
        formatterDate.timeZone = NSTimeZone(name: "UTC+2") as TimeZone!
        formatterDate.dateFormat = "dd, MMM YYYY"

    }
    
    func getDateStr(dateMilli: Int) -> String {
        let date = NSDate(timeIntervalSince1970: Double(dateMilli))
        return formatterDate.string(from: date as Date)
    }
    
    func getTimeStr(dateMilli: Int) -> String {
        let date = NSDate(timeIntervalSince1970: Double(dateMilli))
        return formatterTime.string(from: date as Date)
    }
    
}

