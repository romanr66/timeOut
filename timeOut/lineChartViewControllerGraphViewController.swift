//
//  lineChartViewControllerGraphViewController.swift
//  timeOut
//
//  Created by roman rozenblat on 5/30/18.
//  Copyright © 2018 roman rozenblat. All rights reserved.
//

import UIKit
import RealmSwift
import Charts
class lineChartViewControllerGraphViewController: UIViewController {
   
    public var kidFirstName : String = ""
    public var startDate : String = ""
    public var endDate : String = ""
    @IBOutlet weak var lineChartView: LineChartView!
    var kidTempHash = [Int : Double]()
    var kidsHash = [String : [Int : Double]]()
    func add(targetDay:Date) -> Date {
        
        
        let returnDay = Calendar.current.date(byAdding: .day, value: 1, to: targetDay as Date)!
        
        return returnDay
    }
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait)
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
        let dateStart = GetDateFromString(DateStr: startDate)
        let dateEnd = GetDateFromString(DateStr: endDate)
        
       
        var  date : Date = dateStart
        let realm = try! Realm()
        let kidsRes = try! Realm().objects(kidRealm.self)
        var index=0;
        var name : String
        for kid1 in kidsRes {
            var count : Int = 0
           while (date <= dateEnd){
            
            let res=realm.objects(KidsTimeOutRealm.self)
            
            for kid2 in res {
                if kidFirstName == kid2.getName() {
               let date1 =  kid2.getDate().description
               let date2 = date.description
               let dateIndex1 = date1.index(date1.startIndex, offsetBy: 10)
               let dateIndex2 = date2.index(date2.startIndex, offsetBy: 10)
               let date1Sub1 = String(date1[...dateIndex1])
                let date1Sub2 = String(date2[...dateIndex2])
                if(date1Sub1 == date1Sub2){
                    count = count + 1
                
                
               
                }
              }
                
            }
            
            
              kidTempHash[index] = Double(count)
              kidsHash[kidFirstName] = kidTempHash
              index = index + 1
              count = 0
              date = add(targetDay: date)
            }
            index = 0
        }
        setChartData()
        // Do any additional setup after loading the view.
    }

    @IBAction func done(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setChartData() {
        // 1 - creating an array of data entries
        var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
        var i : Int = 0;
       
        
        var entries: [ChartDataEntry] = Array()
        var entries1: [ChartDataEntry] = Array()
        var lineChartDataSet : LineChartDataSet
        for  (name,amount) in kidsHash {
            if (name == kidFirstName) {
                for index in 0...amount.count-1 {
                    entries.append(ChartDataEntry(x: Double(index), y: amount[index]!, icon: UIImage(named: "icon", in: Bundle(for: self.classForCoder), compatibleWith: nil)))
                 
                }
            }
        }
        
        let dataSet = LineChartDataSet(values: entries, label: kidFirstName)
        dataSet.colors=[UIColor.blue]
        dataSet.drawIconsEnabled = false
        dataSet.iconsOffset = CGPoint(x: 0, y: -10.0)
        for index in 0...5 {
            entries1.append(ChartDataEntry(x: Double(index), y: Double(index), icon: UIImage(named: "icon", in: Bundle(for: self.classForCoder), compatibleWith: nil)))
            
        }
        lineChartView.xAxis.granularityEnabled = true
        lineChartView.xAxis.granularity = 1.0 //default granularity is 1.0, but it is better to be explicit
        lineChartView.xAxis.decimals = 0
        lineChartView.chartDescription?.text = ""
        let data = LineChartData(dataSet: dataSet)
      
       // data.addDataSet(dataSet)
        //barChart = BarChartView(frame: CGRect(x: 0, y: 0, width: 480, height: 350))
        lineChartView.backgroundColor = NSUIColor.clear
        lineChartView.leftAxis.axisMinimum = 0
        lineChartView.rightAxis.axisMinimum = 0
        
        lineChartView.data = data
        lineChartView.xAxis.labelPosition = .top
        
        //lineChartView.xAxis.valueFormatter = DefaultAxisValueFormatter(block:{(index,_)in return "Danny"})
        //lineChartView.xAxis.setLabelCount(1, force: true)
       // lineChartView.xAxis.valueFormatter = DefaultAxisValueFormatter(block:{(index,_)in return self.kidsArray[Int(index)]})
        //lineChartView.xAxis.setLabelCount(self.kidsArray.count, force: true)
       
       
        
        //4 - pass our months in for our x-axis label value along with our dataSets
       // let data: LineChartData = LineChartData(xVals: months, dataSets: lineChartDataSet)
        data.setValueTextColor(UIColor.white)
        
        //5 - finally set our data
        self.lineChartView.data = data
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
