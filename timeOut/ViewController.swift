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
import GoogleMobileAds
extension UIFont {
    class func appRegularFontWith( size:CGFloat ) -> UIFont{
        return  UIFont(name: "DS-Digital-BoldItalic", size: size)!
    }
    class func appBoldFontWith( size:CGFloat ) -> UIFont{
        return  UIFont(name: "DS-Digital-BoldItalic", size: size)!
    }
}
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
  
    @IBAction func backButton(_ sender: Any) {
        KIdsArraySinglton.setsSwitchToCollection(fromSwitchToCollection: true)
        for st in KIdsArraySinglton.getArrayKids() {
            if (st.getTimerEnabled()==true){
                
                st.setTimeWentToSleep(fromDate: NSDate())
                
            }
        }
        performSegue(withIdentifier: "backToCollectionView", sender: 0)    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
    }
    
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
        for n in 1...KIdsArraySinglton.getArrayKids().count {
            if KIdsArraySinglton.getArrayKids()[n-1].getName() == nameKId.text {
                     KIdsArraySinglton.getArrayKids()[n-1].startBtnEnable = true
                     KIdsArraySinglton.getArrayKids()[n-1].stopBtnEnable = false
                     KIdsArraySinglton.getArrayKids()[n-1].restBtnEnable = false
            }
        }
        startTimerLbl.isEnabled=true
    }
    func returnFromBack(){
        var array = [Kid]()
        let now = NSDate()
        KIdsArraySinglton.setStartForground(fromFroground: true)
        KIdsArraySinglton.getArrayKids(fromArray: &array)
        for  (index, element) in array.enumerated() {
            //if (array[index].getTimerEnabled()==true){
                guard let date = array[index].getTimeWentToSleep() as Date? else {
                    // date is nil, ignore this entry:
                    
                }
                let dateDiff=now.timeIntervalSince(date)
                let dateDiffRnd=dateDiff.rounded(.up)
                var seconds:Double=Double(array[index].getTime()*60+array[index].getSeconds())
                var totalDiff=seconds-Double(dateDiffRnd)
                var mins = 0
                var secs = totalDiff
                if(totalDiff >= 0){
                    if totalDiff >= 60 {
                        mins = Int(totalDiff / 60)
                        secs = totalDiff - Double(mins * 60)
                    }
                    array[index].setTime(frimTime:mins)
                    array[index].setSeconds(seconds: Int(secs))
                    
                }
                else
                {
                    array[index].setTime(frimTime: 0)
                    array[index].setSeconds(seconds: 0)
                    array[index].disableTimer()
                    array[index].setTimerexpired(fromtimerExpired: true)
                }
                
                
                
                
            }
            // viewController?.refersh()
        //}
    }
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
        let matchedUsers = try! Realm().objects(kidRealm.self)
        if KIdsArraySinglton.getSwitchToCollection()==false {
        
        KIdsArraySinglton.removeAll()
        var temStr:String
        for st in matchedUsers {
            temStr=st.getName() + "  Age- " + String(st.getAge())
            
            KIdsArraySinglton.appendKid(fromKid: Kid(fromName:st.getName(),fromAge:st.getAge(),fromTimerStart:false,fromTimer:st.getAge(),fromStartBtn:true , fromStopBtn: false,  fromRestBtn: false))
        }
        }
        var row : Int = 0
        if CollectionCollectionViewController.transitionFromCollectionView == true {
            row=CollectionCollectionViewController.rowSelected
            picker.selectRow(row, inComponent: 0, animated: true)
        }
        /*Iif(KIdsArraySinglton.getSwitchToCollection() == true){
            returnFromBack()
            
        }*/
       
        if KIdsArraySinglton.getArrayKids().isEmpty == false {
            if let aComponent = picker?.selectedRow(inComponent: 0) {
                row = aComponent
                if (KIdsArraySinglton.getArrayKids().count==row) {
                    row = row - 1
                }
            }
        
            nameKId.text=KIdsArraySinglton.getArrayKids()[row].getName()
           let temp = nameKId.text
            time=KIdsArraySinglton.getArrayKids()[row].getTime()
            startTimerLbl.isEnabled = KIdsArraySinglton.getArrayKids()[row].startBtnEnable
             stopTimer.isEnabled = KIdsArraySinglton.getArrayKids()[row].stopBtnEnable
            resetButton.isEnabled =  KIdsArraySinglton.getArrayKids()[row].restBtnEnable
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
                KIdsArraySinglton.getArrayKids()[row].startBtnEnable = true
                KIdsArraySinglton.getArrayKids()[row].stopBtnEnable = false
                KIdsArraySinglton.getArrayKids()[row].restBtnEnable = true
                
                
                
            }
            secondsLbl.text=String(KIdsArraySinglton.getArrayKids()[row].getSeconds())
        }
       
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
       let b = KIdsArraySinglton.getSwitchToCollection() ;
       if(b == false){
       //   if(KIdsArraySinglton.getSwitchToCollection() == false){
            //KIdsArraySinglton.setsSwitchToCollection(fromSwitchToCollection: true)
            let matchedUsers = try! Realm().objects(kidRealm.self)
            KIdsArraySinglton.removeAll()
            var temStr:String
            for st in matchedUsers {
             temStr=st.getName() + "  Age- " + String(st.getAge())
             
                KIdsArraySinglton.appendKid(fromKid: Kid(fromName:st.getName(),fromAge:st.getAge(),fromTimerStart:false,fromTimer:st.getAge(),fromStartBtn:true , fromStopBtn: false,  fromRestBtn: false))
            
        
       
        }
                  }
        self.listKIds.delegate = self
        self.listKIds.dataSource = self
        showFirst()
    
    }
    @IBAction func StopTimer(_ sender: UIButton) {
        for name in KIdsArraySinglton.getArrayKids() {
            if name.getName() == nameKId.text {
                name.stopTime()
                name.setTimerEnabledOnly(fromTimer: false)
              
               
         }
        }
        for n in 1...KIdsArraySinglton.getArrayKids().count {
            if KIdsArraySinglton.getArrayKids()[n-1].getName() == nameKId.text {
                KIdsArraySinglton.getArrayKids()[n-1].startBtnEnable = true
                KIdsArraySinglton.getArrayKids()[n-1].stopBtnEnable = false
                KIdsArraySinglton.getArrayKids()[n-1].restBtnEnable = true
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
                startTimerLbl.isEnabled = name.startBtnEnable
                stopTimer.isEnabled = name.stopBtnEnable
                resetButton.isEnabled = name.restBtnEnable
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
            if name.getTimerEnabled()==true  {
                time=name.getTime()
               
                    if name.getTimerEnabled()==true && nameKId.text == name.getName() {
                      
                        
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
                
              
                
                
                    if name.getTime() == 0 && name.getSeconds()==0 {
                        startTimerLbl.isEnabled=true
                        stopTimer.isEnabled = false
                        resetButton.isEnabled = true
                        for n in 1...KIdsArraySinglton.getArrayKids().count {
                            if (name.getName()==KIdsArraySinglton.getArrayKids()[n-1].getName()){
                                KIdsArraySinglton.getArrayKids()[n-1].startBtnEnable = false
                                KIdsArraySinglton.getArrayKids()[n-1].stopBtnEnable = false
                                KIdsArraySinglton.getArrayKids()[n-1].restBtnEnable = true
                               // KIdsArraySinglton.getArrayKids()[n-1].setTimerexpired(fromtimerExpired: true)
                                //KIdsArraySinglton.getArrayKids()[n-1].setTimerEnable(fromTimer: false)
                            }
                            
                        }
                        
                       
                                          }
                    
                }
                
                }
        
            
            for name in KIdsArraySinglton.getArrayKids() {
                if name.isTimerExpired == true {
                  if true {
                    for n in 1...KIdsArraySinglton.getArrayKids().count {
                         if KIdsArraySinglton.getArrayKids()[n-1].getName() == name.getName() {
                            KIdsArraySinglton.getArrayKids()[n-1].setTimerexpired(fromtimerExpired: false)
                        }
                    }
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
                    var viewController = UIApplication.shared.keyWindow?.rootViewController
                    var presentedVC = viewController?.presentedViewController
                    while presentedVC != nil {
                        viewController = presentedVC
                        presentedVC = viewController?.presentedViewController
                    }
                //and finally presenting our alert using this method
                    viewController!.present(alertController, animated: true, completion: {
                    
                        print("Done🔨") })
                    secondsLbl.text = "0"
                    startTimerLbl.isEnabled=false
                    stopTimer.isEnabled = false
                    resetButton.isEnabled = true
                    
                   
                            name.setTimerEnabledOnly(fromTimer: false)
                           // name.setTime(frimTime: time);
                          //  name.setSeconds(seconds: 60)
                            //displayTimer.invalidate()
                            name.disableTimer()
                            name.stopTime()
                    
                    
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
        
        startTimerLbl.isEnabled = KIdsArraySinglton.getArrayKids()[row].startBtnEnable
        stopTimer.isEnabled  = KIdsArraySinglton.getArrayKids()[row].stopBtnEnable
        resetButton.isEnabled = KIdsArraySinglton.getArrayKids()[row].restBtnEnable
        
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
        var row : Int = 0
        if CollectionCollectionViewController.transitionFromCollectionView == true {
            row=CollectionCollectionViewController.rowSelected
            picker.selectRow(row, inComponent: 0, animated: true)
        }
        
        var index=picker.selectedRow(inComponent: 0)
        
        if KIdsArraySinglton.getArrayKids().count > 0
        {
            //if(KIdsArraySinglton.getStartForground()==true){
        startTimerLbl.isEnabled = KIdsArraySinglton.getArrayKids()[index].startBtnEnable
         stopTimer.isEnabled = KIdsArraySinglton.getArrayKids()[index].stopBtnEnable
         resetButton.isEnabled = KIdsArraySinglton.getArrayKids()[index].restBtnEnable
        
           // }
           // else
           // {
                /*startTimerLbl.isEnabled = true
                stopTimer.isEnabled = false
                resetButton.isEnabled = false*/
           // }
         time=KIdsArraySinglton.getArrayKids()[index].getTime()
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
        secondsLbl.text=String(KIdsArraySinglton.getArrayKids()[index].getSeconds())
        nameKId.text = KIdsArraySinglton.getArrayKids()[index].getName()
        }
    }
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
    
        return KIdsArraySinglton.getArrayKids()[row].getName()
    }
    var  time=0
    var gameTimer: Timer!
    var bannerView: GADBannerView!
    var models = [String]()
    
    @IBOutlet weak var bView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.translatesAutoresizingMaskIntoConstraints = true
        bView.addSubview(bannerView)
      /*   bView.addConstraints(
         [NSLayoutConstraint(item: bannerView,
         attribute: .bottom,
         relatedBy: .equal,
         toItem: view.safeAreaLayoutGuide.bottomAnchor ,
         attribute: .top,
         multiplier: 1,
         constant: 0),
         NSLayoutConstraint(item: bannerView,
         attribute: .centerX,
         relatedBy: .equal,
         toItem: view,
         attribute: .centerX,
         multiplier: 1,
         constant: 0)
         ])*/
        bannerView.adUnitID = "ca-app-pub-4581114811859260/6457050882"
        let request = GADRequest()
        request.tag(forChildDirectedTreatment: true);        bannerView.rootViewController = self
        bannerView.load(GADRequest());        picker.layer.borderWidth = 2.0
        picker.layer.borderColor = UIColor.darkGray.cgColor
        
        stopTimer.layer.borderWidth = 2.0
        stopTimer.layer.borderColor=UIColor.darkGray.cgColor
        stopTimer.widthAnchor.constraint(equalToConstant: startTimerLbl.titleLabel!.intrinsicContentSize.width + 1 * 20.0).isActive = true
        resetButton.layer.borderWidth = 2.0
        resetButton.layer.borderColor=UIColor.darkGray.cgColor
        resetButton.widthAnchor.constraint(equalToConstant: startTimerLbl.titleLabel!.intrinsicContentSize.width + 1 * 20.0).isActive = true
        startTimerLbl.layer.borderWidth = 2.0
        startTimerLbl.layer.borderColor=UIColor.darkGray.cgColor
        startTimerLbl.widthAnchor.constraint(equalToConstant: startTimerLbl.titleLabel!.intrinsicContentSize.width + 1 * 20.0).isActive = true
        startTimerLbl.layer.cornerRadius = 2.0
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
        }
        secondsLbl.font = UIFont.appRegularFontWith(size: 40)
        minutes1.font = UIFont.appRegularFontWith(size: 53)
        minutes2.font = UIFont.appRegularFontWith(size: 53)
         minutes1.text=String(time)
         minutes2.text=String(time)
        // Do any additional setup after loading the view, typically from a nib.
        minutes1.baselineAdjustment = .alignCenters
       
        self.listKIds.delegate = self
        self.listKIds.dataSource = self
        displayTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        displaySecondsTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(runTimedSecCode), userInfo: nil, repeats: true)
        startTimerLbl.isEnabled = true
        stopTimer.isEnabled = false
        resetButton.isEnabled = false
        
        
        
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
                    kid.id=999
                    kid.name=name.getName().trimmingCharacters(in: NSCharacterSet.whitespaces)
                    realm.add(kid)
                    try! realm.commitWrite() 
                }
               
                 name.setTimerEnabled(fromTimer:true)
                 startTimerLbl.isEnabled=false
                 stopTimer.isEnabled=true
                 resetButton.isEnabled=false
                let content = UNMutableNotificationContent()
                content.title = "Timout Over"
                content.body = "Time Out Over for - " + (nameKId.text)!
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(name.getTime()*60+name.getSeconds()), repeats: false)
                
                let request = UNNotificationRequest(identifier: name.getName(), content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                
            }
        }
        for n in 1...KIdsArraySinglton.getArrayKids().count {
            if KIdsArraySinglton.getArrayKids()[n-1].getName() == nameKId.text {
                KIdsArraySinglton.getArrayKids()[n-1].startBtnEnable = false
                KIdsArraySinglton.getArrayKids()[n-1].stopBtnEnable = true
                KIdsArraySinglton.getArrayKids()[n-1].restBtnEnable = false
            }
        }
        
        
    }

}

