//
//  TableViewController.swift
//  TrainingExe4
//
//  Created by Quan on 7/11/17.
//  Copyright © 2017 Quan. All rights reserved.
//

import UIKit

//var arrImage = ["1","2","3","4","5","6","7","8","9"]
//var arrCaptureDate = ["2011.01.04 09:46","2017.04.04 09:46","2012.04.04 09:46","2013.04.03 09:46","2017.04.01 09:46","2013.04.04 09:46","2017.04.01 09:46","2017.04.00 09:46","2017.04.08 09:46"]
//var arravValue = ["11","22","33","44","55","66","77","88","99"]
//var arrloviValue = ["101","102","103","104","105","106","107","108","109"]
var arrImage : [String] = []
var arrCaptureDate : [String] = []
var arravValue : [String] = []
var arrloviValue : [String] = []

class TableViewController: UITableViewController {
    
    var editMode = false
    var editStyle : UITableViewCellEditingStyle = .none
    var dataCells : [StructCellTable] = []
    var selectedCell = StructCellTable(image: "", captureDate: "", avValue: "", loliValue: "")
    
    struct StructCellTable {
        var image: String
        var captureDate: String
        var avValue: String
        var loliValue: String
//        init(image: String, date: String, avValue: Int, loliValue: Int) {
//            self.image = image
//            self.captureDate = date
//            self.avValue = avValue
//            self.loliValue = loliValue
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CoreDataViewController().retrieveDataFromCore()
        dataCells = getDataCell()
        self.navigationItem.rightBarButtonItem?.title = "Move"
        
    }
    
    func getDataCell() -> [StructCellTable] {
        var dataCells = [StructCellTable]()
        for i in 0..<arrImage.count {
            let cell = StructCellTable(image: arrImage[i], captureDate: arrCaptureDate[i], avValue: arravValue[i], loliValue: arrloviValue[i])
           dataCells.append(cell)
        }
        return dataCells
    }
    
    @IBAction func btnbarMove(_ sender: UIBarButtonItem) {
        navigationItem.leftBarButtonItem?.tintColor = UIColor.magenta
        navigationItem.leftBarButtonItem?.title = "Edit"
        editMode = false
        editStyle = .none
        if navigationItem.rightBarButtonItem?.title == "Move" {
            tableView.isEditing = true
            navigationItem.rightBarButtonItem?.tintColor = UIColor.green
            navigationItem.rightBarButtonItem?.title = "Done"
        } else if navigationItem.rightBarButtonItem?.title == "Done"{
            navigationItem.rightBarButtonItem?.tintColor = UIColor.magenta
            navigationItem.rightBarButtonItem?.title = "Move"
            tableView.isEditing = false
        }
    }
    
    @IBAction func btnbarEdit(_ sender: Any) {
        self.navigationItem.rightBarButtonItem?.title = "Move"
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.magenta
        if self.navigationItem.leftBarButtonItem?.title == "Edit" {
            self.navigationItem.leftBarButtonItem?.tintColor = UIColor.green
            navigationItem.leftBarButtonItem?.title = "Done"
            editMode = true
            editStyle = .delete
        } else {
            self.navigationItem.leftBarButtonItem?.tintColor = UIColor.magenta
            navigationItem.leftBarButtonItem?.title = "Edit"
            editMode = false
            editStyle = .none
        }
        tableView.reloadData()
    }
    
    @IBAction func btnbarAdd(_ sender: Any) {
        performSegue(withIdentifier: "add", sender: nil)
        
    }
    
      override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataCells.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let cellTag1 = cell.viewWithTag(1) as! UIImageView
        cellTag1.image = UIImage(named: dataCells[indexPath.row].image)

        let cellTag2 = cell.viewWithTag(2) as! UILabel
        cellTag2.text = dataCells[indexPath.row].captureDate
        
        let cellTag3 = cell.viewWithTag(3) as! UILabel
        cellTag3.text = dataCells[indexPath.row].avValue
        
        let cellTag4 = cell.viewWithTag(4) as! UILabel
        cellTag4.text = dataCells[indexPath.row].loliValue

        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataViewController().deleteDataFromCore(row: indexPath.row)
            dataCells.remove(at: indexPath.row)
            tableView.reloadData()
            print(dataCells.count)
        }
        else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedObject = dataCells[fromIndexPath.row]
        dataCells.remove(at: fromIndexPath.row)
        dataCells.insert(movedObject, at: to.row)
       
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return editStyle
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
    return editMode
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = dataCells[indexPath.row]
        if (indexPath.row%2 == 0) {
            performSegue(withIdentifier: "push", sender: nil)
        }
        else if (indexPath.row%2 != 0) {
            performSegue(withIdentifier: "present", sender: nil)
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cellDeatailViewController = segue.destination as? ViewController
        cellDeatailViewController?.selectedCell = selectedCell
    }

}
