//
//  ViewController.swift
//  timeOut
//
//  Created by roman rozenblat on 3/18/18.
//  Copyright © 2018 roman rozenblat. All rights reserved.
//

import UIKit
import UserNotifications
class ViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    var semp : Bool = false
    var displayTimer: Timer!
    @IBAction func resetTimer(_ sender: Any) {
          for name in arrayKids {
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
            }
        }
        startTimerLbl.isEnabled=true
    }
    @IBAction func StopTimer(_ sender: UIButton) {
        for name in arrayKids {
            if name.getName() == nameKId.text {
                name.stopTime()
                name.setTimerEnabled(fromTimer: false)
         }
        }
        startTimerLbl.isEnabled=true
        
    }
    @IBOutlet weak var startTimerLbl: UIButton!
    @IBOutlet weak var nameKId: UILabel!
    @IBOutlet weak var resetButton: UILabel!
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayKids.count
    }
     @objc func runTimedCode(){
        for name in arrayKids {
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
                    if minutes2.text=="0" && minutes1.text=="0" {
                        startTimerLbl.isEnabled=true
                                          }
                    
                }
                
                }
        }
            
            for name in arrayKids {
                if name.isTimerExpired == true {
                   if semp == false {
                    name.isTimerExpired=false
                   
                        
                    semp=true
               let alertController = UIAlertController(title: "Timeout finished", message: "Timeout finished for" + name.getName(), preferredStyle: .alert)
                   
                //then we create a default action for the alert...
                //It is actually a button and we have given the button text style and handler
                //currently handler is nil as we are not specifying any handler
                    let defaultAction = UIAlertAction(title: "OK", style: .default) { _ in
                        self.backToLogin()
                    }
                
                //now we are adding the default action to our alertcontroller
                alertController.addAction(defaultAction)
                alertController.isModalInPopover = true
                
                //and finally presenting our alert using this method
                    present(alertController, animated: true, completion: {
                      
                        print("Done🔨") })
                    }
                   
                }
                
            }
        
        }
    func backToLogin(){
        self.semp=false
    }
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        nameKId.text=arrayKids[row].getName()
        if arrayKids[row].getTimerEnabled()==false{
            startTimerLbl.isEnabled=true
            
        }
        else{
            startTimerLbl.isEnabled=false
        }
        time=arrayKids[row].getTime()
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
        if minutes2.text=="0" && minutes1.text=="0" {
            startTimerLbl.isEnabled=true
            
        }
    }
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
    
        return arrayKids[row].getName()
    }
    var  time=12
    var gameTimer: Timer!
    var arrayKids = [Kid]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
        }
         minutes1.text=String(time)
         minutes2.text=String(time)
        // Do any additional setup after loading the view, typically from a nib.
        minutes1.baselineAdjustment = .alignCenters
        arrayKids.append(Kid(fromName:"Jay",fromAge:7,fromTimerStart:false,fromTimer:7))
        arrayKids.append(Kid(fromName:"Jhon",fromAge:1,fromTimerStart:false,fromTimer:1))
        arrayKids.append(Kid(fromName:"Jim",fromAge:1,fromTimerStart:false,fromTimer:1))
        self.listKIds.delegate = self
        self.listKIds.dataSource = self
        displayTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        
    }
   
    @IBOutlet weak var listKIds: UIPickerView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var minutes2: UILabel!
    @IBOutlet weak var minutes1: UILabel!
    
    @IBAction func startTimer(_ sender: UIButton) {
       
        for name in arrayKids {
            if name.getName() == nameKId.text {
                name.setTimerEnabled(fromTimer:true)
                 startTimerLbl.isEnabled=false
            }
        }
        
        
    }

}

