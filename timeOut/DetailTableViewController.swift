//
//  DetailTableViewController.swift
//  timeOut
//
//  Created by roman rozenblat on 4/20/18.
//  Copyright © 2018 roman rozenblat. All rights reserved.
//

import UIKit
import RealmSwift
class DetailTableViewController: UITableViewController {
    var tempName : String = ""
    @IBOutlet weak var kidsAgeText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if (index == nil) {
           index=0
        }
        
        let st=modelArray[index].components(separatedBy: " ")
        if(st[0] != ""){
          tempName = st[0]
          editModelTextField.text = st[0]
           kidsAgeText.text = st[2]
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait)
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if indexPath.section == 0 && indexPath.row == 0 {
            editModelTextField.becomeFirstResponder()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    @IBOutlet weak var editModelTextField: UITextField!
    var index:Int = 0
    
    var modelArray:[String]!
    var editedModel:String?
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
    @IBAction func ageFieldChanged(_ sender: UITextField) {
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let realm = try! Realm()
        if segue.identifier == "save" {
            if(kidsAgeText.text?.count==0){
                 editedModel = editModelTextField.text! + "  Age- 0"
            }
            else {
                editedModel = editModelTextField.text! + "  Age- " + kidsAgeText.text!
            }
            let kid = realm.objects(kidRealm.self).filter("name = %@", tempName)
            
           
            if kid.count != 0 {
                var index : Int = 0
                for kid in KIdsArraySinglton.getArrayKids(){
                    if kid.getName() == tempName {
                        KIdsArraySinglton.getArrayKids()[index].setAge(formAge: Int(kidsAgeText.text!)!)
                        KIdsArraySinglton.getArrayKids()[index].setName(fromName: editModelTextField.text!)
                    }
                    else {
                        index = index + 1
                    }
                    
                }
                try! realm.write {
                    kid.first?.name = editModelTextField.text!
                    if(kidsAgeText.text?.count==0)
                    {
                      kid.first?.age = 0
                    }
                    else{
                      kid.first?.age = Int(kidsAgeText.text!)!
                    }
            }
           
        }
            else
            {
                let kid3 = kidRealm(fromName:(editModelTextField.text?.trimmingCharacters(in: NSCharacterSet.whitespaces))!, fromAge: Int(kidsAgeText.text!)!,fromStartBtn: false,fromStopBtn: false,fromRestBtn: false)
                try! realm.write {
                    kid3.name = (editModelTextField.text?.trimmingCharacters(in: NSCharacterSet.whitespaces))!
                    kid3.age = Int(kidsAgeText.text!)!
                    realm.add(kid3)
                    let kid = Kid(fromName: kid3.getName(),fromAge:kid3.getAge(), fromTimerStart: false, fromTimer: 0,fromStartBtn: false,fromStopBtn: false,fromRestBtn: false)
                    kid.setTime(frimTime:kid3.getAge()-1)
                    KIdsArraySinglton.appendKid(fromKid: kid)
                   
                }
            }
        
        
    }
    }
 

}
