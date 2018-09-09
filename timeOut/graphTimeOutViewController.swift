//
//  graphTimeOutViewController.swift
//  timeOut
//
//  Created by roman rozenblat on 5/2/18.
//  Copyright © 2018 roman rozenblat. All rights reserved.
//

import UIKit

class graphTimeOutViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
  
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return KIdsArraySinglton.getArrayKids().count
    }
   
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        return KIdsArraySinglton.getArrayKids()[row].getName()
    }
    var kidsFirstName : String = ""
    @IBOutlet weak var kidsPicker: UIPickerView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    var isStartDateFocus : Bool = false
    @IBAction func editStartDate(_ sender: UITextField) {
        viewContainerDate.isHidden = false
        isStartDateFocus = true
        sender.resignFirstResponder()
        
    }
    
    @IBOutlet weak var GrapthBtn: UIButton!
    @IBAction func GraphDoBtn(_ sender: Any) {
        if(startDateTxt.text == "" || endDateTxt.text == "") {
            let alertController = UIAlertController(title: "Warning", message:
                "Date field can't be empty", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        else if trendSwitch.isOn == true {
            performSegue(withIdentifier: "graphChartLine", sender: 0)
        }
        else {
             performSegue(withIdentifier: "graph", sender: 0)
        }
    }
    @IBAction func doneBtn(_ sender: UIButton) {
        viewContainerDate.isHidden = true
    }
    @IBOutlet weak var trendSwitch: UISwitch!
    @IBAction func trendSwitchAction(_ sender: Any) {
        if trendSwitch.isOn == true {
        kidsPicker.isHidden = false
     }
        else
        {
             kidsPicker.isHidden = true
        }
    }
    @IBOutlet weak var viewContainerDate: UIView!
    @IBOutlet weak var startDateTxt: UITextField!
   
    
    @IBOutlet weak var editText: UITextField!
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait)
        self.kidsPicker.delegate = self
        self.kidsPicker.dataSource = self
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent  component: Int) {
        kidsFirstName = KIdsArraySinglton.getArrayKids()[row].getName()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.identifier)
          if trendSwitch.isOn == true {
            let viewControllerLineChart = segue.destination as! lineChartViewControllerGraphViewController
            viewControllerLineChart.startDate = startDateTxt.text!
            viewControllerLineChart.endDate = endDateTxt.text!
            var index=kidsPicker.selectedRow(inComponent: 0)
            viewControllerLineChart.kidFirstName = KIdsArraySinglton.getArrayKids()[index].getName()
           // viewControllerLineChart.kidFirstName = kidsFirstName
        }
          else {
        let viewControllerGraph = segue.destination as! ViewControllerGraph
        
          
         
          viewControllerGraph.startDate = startDateTxt.text!
          viewControllerGraph.endDate = endDateTxt.text!
    }
    }
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.layer.borderWidth = 2.0
        datePicker.layer.borderColor = UIColor.darkGray.cgColor
        kidsPicker.layer.borderWidth = 2.0
        kidsPicker.layer.borderColor = UIColor.darkGray.cgColor
        let c = UIColor(red:CGFloat(CFloat(1)),green:CGFloat(0.7),blue:CGFloat(0.1),alpha:CGFloat(0.8))
        
        datePicker.backgroundColor = c
        //datePicker.layer.borderColor = c.cgColor
        isStartDateFocus = false
        self.kidsPicker.delegate = self
        self.kidsPicker.dataSource = self
        viewContainerDate.isHidden = true
       datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(self.changeDate(sender:)),for: .valueChanged)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func endDateText(_ sender: UITextField) {
        viewContainerDate.isHidden = false
        isStartDateFocus = false
        sender.resignFirstResponder()
    }
    @IBOutlet weak var endDateTxt: UITextField!
    @objc func changeDate(sender: UIDatePicker){
        let dateFormater=DateFormatter()
        dateFormater.dateStyle = .short
        dateFormater.timeStyle = .none
        if isStartDateFocus == true
        {
        startDateTxt.text = "\(dateFormater.string(from: sender.date))"
        }
        else if isStartDateFocus == false{
             endDateTxt.text = "\(dateFormater.string(from: sender.date))"
        }
        
       
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
