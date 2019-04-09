//
//  KIdsArraySinglton.swift
//  timeOut
//
//  Created by roman rozenblat on 5/26/18.
//  Copyright © 2018 roman rozenblat. All rights reserved.
//

import UIKit

class KIdsArraySinglton {
    static let sharedInstance = KIdsArraySinglton()
    private static var arrayKids = [Kid]()
    private static var startForground = false
    private static var switchToCollection = false
    static func getStartForground() -> Bool{
       return startForground
    }
    static func setsSwitchToCollection(fromSwitchToCollection switchToCollection:Bool){
        self.switchToCollection = switchToCollection
    }
    static func getSwitchToCollection() -> Bool{
        return self.switchToCollection
    }
    static func setStartForground(fromFroground forground:Bool ){
        self.startForground = forground
    }
    static func appendKid(fromKid kid:Kid){
        arrayKids.append(kid)
    }
    static func isEmpty() -> Bool{
        if arrayKids.count == 0 {
          return true
        }
        else
        {
            return false
        }
    }
    static func getArrayKids() -> Array<Kid>
    {
     return arrayKids
    }
    static func getArrayKids( fromArray  array:inout Array<Kid>){
        array=arrayKids
    }
    static func remove(fromIndex index: Int){
        arrayKids.remove(at: index)
    }
    static func removeAll(){
        arrayKids.removeAll()
    }
    private init() {
        var test : Int
        test = 0
    }
    
    func doSomething() { }
}
