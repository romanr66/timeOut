//
//  KidsTimeOutRealm.swift
//  timeOut
//
//  Created by roman rozenblat on 5/12/18.
//  Copyright © 2018 roman rozenblat. All rights reserved.
//

import UIKit
import RealmSwift
class KidsTimeOutRealm: Object {
       @objc dynamic  var date = Date()
       @objc dynamic  var name = ""
       var countTimeOut = 0;
    convenience init(fromName  name : String, fromDate date:Date) {
        self.init()
        self.name = name
        self.date = date
    }
    func incCount(){
        countTimeOut = countTimeOut  + 1
    }
    func getCount()->Int{
        return countTimeOut
    }
    func getDate() -> Date{
        return date
    }
    func setDate(fromDate d:Date){
        self.date = d
    }
    func getName()->String{
        return name
    }
    
        
}
