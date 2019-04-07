//
//  ViewControllerAdd.swift
//  timeOut
//
//  Created by roman rozenblat on 8/2/18.
//  Copyright © 2018 roman rozenblat. All rights reserved.
//

import UIKit
import RealmSwift
class ViewControllerAdd: UIViewController {

@IBOutlet weak var ageText: UITextField!
@IBOutlet weak var nameText: UITextField!
    @IBAction func editName2(_ sender: UITextField) {
        sender.text=sender.text!.replacingOccurrences(of: " ", with: "")
    }
    @IBAction func editAge(_ sender: UITextField) {
        guard let string = sender.text else { return }
        let c = string.suffix(1)
        if(string.count==0){
            sender.text = ""
        }
        else{
            if ( !("0"..."9" ~= c)) {
                let index = string.index(string.startIndex, offsetBy: string.count-1)
                let sub = string[string.startIndex..<index]
                sender.text =  String(sub)
            }
        }
    }
    @IBAction func editAge2(_ sender: UITextField) {
        guard let string = sender.text else { return }
        let c = string.suffix(1)
        if(string.count==0){
            sender.text = ""
        }
        else{
            if ( !("0"..."9" ~= c)) {
                let index = string.index(string.startIndex, offsetBy: string.count-1)
                let sub = string[string.startIndex..<index]
                sender.text =  String(sub)
            }
        }
    }
    @IBAction func editName(_ sender: UITextField) {
        if (sender.text == " ") {
            sender.text = "";
        }
    }
    @IBAction func saveAction(_ sender: Any) {
        if nameText.text?.trimmingCharacters(in: NSCharacterSet.whitespaces)=="" || ageText.text?.trimmingCharacters(in: NSCharacterSet.whitespaces)==""{
        }
            else {
        let realm = try! Realm()
        let kid3 = kidRealm(fromName:(nameText.text?.trimmingCharacters(in: NSCharacterSet.whitespaces))!, fromAge: Int(ageText.text!)!,fromStartBtn: false,fromStopBtn: false,fromRestBtn: false)
        try! realm.write {
            kid3.name = (nameText.text?.trimmingCharacters(in: NSCharacterSet.whitespaces))!
            kid3.age = Int(ageText.text!)!
            realm.add(kid3)
            let kid = Kid(fromName: kid3.getName(),fromAge:kid3.getAge(), fromTimerStart: false, fromTimer: 0,fromStartBtn: false,fromStopBtn: false,fromRestBtn: false)
            kid.setTime(frimTime:kid3.getAge()-1)
            KIdsArraySinglton.appendKid(fromKid: kid)
        }
        self.dismiss(animated: true, completion: nil)
        }
    }
    @objc func goBack() {
        self.dismiss(animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let leftButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(self.goBack))
        self.navigationItem.leftBarButtonItem = leftButton
        let rightButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(self.saveAction))
        self.navigationItem.rightBarButtonItem = rightButton
         
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
