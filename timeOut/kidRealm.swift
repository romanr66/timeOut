//
//  kidRealm.swift
//  timeOut
//
//  Created by roman rozenblat on 4/25/18.
//  Copyright © 2018 roman rozenblat. All rights reserved.
//

import UIKit
import RealmSwift

   

class kidRealm: Object {
    @objc dynamic  var age:Int = 0
    @objc dynamic  var name:String = ""
    
    let dateTimeouts = List<DateTimeOut>()
    convenience init(fromName  name : String, fromAge age :Int) {
        self.init()
        self.name=name
        self.age=age
    }
    func getAge() ->Int{
        return age
    }
    func getName()->String{
        return name
    }
    func addDateTimeOut(fromDate d:NSDate)
    {
        dateTimeouts.append(DateTimeOut(fromDate: d))
    }
}
