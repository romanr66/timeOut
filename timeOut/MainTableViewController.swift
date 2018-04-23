//
//  MainTableViewController.swift
//  timeOut
//
//  Created by roman rozenblat on 4/17/18.
//  Copyright © 2018 roman rozenblat. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    var IndexPath1 : IndexPath = IndexPath(row: 0, section: 0)
    static var models = [String]()
    @IBAction func saveToMainViewController (segue:UIStoryboardSegue) {
        let detailViewController = segue.source as! DetailTableViewController
        
        let index = detailViewController.index
        
        let modelString = detailViewController.editedModel
        
        type(of: self).models[index] = modelString!
        
        tableView.reloadData()
    }
    @IBOutlet var tableView1: UITableView!
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.identifier)
         let detailViewController = segue.destination as! DetailTableViewController
        if segue.identifier == "edit" {
            
            var path = IndexPath1
            
           
            
            detailViewController.index = path.row
            detailViewController.modelArray =  type(of: self).models
     }
        else if segue.identifier == "add"{
            
             type(of: self).models.append("")
            detailViewController.index =   type(of: self).models.count-1
            detailViewController.modelArray =  type(of: self).models
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        IndexPath1 = indexPath
        performSegue(withIdentifier: "edit", sender: indexPath.row)
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tabelCell")
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return type(of: self).models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tabelCell", for: indexPath)
        
        cell.textLabel?.text = type(of: self).models[indexPath.row]
        
        return cell
    }
}
