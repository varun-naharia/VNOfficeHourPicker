//
//  VNOfficeHourTableViewCell.swift
//  OfficeHourPicker
//
//  Created by Varun Naharia on 14/07/17.
//  Copyright © 2017 Varun. All rights reserved.
//

import UIKit

class VNOfficeHourTableViewCell: UITableViewCell {

    @IBOutlet weak var txtStart: CustomTextField!
    @IBOutlet weak var txtEnd: CustomTextField!
    @IBOutlet weak var btnMon: UIButton!
    @IBOutlet weak var btnTue: UIButton!
    @IBOutlet weak var btnWed: UIButton!
    @IBOutlet weak var btnThu: UIButton!
    @IBOutlet weak var btnFri: UIButton!
    @IBOutlet weak var btnSat: UIButton!
    @IBOutlet weak var btnSun: UIButton!
    var parentVC:VNOfficeHourViewController!
    var indexPathRow:Int!
    var startDate:Date?
    var endDate:Date?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func monAction(_ sender: UIButton) {
        print("mon")
        let value = (parentVC.arrayValuesForCell[indexPathRow]["Mon"] as! String) == "true" ? "false" : (parentVC.arrayValuesForCell[indexPathRow]["Mon"] as! String) == "false" ? "true":"nil"
        parentVC.arrayValuesForCell[indexPathRow]["Mon"] = value
        if(value == "true")
        {
            parentVC.trueCount += 1
        }
        else
        {
            parentVC.trueCount -= 1
        }
        var index = 0
        for _ in parentVC.arrayValuesForCell {
            if(index != indexPathRow)
            {
                parentVC.arrayValuesForCell[index]["Mon"] = (parentVC.arrayValuesForCell[indexPathRow]["Mon"] as! String) == "true" ? "nil" : "false"
            }
            index += 1
        }
        parentVC.tableViewHours.reloadData()
    }
    
    @IBAction func tueAction(_ sender: UIButton) {
        print("tue")
        let value = (parentVC.arrayValuesForCell[indexPathRow]["Tue"] as! String) == "true" ? "false" : (parentVC.arrayValuesForCell[indexPathRow]["Tue"] as! String) == "false" ? "true":"nil"
        parentVC.arrayValuesForCell[indexPathRow]["Tue"] = value
        if(value == "true")
        {
            parentVC.trueCount += 1
        }
        else
        {
            parentVC.trueCount -= 1
        }
        var index = 0
        for _ in parentVC.arrayValuesForCell {
            if(index != indexPathRow)
            {
                parentVC.arrayValuesForCell[index]["Tue"] = (parentVC.arrayValuesForCell[indexPathRow]["Tue"] as! String) == "true" ? "nil" : "false"
            }
            index += 1
        }
        parentVC.tableViewHours.reloadData()
    }
    
    @IBAction func wedAction(_ sender: UIButton) {
        print("wed")
        let value = (parentVC.arrayValuesForCell[indexPathRow]["Wed"] as! String) == "true" ? "false" : (parentVC.arrayValuesForCell[indexPathRow]["Wed"] as! String) == "false" ? "true":"nil"
        parentVC.arrayValuesForCell[indexPathRow]["Wed"] = value
        if(value == "true")
        {
            parentVC.trueCount += 1
        }
        else
        {
            parentVC.trueCount -= 1
        }
        var index = 0
        for _ in parentVC.arrayValuesForCell {
            if(index != indexPathRow)
            {
                parentVC.arrayValuesForCell[index]["Wed"] = (parentVC.arrayValuesForCell[indexPathRow]["Wed"] as! String) == "true" ? "nil" : "false"
            }
            index += 1
        }
        parentVC.tableViewHours.reloadData()
    }
    
    @IBAction func thuAction(_ sender: UIButton) {
        print("thu")
        let value = (parentVC.arrayValuesForCell[indexPathRow]["Thu"] as! String) == "true" ? "false" : (parentVC.arrayValuesForCell[indexPathRow]["Thu"] as! String) == "false" ? "true":"nil"
        parentVC.arrayValuesForCell[indexPathRow]["Thu"] = value
        if(value == "true")
        {
            parentVC.trueCount += 1
        }
        else
        {
            parentVC.trueCount -= 1
        }
        var index = 0
        for _ in parentVC.arrayValuesForCell {
            if(index != indexPathRow)
            {
                parentVC.arrayValuesForCell[index]["Thu"] = (parentVC.arrayValuesForCell[indexPathRow]["Thu"] as! String) == "true" ? "nil" : "false"
            }
            index += 1
        }
        parentVC.tableViewHours.reloadData()
    }
    
    @IBAction func friAction(_ sender: UIButton) {
        print("fri")
        let value = (parentVC.arrayValuesForCell[indexPathRow]["Fri"] as! String) == "true" ? "false" : (parentVC.arrayValuesForCell[indexPathRow]["Fri"] as! String) == "false" ? "true":"nil"
        parentVC.arrayValuesForCell[indexPathRow]["Fri"] = value
        if(value == "true")
        {
            parentVC.trueCount += 1
        }
        else
        {
            parentVC.trueCount -= 1
        }
        var index = 0
        for _ in parentVC.arrayValuesForCell {
            if(index != indexPathRow)
            {
                parentVC.arrayValuesForCell[index]["Fri"] = (parentVC.arrayValuesForCell[indexPathRow]["Fri"] as! String) == "true" ? "nil" : "false"
            }
            index += 1
        }
        parentVC.tableViewHours.reloadData()
    }
    
    @IBAction func satAction(_ sender: UIButton) {
        print("sat")
        let value = (parentVC.arrayValuesForCell[indexPathRow]["Sat"] as! String) == "true" ? "false" : (parentVC.arrayValuesForCell[indexPathRow]["Sat"] as! String) == "false" ? "true":"nil"
        parentVC.arrayValuesForCell[indexPathRow]["Sat"] = value
        if(value == "true")
        {
            parentVC.trueCount += 1
        }
        else
        {
            parentVC.trueCount -= 1
        }
        var index = 0
        for _ in parentVC.arrayValuesForCell {
            if(index != indexPathRow)
            {
                parentVC.arrayValuesForCell[index]["Sat"] = (parentVC.arrayValuesForCell[indexPathRow]["Sat"] as! String) == "true" ? "nil" : "false"
            }
            index += 1
        }
        parentVC.tableViewHours.reloadData()
    }
    
    @IBAction func sunAction(_ sender: UIButton) {
        print("sun")
        let value = (parentVC.arrayValuesForCell[indexPathRow]["Sun"] as! String) == "true" ? "false" : (parentVC.arrayValuesForCell[indexPathRow]["Sun"] as! String) == "false" ? "true":"nil"
        parentVC.arrayValuesForCell[indexPathRow]["Sun"] = value
        if(value == "true")
        {
            parentVC.trueCount += 1
        }
        else
        {
            parentVC.trueCount -= 1
        }
        var index = 0
        for _ in parentVC.arrayValuesForCell {
            if(index != indexPathRow)
            {
                parentVC.arrayValuesForCell[index]["Sun"] = (parentVC.arrayValuesForCell[indexPathRow]["Sun"] as! String) == "true" ? "nil" : "false"
            }
            index += 1
        }
        parentVC.tableViewHours.reloadData()
    }
    
    
}
