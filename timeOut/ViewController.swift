//
//  ViewController.swift
//  timeOut
//
//  Created by roman rozenblat on 3/18/18.
//  Copyright © 2018 roman rozenblat. All rights reserved.
//

import UIKit
import UserNotifications
import RealmSwift
import AVFoundation
class ViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var secondsLbl: UILabel!
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    @IBOutlet weak var picker: UIPickerView!
    var semp : Bool = false
    var displayTimer: Timer!
    var displaySecondsTimer: Timer!
    var seconds : Int = 60;
  
   

    @IBAction func resetTimer(_ sender: Any) {
          for name in KIdsArraySinglton.getArrayKids() {
            if name.getName()==nameKId.text{
                name.resetAge()
            
            time=name.getTime()
            
            switch time{
            case 12:
                minutes2.text="1"
                minutes1.text="2"
            case 11:
                minutes2.text="1"
                minutes1.text="1"
            case 10:
                minutes2.text="1"
                minutes1.text="0"
            default:
                minutes2.text="0"
                minutes1.text=String(time)
               
            }
              name.setTimerEnabledOnly(fromTimer: false)
            secondsLbl.text=String("60")
                name.setTime(frimTime: time);
                name.setSeconds(seconds: 60)
            }
        }
        startTimerLbl.isEnabled=true
    }
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
       
    }
    func applicationWillEnterForeground(application: UIApplication) {
        
        // app will enter in foreground
        // this method is called on first launch when app was closed / killed and every time app is reopened or change status from background to foreground (ex. mobile call)
        refersh()
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        
        // app becomes active
        // this method is called on first launch when app was closed / killed and every time app is reopened or change status from background to foreground (ex. mobile call)
        refersh()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let matchedUsers = try! Realm().objects(kidRealm.self)
        KIdsArraySinglton.removeAll()
        var temStr:String
        for st in matchedUsers {
         temStr=st.getName() + "  Age- " + String(st.getAge())  
         
            KIdsArraySinglton.appendKid(fromKid: Kid(fromName:st.getName(),fromAge:st.getAge(),fromTimerStart:false,fromTimer:st.getAge()))
        }
        self.listKIds.delegate = self
        self.listKIds.dataSource = self
        showFirst()
        if startTimerLbl.isEnabled==false{
             stopTimer.isEnabled=true
            
        }
        else{
            stopTimer.isEnabled=false
        }
      
    
    }
    @IBAction func StopTimer(_ sender: UIButton) {
        for name in KIdsArraySinglton.getArrayKids() {
            if name.getName() == nameKId.text {
                name.stopTime()
               
         }
        }
        
        startTimerLbl.isEnabled=true
        stopTimer.isEnabled=false
        resetButton.isEnabled=true
    }
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var startTimerLbl: UIButton!
    @IBOutlet weak var nameKId: UILabel!
   
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return KIdsArraySinglton.getArrayKids().count
    }
    func refersh() {
        for name in KIdsArraySinglton.getArrayKids() {
            if name.getTimerEnabled()==true && nameKId.text == name.getName() {
                time=name.getTime()
                
                switch time{
                case 12:
                    minutes2.text="1"
                    minutes1.text="2"
                case 11:
                    minutes2.text="1"
                    minutes1.text="1"
                case 10:
                    minutes2.text="1"
                    minutes1.text="0"
                default:
                    minutes2.text="0"
                    minutes1.text=String(time)
                    if minutes2.text=="0" && minutes1.text=="0"  && secondsLbl.text == "0" {
                        startTimerLbl.isEnabled=true
                        stopTimer.isEnabled = false
                    }
                    
                }
               secondsLbl.text=String(name.getSeconds())
            }
        }
    }
    @objc func runTimedSecCode(){
        for name in KIdsArraySinglton.getArrayKids() {
            if name.getTimerEnabled()==true && nameKId.text == name.getName() {
                secondsLbl.text=String(name.getSeconds())
            }
        }
    }
     @objc func runTimedCode(){
        for name in KIdsArraySinglton.getArrayKids() {
            if name.getTimerEnabled()==true && nameKId.text == name.getName() {
                time=name.getTime()
              
                switch time{
                case 12:
                    minutes2.text="1"
                    minutes1.text="2"
                case 11:
                    minutes2.text="1"
                    minutes1.text="1"
                case 10:
                    minutes2.text="1"
                    minutes1.text="0"
                default:
                    minutes2.text="0"
                    minutes1.text=String(time)
                    if minutes2.text=="0" && minutes1.text=="0" && secondsLbl.text=="0" {
                        startTimerLbl.isEnabled=true
                        stopTimer.isEnabled = false
                        resetButton.isEnabled = true
                        name.setTimerexpired(fromtimerExpired: true)
                                          }
                    
                }
                
                }
        }
            
            for name in KIdsArraySinglton.getArrayKids() {
                if name.isTimerExpired == true {
                   if semp == false {
                    name.isTimerExpired=false
                    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [name.getName()])
                    semp=true
               let alertController = UIAlertController(title: "Timeout finished", message: "Timeout finished for - " + name.getName(), preferredStyle: .alert)
                   
                //then we create a default action for the alert...
                //It is actually a button and we have given the button text style and handler
                //currently handler is nil as we are not specifying any handler
                    let defaultAction = UIAlertAction(title: "OK", style: .default) { _ in
                        self.backToLogin()
                    }
                
                //now we are adding the default action to our alertcontroller
                alertController.addAction(defaultAction)
                alertController.isModalInPopover = true
                    let systemSoundID: SystemSoundID = 1304
                    
                    // to play sound
                    AudioServicesPlaySystemSound (systemSoundID)
                //and finally presenting our alert using this method
                    present(alertController, animated: true, completion: {
                    
                        print("Done🔨") })
                    secondsLbl.text = "0"
                    startTimerLbl.isEnabled=false
                    stopTimer.isEnabled = false
                    resetButton.isEnabled = true
                    
                    for name in KIdsArraySinglton.getArrayKids() {
                        if name.getName()==nameKId.text{
                            name.setTimerEnabledOnly(fromTimer: false)
                            name.setTime(frimTime: time);
                            name.setSeconds(seconds: 60)
                            //displayTimer.invalidate()
                            name.disableTimer()
                            name.stopTime()
                        }
                    }
                    }
                   
                }
                
            }
        
        }
    func backToLogin(){
        self.semp=false
    }
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        nameKId.text=KIdsArraySinglton.getArrayKids()[row].getName()
        if KIdsArraySinglton.getArrayKids()[row].getTimerEnabled()==false{
            startTimerLbl.isEnabled=true
            
        }
        else{
            startTimerLbl.isEnabled=false
        }
        time=KIdsArraySinglton.getArrayKids()[row].getTime()
        switch time{
        case 12:
            minutes2.text="1"
            minutes1.text="2"
        case 11:
            minutes2.text="1"
            minutes1.text="1"
        case 10:
            minutes2.text="1"
            minutes1.text="0"
        default:
            minutes2.text="0"
            minutes1.text=String(time)
        }
        if minutes2.text=="0" && minutes1.text=="0" && secondsLbl.text=="0" {
            startTimerLbl.isEnabled=true
            stopTimer.isEnabled = false
            
        }
        secondsLbl.text=String(KIdsArraySinglton.getArrayKids()[row].getSeconds())
       
        
    }
    func showFirst(){
        var index=picker.selectedRow(inComponent: 0)
        if KIdsArraySinglton.getArrayKids().count > 0
        {
        time=KIdsArraySinglton.getArrayKids()[index].getTime()
        switch time{
        case 12:
            minutes2.text="1"
            minutes1.text="1"
        case 11:
            minutes2.text="1"
            minutes1.text="0"
        case 10:
            minutes2.text="9"
            minutes1.text="0"
        default:
            minutes2.text="0"
            
            minutes1.text=String(time)
        }
        if minutes2.text=="0" && minutes1.text=="0" && secondsLbl.text=="0" {
            startTimerLbl.isEnabled=true
            stopTimer.isEnabled = false
            
        }
        secondsLbl.text=String(KIdsArraySinglton.getArrayKids()[0].getSeconds())
        nameKId.text = KIdsArraySinglton.getArrayKids()[0].getName()
        }
    }
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
    
        return KIdsArraySinglton.getArrayKids()[row].getName()
    }
    var  time=12
    var gameTimer: Timer!
    
    var models = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
        }
         minutes1.text=String(time)
         minutes2.text=String(time)
        // Do any additional setup after loading the view, typically from a nib.
        minutes1.baselineAdjustment = .alignCenters
       
        self.listKIds.delegate = self
        self.listKIds.dataSource = self
        displayTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        displaySecondsTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(runTimedSecCode), userInfo: nil, repeats: true)
        
        
    }
   
    @IBOutlet weak var listKIds: UIPickerView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var minutes2: UILabel!
    @IBOutlet weak var minutes1: UILabel!
    
    @IBOutlet weak var stopTimer: UIButton!
    @IBAction func startTimer(_ sender: UIButton) {
        let realm = try! Realm()
     /*  var dateStr = "2018-05-10"
        
        // Set date format
        var dateFmt = DateFormatter()
        dateFmt.timeZone = NSTimeZone.default
        dateFmt.dateFormat =  "yyyy-MM-dd"*/
        
        // Get NSDate for the given string
        //let date = dateFmt.date(from: dateStr)
        for name in KIdsArraySinglton.getArrayKids() {
            if name.getName() == nameKId.text {
                let kid=KidsTimeOutRealm(fromName:name.getName(),fromDate: Date())
               
                
               // let dateTimeOut = DateTimeOut(fromDate:date!)
               
                 try! realm.write {
                     realm.add(kid)
                }
                 name.setTimerEnabled(fromTimer:true)
                 startTimerLbl.isEnabled=false
                 stopTimer.isEnabled=true
                 resetButton.isEnabled=false
                let content = UNMutableNotificationContent()
                content.title = "Timout Over"
                content.body = "Time Out Over for - " + (nameKId.text)!
                content.sound = UNNotificationSound.default()
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(name.getTime()*60+name.getSeconds()), repeats: false)
                
                let request = UNNotificationRequest(identifier: name.getName(), content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                
            }
        }
        
        
    }

}

