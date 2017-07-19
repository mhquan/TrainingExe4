//
//  ViewController.swift
//  TrainingExe4
//
//  Created by Quan on 7/13/17.
//  Copyright © 2017 Quan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lblCaptureDate: UILabel!
    @IBOutlet weak var lblAvValue: UILabel!
    @IBOutlet weak var lblLoliValue: UILabel!
    @IBOutlet weak var imgPhoto: UIImageView!
    @IBOutlet weak var btnBackDidPush: UIButton!
    
    var selectedCell = TableViewController.StructCellTable(image: "", captureDate: "", avValue: "", loliValue: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        imgPhoto.image = UIImage(named: selectedCell.image)
        lblCaptureDate.text = selectedCell.captureDate
        lblAvValue.text = selectedCell.avValue
        lblLoliValue.text = selectedCell.loliValue
    }
}
