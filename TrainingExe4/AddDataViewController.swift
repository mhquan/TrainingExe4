//
//  addDataViewController.swift
//  TrainingExe4
//
//  Created by Quan on 7/14/17.
//  Copyright © 2017 Quan. All rights reserved.
//

import UIKit
import CoreData

class AddDataViewController: UIViewController {
    @IBOutlet weak var txtCaptureDate: UITextField!
    @IBOutlet weak var txtAvValue: UITextField!
    @IBOutlet weak var txtLoviValue: UITextField!
    var selectedCell = TableViewController.StructCellTable(image: "", captureDate: "", avValue: "", loliValue: "")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func btnAddDidPush(_ sender: Any) {
        selectedCell.avValue = txtAvValue.text!
        selectedCell.captureDate = txtCaptureDate.text!
        selectedCell.loliValue = txtLoviValue.text!
        addDataToCore(avValue: txtAvValue.text!, captureDate: txtCaptureDate.text!, loliValue: txtLoviValue.text!)
        print(selectedCell)
    }
    
    func addDataToCore(avValue: String, captureDate: String, loliValue: String) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity =  NSEntityDescription.entity(forEntityName: "AVResult", in: context)
        let value = NSManagedObject(entity: entity!, insertInto: context)
        value.setValue(avValue, forKey: "avValue")
        value.setValue(captureDate, forKey: "captureDate")
        value.setValue(loliValue, forKey: "loliValue")
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {

        }
    }
    
    func retrieveDataFromCore () {
        //create a fetch request, telling it about the entity
        let fetchRequest: NSFetchRequest<AVResult> = AVResult.fetchRequest()
        
        do {
            //go get the results
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let searchResults = try context.fetch(fetchRequest)
            
            //I like to check the size of the returned results!
            print ("num of results = \(searchResults.count)")
            
            //You need to convert to NSManagedObject to use 'for' loops
            for data in searchResults as [NSManagedObject] {
                //get the Key Value pairs (although there may be a better way to do that...
                print("\(data.value(forKey: "captureDate") ?? 00)")
            }
        } catch {
            print("Error with request: \(error)")
        }
    }
    
}
