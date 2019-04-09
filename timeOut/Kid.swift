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
import RealmSwift
class Kid{
    var displayTimerSec: Timer!
    public var startBtnEnable:Bool = true
    public var stopBtnEnable:Bool = false
    public var restBtnEnable:Bool = false
    public var  timeWentToSleep:NSDate;
    var isTimerExpired : Bool = false
    private var seconds:Int=60
    public func getSeconds()->Int{
        return seconds
    }
    
    public func setSeconds(seconds:Int){
        self.seconds=seconds
    }
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
    public func setName(fromName name:String){
        self.name = name
    }
    @objc private  dynamic var age :Int = 0
    public func getAge () -> Int {
        return age;
    }
    public func setAge (formAge age:Int){
        self.age=age
    }
    public func resetAge(){
        self.time=age-1
    }
    private var startTimer:Bool
    public func getTimerEnabled () -> Bool {
        return startTimer;
    }
    public func stopTime(){
      
         if displayTimerSec != nil {
                  displayTimerSec.invalidate()
                  displayTimerSec = nil
        }
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        
    }
    public func setTimerEnabledOnly(fromTimer timer:Bool)
    {
      startTimer=timer
    }
    public func disableTimer(){
        if displayTimerSec != nil {
            displayTimerSec.invalidate()
            displayTimerSec = nil
        }
        
    }
    public func setTimerEnable (fromTimer timer:Bool) {
        self.isTimerExpired=timer
    }
    public func setTimerEnabled (fromTimer timer:Bool) {
        self.isTimerExpired=false
        startTimer=timer;
        if displayTimerSec == nil {
         displayTimerSec = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCodeSec), userInfo: nil, repeats: true)
        }
        let notif = UNMutableNotificationContent()
        notif.title = "TimeOut App !"
        notif.subtitle = "Timer Expired!"
        notif.body = "Time Out for Child " + name + " expired !!!"
        var timeTemp:Int
        if(time==0){
            timeTemp=1
        }
        else
        {
            timeTemp=time
            
        }
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: Double((timeTemp*60)+seconds), repeats: false)
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
            
 
    init(fromName name:String,fromAge age:Int , fromTimerStart startTimer:Bool, fromTimer time:Int,fromStartBtn:Bool , fromStopBtn: Bool,  fromRestBtn: Bool){
        self.name=name
        self.age=age
        self.startTimer=startTimer
        if (time==1){
            self.time=0
        }
        else {
               self.time=time-1
        }
        timeWentToSleep=NSDate()
        startBtnEnable = true
        stopBtnEnable = false
        restBtnEnable = false
    
    }
    
    
    @objc func runTimedCodeSec() {
        seconds = seconds - 1
        if seconds == 0 && time > 0{
            seconds = 60
            time=time-1
        }
        if (time==0 && seconds==0)
        {
           
            self.isTimerExpired=true
            displayTimerSec.invalidate()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            seconds = 0
        }
    }
    @objc func runTimedCode(){
        if(time > 0){
          
            if(time==1){
                time=0
            }
        }
        
            
           
    }
    
}
