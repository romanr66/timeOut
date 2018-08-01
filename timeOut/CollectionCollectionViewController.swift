//
//  CollectionCollectionViewController.swift
//  timeOut
//
//  Created by roman rozenblat on 7/24/18.
//  Copyright © 2018 roman rozenblat. All rights reserved.
//

import UIKit
import RealmSwift
private let reuseIdentifier = "Cell"

class CollectionCollectionViewController: UICollectionViewController {
    var models : Array<String> = [String]()
var cellColor = true
    var typeSeq : String = ""
    
    static var rowSelected : Int = 0
    var kids = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let matchedUsers = try! Realm().objects(kidRealm.self)
        var count : Int = 0
        for st in matchedUsers {
            kids.append(st.getName())
            count = count + 1
        }
        kids.append("+")
        count = count + 1
        // #warning Incomplete implementation, return the number of items
        return count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor  = UIColor.lightGray
        // Configure the cell
        if kids[indexPath.row] == "+" {
            var imageTick:UIImage = UIImage(named: "Image-1")!
            var imageView:UIImageView = UIImageView(frame: CGRect(x: cell.bounds.size.width/3, y: cell.bounds.size.height/3.5, width: 40, height: 40))
            imageView.image = imageTick
            cell.contentView.addSubview(imageView)
            
            
        }
        else {
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: 40))
        title.textColor = UIColor.black
        title.text = kids[indexPath.row]
        title.textAlignment = .center
        cell.contentView.addSubview(title)
        
        }
        return cell
        
    }
  
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        CollectionCollectionViewController.rowSelected = indexPath.row
        if kids[indexPath.row] == "+" {
            typeSeq = "+"
            performSegue(withIdentifier: "addKideSeq", sender: 0)
        }
        else {
            performSegue(withIdentifier: "collectionSeque", sender: 0)
        }
        return true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if typeSeq == "+"{
        print(segue.identifier)
        let detailViewController = segue.destination as! DetailTableViewController
        models.append("")
        detailViewController.modelArray=models
        }
        
    }
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    

}
extension CollectionCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
}
