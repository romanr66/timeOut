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
    static func appendKid(fromKid kid:Kid){
        arrayKids.append(kid)
    }
    static func getArrayKids() -> Array<Kid>
    {
     return arrayKids
    }
    static func remove(fromIndex index: Int){
        arrayKids.remove(at: index)
    }
    static func removeAll(){
        arrayKids.removeAll()
    }
    private init() { }
    
    func doSomething() { }
}
