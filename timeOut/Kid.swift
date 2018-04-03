//
//  Kid.swift
//  timeOut
//
//  Created by roman rozenblat on 3/19/18.
//  Copyright © 2018 roman rozenblat. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit
class Kid{
    public var  timeWentToSleep:NSDate;
    var isTimerExpired : Bool = false
    public func getTimerExpired()->Bool{
        return isTimerExpired
    }
    public func setTimeWentToSleep(fromDate dt:NSDate){
        timeWentToSleep=dt
        
    }
    public func getTimeWentToSleep() -> NSDate{
        return self.timeWentToSleep
    }
    public func setTimerexpired(fromtimerExpired time:Bool){
        self.isTimerExpired=time
    }
    var timeOutTimer: Timer!
    private var time : Int=0
    public  func  getTime() ->Int {
     return time
    }
    public func setTime(frimTime time :Int) {
        self.time=time
    }
   
    private var name : String
    public func getName () -> String {
        return name;
    }
    private var age :Int
    public func getAge () -> Int {
        return age;
    }
    public func setAge (formAge age:Int){
        self.age=age
    }
    public func resetAge(){
        self.time=age
    }
    private var startTimer:Bool
    public func getTimerEnabled () -> Bool {
        return startTimer;
    }
    public func stopTime(){
        timeOutTimer.invalidate()
        
    }
    public func setTimerEnabledOnly(fromTimer timer:Bool)
    {
      startTimer=timer
    }
    public func setTimerEnabled (fromTimer timer:Bool) {
        self.isTimerExpired=false
        startTimer=timer;
        timeOutTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        let notif = UNMutableNotificationContent()
        notif.title = "TimeOut App !"
        notif.subtitle = "Timer Expired!"
        notif.body = "Time Out for Child " + name + " expired !!!"
        
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(time*60), repeats: false)
        let request = UNNotificationRequest(identifier: name, content:  notif, trigger: notifTrigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil{
                print(error!)
                //completion(false)
            }else{
                //completion(true)
            }
        }
    }
            
 
    init(fromName name:String,fromAge age:Int , fromTimerStart startTimer:Bool, fromTimer time:Int){
        self.name=name
        self.age=age
        self.startTimer=startTimer
        self.time=time
        timeWentToSleep=NSDate()
        
    
    }
    @objc func runTimedCode(){
        if(time > 0){
          time=time-1
        }
        if (time==0)
        {
            timeOutTimer.invalidate()
            self.isTimerExpired=true
        }
            
           
    }
    
}
