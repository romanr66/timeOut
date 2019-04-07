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
    @objc dynamic var  startBtnEnable:Bool = true
    @objc dynamic var stopBtnEnable:Bool = false
    @objc dynamic var restBtnEnable:Bool = false
    let dateTimeouts = List<DateTimeOut>()
    convenience init(fromName  name : String, fromAge age :Int, fromStartBtn startBtnEnable : Bool, fromStopBtn stopBtnEnable : Bool, fromRestBtn restBtnEnable : Bool  ) {
        self.init()
        self.name=name
        self.age=age
        self.restBtnEnable = restBtnEnable
        self.startBtnEnable = startBtnEnable
        self.stopBtnEnable = stopBtnEnable
    }
    func getStartBtnEnable() -> Bool {
        return startBtnEnable
    }
    func getStopBtnEnable() -> Bool {
        return stopBtnEnable
    }
    func getRestBtnEnable() -> Bool {
        return restBtnEnable
    }
    func getAge() ->Int{
        return age
    }
    func getName()->String{
        return name
    }
    
    
}
