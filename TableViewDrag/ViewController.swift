//
//  ViewController.swift
//  TableViewDrag
//
//  Created by appinventiv on 25/08/17.
//  Copyright © 2017 appinventiv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
     var dataArr = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
    
    @IBOutlet weak var edit: UIButton!
    @IBAction func editBtn(_ sender: UIButton) {
        tableViewOutlet.isEditing = !tableViewOutlet.isEditing
        switch tableViewOutlet.isEditing {
        case true:
          edit.setTitle("Done", for: .normal)
        case false:
            edit.setTitle("edit", for: .normal)
        }
        
    }
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate = self
        
        }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(dataArr.count)
        return dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath) as? DataCell else {fatalError()}
        cell.dataLabel.text = dataArr[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
        print(dataArr[indexPath.row])
            print(dataArr)
            dataArr.remove(at: indexPath.row)
          tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            
           // print(dataArr)
           // self.tableViewOutlet.reloadData()
        }
    }
    //===== overide  to suport rearrange =======
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = dataArr[sourceIndexPath.row]
        dataArr.remove(at: sourceIndexPath.row)
        dataArr.insert(item, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
class DataCell: UITableViewCell {
    
    @IBOutlet weak var dataLabel: UILabel!
}

