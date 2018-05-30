//
//  ViewControllerGraph.swift
//  timeOut
//
//  Created by roman rozenblat on 5/6/18.
//  Copyright © 2018 roman rozenblat. All rights reserved.
//

import UIKit
import Charts
import RealmSwift
class ViewControllerGraph: UIViewController {
    var kidsArray = [String]()
    var KidCountArray = [KidsTimeOutRealm]()
    public var startDate : String = ""
    public var endDate : String = ""
    var dataSet: BarChartDataSet!
    var values =  [Double]()
    weak var axisFormatDelegate: IAxisValueFormatter?
   override func viewWillAppear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.all)
        
    }
    @IBOutlet weak var stackV: UIStackView!
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            var  frm : CGRect = self.stackV.frame
            frm.size.height = self.stackV.frame.height / 2.0
            self.stackV.frame = frm;

            //stackV.axis = .horizontal
          //  stackV.center = CGPoint(x: (UIScreen.main.bounds.width / 2), y: (UIScreen.main.bounds.height / 8))
            barChart.data?.notifyDataChanged()
            barChart.notifyDataSetChanged()
            barChart.setNeedsDisplay()
            
        }
        else
        {
             stackV.axis = .horizontal
        }
        
        
    }
    func GetDateFromString(DateStr: String)-> Date
    {
        let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
        let DateArray = DateStr.components(separatedBy: "/")
        let components = NSDateComponents()
        components.year = Int("20"+DateArray[2])!
        components.month = Int(DateArray[0])!
        components.day = Int(DateArray[1])!
        components.timeZone = TimeZone(abbreviation: "GMT+0:00")
        let date = calendar?.date(from: components as DateComponents)
        
        return date!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let kidsR = try! Realm().objects(KidsTimeOutRealm.self)
        let kids = try! Realm().objects(kidRealm.self)
        
        let dateStart = GetDateFromString(DateStr: startDate)
        let dateEnd = GetDateFromString(DateStr: endDate)
        var d:Date
        for kid in kids {
            for kidR in kidsR {
                d=kidR.getDate()
                let name = kidR.getName()
                if(kidR.getName() == kid.getName()){
                  if(d>dateStart && d<dateEnd){
                   
                    var found = false
                    var index = 0
                    for sKid in KidCountArray {
                        
                        if(sKid.getName()==kid.getName())
                        {
                            found = true
                            break
                        }
                        index = index + 1
                    }
                        if(found==false){
                            kidR.incCount()
                           KidCountArray.append(kidR)
                        }
                        else{
                            KidCountArray[index].incCount()
                        }
                    }
                   
                  }
                }
            
            
        }
        for kidD in KidCountArray {
            kidsArray.append(kidD.getName())
            values.append(Double(kidD.getCount()))
        }
        setChart()
      //  setChart(months, values: unitsSold)
        // Do any additional setup after loading the view.
       
        
        
    }
    @IBAction func doneBAction(_ sender: UIButton) {
         self.dismiss(animated: true, completion: nil)
    }
    
   
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var barChart: BarChartView!
    func setChart() {
       
        // Sample data
        
        
        var entries: [ChartDataEntry] = Array()
        
        for (i, value) in values.enumerated()
        {
            entries.append(BarChartDataEntry(x: Double(i), y: value, icon: UIImage(named: "icon", in: Bundle(for: self.classForCoder), compatibleWith: nil)))
        }
        
        dataSet = BarChartDataSet(values: entries, label: "Number of timeouts")
        dataSet.colors=[UIColor.red,UIColor.green,UIColor.blue]
        dataSet.drawIconsEnabled = false
        dataSet.iconsOffset = CGPoint(x: 0, y: -10.0)
        
        let data = BarChartData(dataSet: dataSet)
        data.barWidth = 0.85
        data.addDataSet(dataSet)
        //barChart = BarChartView(frame: CGRect(x: 0, y: 0, width: 480, height: 350))
        barChart.backgroundColor = NSUIColor.clear
        barChart.leftAxis.axisMinimum = 0.0
        barChart.rightAxis.axisMinimum = 0.0
        barChart.data = data
        barChart.xAxis.labelPosition = .bottom
        barChart.xAxis.valueFormatter = DefaultAxisValueFormatter(block:{(index,_)in return self.kidsArray[Int(index)]})
        barChart.xAxis.setLabelCount(self.kidsArray.count, force: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


