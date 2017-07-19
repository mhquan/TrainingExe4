//
//  addDataViewController.swift
//  TrainingExe4
//
//  Created by Quan on 7/14/17.
//  Copyright © 2017 Quan. All rights reserved.
//

import UIKit
import CoreData

class CoreDataViewController: UIViewController {
    @IBOutlet weak var txtCaptureDate: UITextField!
    @IBOutlet weak var txtAvValue: UITextField!
    @IBOutlet weak var txtLoviValue: UITextField!
    @IBOutlet weak var imgImage: UIImageView!
    let imgValue = String(arc4random_uniform(9))
    
    var selectedCell = TableViewController.StructCellTable(image: "", captureDate: "", avValue: "", loliValue: "")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgImage.image = UIImage(named: String(imgValue))
    }
    
    @IBAction func btnAddDidPush(_ sender: Any) {
        if (txtAvValue.text?.isEmpty)! || (txtCaptureDate.text?.isEmpty)! || (txtLoviValue.text?.isEmpty)! {
            let alert = UIAlertController(title: "Lỗi", message: "Nhập thiếu", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            selectedCell.avValue = txtAvValue.text!
            selectedCell.captureDate = txtCaptureDate.text!
            selectedCell.loliValue = txtLoviValue.text!
            selectedCell.image = imgValue
            addDataToCore(image: imgValue, avValue: txtAvValue.text!, captureDate: txtCaptureDate.text!, loliValue: txtLoviValue.text!)
            let alert = UIAlertController(title: "Thành công", message: "Thêm dữ liệu thành công", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            print(selectedCell)
        }
    }
    @IBAction func btnShowData(_ sender: Any) {
        retrieveDataFromCore()
    }
    
    func addDataToCore(image:String, avValue: String, captureDate: String, loliValue: String) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity =  NSEntityDescription.entity(forEntityName: "AVResult", in: context)
        let value = NSManagedObject(entity: entity!, insertInto: context)
        value.setValue(avValue, forKey: "avValue")
        value.setValue(captureDate, forKey: "captureDate")
        value.setValue(loliValue, forKey: "loliValue")
        value.setValue(imgValue, forKey: "image")
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
            let searchResults = try context.fetch(fetchRequest) as [NSManagedObject]

            print ("num of results = \(searchResults.count)")
            arrCaptureDate.removeAll()
            arravValue.removeAll()
            arrloviValue.removeAll()
            arrImage.removeAll()
            arrImage.removeAll()

            for data in searchResults {
                arrCaptureDate.append((data.value(forKey: "captureDate") as! String))
                arravValue.append((data.value(forKey: "avValue") as! String))
                arrloviValue.append((data.value(forKey: "loliValue") as! String))
                arrImage.append((data.value(forKey: "image") as! String))
            }
        } catch {
            print("Error with request: \(error)")
        }
    }
    func insertDatatoCore(rowfrom: Int, to: Int) {
        let request = NSFetchRequest<AVResult>(entityName: "AVResult")
        do {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let searchResults = try context.fetch(request)
            context.delete(searchResults[rowfrom])
            context.insert(searchResults[to])

        } catch {
            print("Error with request: \(error)")
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }

    func deleteDataFromCore(row: Int) {
        let request = NSFetchRequest<AVResult>(entityName: "AVResult")
        do {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let searchResults = try context.fetch(request)
            context.delete(searchResults[row])

        } catch {
            print("Error with request: \(error)")
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
}
