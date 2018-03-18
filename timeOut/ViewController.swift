//
//  ViewController.swift
//  timeOut
//
//  Created by roman rozenblat on 3/18/18.
//  Copyright © 2018 roman rozenblat. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    var  time=12
    var gameTimer: Timer!
    var pickerData: [String] = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
         minutes1.text=String(time)
         minutes2.text=String(time)
        // Do any additional setup after loading the view, typically from a nib.
        minutes1.baselineAdjustment = .alignCenters
       pickerData = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
        self.listKIds.delegate = self
        self.listKIds.dataSource = self
    }

    @IBOutlet weak var listKIds: UIPickerView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var minutes2: UILabel!
    @IBOutlet weak var minutes1: UILabel!
    
    @IBAction func startTimer(_ sender: UIButton) {
        gameTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        
        
    }
@objc func runTimedCode(){
        time=time-1
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

