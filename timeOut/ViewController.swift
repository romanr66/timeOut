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
    var displayTimer: Timer!
    @IBOutlet weak var startTimerLbl: UIButton!
    @IBOutlet weak var nameKId: UILabel!
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
                }
             
            }
        }
    }// The data to return for the row and component (column) that's being passed in
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
        arrayKids.append(Kid(fromName:"Jhon",fromAge:8,fromTimerStart:false,fromTimer:8))
        arrayKids.append(Kid(fromName:"Jim",fromAge:9,fromTimerStart:false,fromTimer:2))
        self.listKIds.delegate = self
        self.listKIds.dataSource = self
        displayTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        
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

