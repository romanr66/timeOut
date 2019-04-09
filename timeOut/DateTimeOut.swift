//
//  DateTimeOut.swift
//  timeOut
//
//  Created by roman rozenblat on 4/29/18.
//  Copyright © 2018 roman rozenblat. All rights reserved.
//

import UIKit
import RealmSwift
class DateTimeOut: Object {
   @objc dynamic var created = Date()
    convenience init(fromDate d:Date){
        self.init()
        self.created=d
    }
    public func getDate()->Date{
     return created
    }
}
