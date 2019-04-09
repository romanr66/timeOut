//
//  MainTableViewController.swift
//  timeOut
//
//  Created by roman rozenblat on 4/17/18.
//  Copyright © 2018 roman rozenblat. All rights reserved.
//

import UIKit
import RealmSwift
class MainTableViewController: UITableViewController {
    var IndexPath1 : IndexPath = IndexPath(row: 0, section: 0)
    var models : Array<String> = [String]()
    @IBAction func saveToMainViewController (segue:UIStoryboardSegue) {
        let detailViewController = segue.source as! DetailTableViewController
        
        let index = detailViewController.index
        
        let modelString = detailViewController.editedModel
        if modelString == nil {
        }
        else {
          models[index] = modelString!
        
         tableView.reloadData()
        }
    }
    @IBOutlet var tableView1: UITableView!
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func viewWillAppear(_ animated: Bool) {
        KIdsArraySinglton.setsSwitchToCollection(fromSwitchToCollection: true)
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait)
        models.removeAll()
        for kid in KIdsArraySinglton.getArrayKids() {
            models.append(kid.getName() + " - " + (String(kid.getAge())))
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.identifier)
         let detailViewController = segue.destination as! DetailTableViewController
        if segue.identifier == "edit" {
            
            var path = IndexPath1
            
           
            
            detailViewController.index = path.row
            detailViewController.modelArray =  models
     }
        else if segue.identifier == "add"{
            
             models.append("")
            detailViewController.index =   models.count-1
            detailViewController.modelArray = models
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        IndexPath1 = indexPath
        performSegue(withIdentifier: "edit", sender: indexPath.row)
        
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
          KIdsArraySinglton.setsSwitchToCollection(fromSwitchToCollection: true)
            let st = models[indexPath.row].components(separatedBy: " ")
            let realm = try! Realm()
            let predicate = NSPredicate(format: "name == %@", st[0])
            let res=realm.objects(kidRealm.self).filter(predicate)
             try! realm.write{
                  realm.delete(res)
                }
            
            let res1=realm.objects(KidsTimeOutRealm.self).filter(predicate)
            try! realm.write{
                realm.delete(res1)
            }
            models.remove(at: indexPath.row)
            KIdsArraySinglton.remove(fromIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }
    @objc func showEditing(sender:UIBarButtonItem)
    {
        if(self.tableView.isEditing == true)
        {
            self.tableView.isEditing = false
            self.navigationItem.leftBarButtonItem?.title = "Edit"
        }
        else
        {
            self.tableView.isEditing = true
            self.navigationItem.leftBarButtonItem?.title = "Done"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tabelCell")
        
        var leftButton = UIBarButtonItem(title:"Edit", style:UIBarButtonItem.Style.plain,target:self,action:#selector(showEditing))
        self.navigationItem.leftBarButtonItem = leftButton
    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print  (models.count)
        return models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tabelCell", for: indexPath)
        
        cell.textLabel?.text = models[indexPath.row]
        
        return cell
    }
}
