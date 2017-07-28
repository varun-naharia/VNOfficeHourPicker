//
//  VNOfficeHourViewController.swift
//  OfficeHourPicker
//
//  Created by Varun Naharia on 14/07/17.
//  Copyright © 2017 Varun. All rights reserved.
//

import UIKit
protocol VNOfficeHourViewDelegate {
    func save(arrData:[[String:Any]], numberOfRow:Int)
}
class VNOfficeHourViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK:- Delegate
    var delegate:VNOfficeHourViewDelegate?
    @IBOutlet weak var tableViewHours: UITableView!
    var rowCount = 1
    var trueCount = 0
    var arrayValuesForCell:[[String:Any]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let bundle = Bundle(for: type(of: self))
        tableViewHours.register(UINib(nibName: "VNOfficeHourTableViewCell", bundle: bundle), forCellReuseIdentifier: "Cell")
        if(!(arrayValuesForCell.count > 0))
        {
            arrayValuesForCell = [
                ["Mon":"false", "Tue":"false", "Wed":"false", "Thu":"false", "Fri":"false", "Sat":"false", "Sun":"false", "start":"", "end":""],
                ["Mon":"false", "Tue":"false", "Wed":"false", "Thu":"false", "Fri":"false", "Sat":"false", "Sun":"false", "start":"", "end":""],
                ["Mon":"false", "Tue":"false", "Wed":"false", "Thu":"false", "Fri":"false", "Sat":"false", "Sun":"false", "start":"", "end":""],
                ["Mon":"false", "Tue":"false", "Wed":"false", "Thu":"false", "Fri":"false", "Sat":"false", "Sun":"false", "start":"", "end":""],
                ["Mon":"false", "Tue":"false", "Wed":"false", "Thu":"false", "Fri":"false", "Sat":"false", "Sun":"false", "start":"", "end":""],
                ["Mon":"false", "Tue":"false", "Wed":"false", "Thu":"false", "Fri":"false", "Sat":"false", "Sun":"false", "start":"", "end":""],
                ["Mon":"false", "Tue":"false", "Wed":"false", "Thu":"false", "Fri":"false", "Sat":"false", "Sun":"false", "start":"", "end":""]
            ]
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bundle = Bundle(for: type(of: self))
        let cell:VNOfficeHourTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! VNOfficeHourTableViewCell
        cell.btnMon.isEnabled = (arrayValuesForCell[indexPath.row]["Mon"] as! String != "nil")
        cell.btnTue.isEnabled = (arrayValuesForCell[indexPath.row]["Tue"] as! String != "nil")
        cell.btnWed.isEnabled = (arrayValuesForCell[indexPath.row]["Wed"] as! String != "nil")
        cell.btnThu.isEnabled = (arrayValuesForCell[indexPath.row]["Thu"] as! String != "nil")
        cell.btnFri.isEnabled = (arrayValuesForCell[indexPath.row]["Fri"] as! String != "nil")
        cell.btnSat.isEnabled = (arrayValuesForCell[indexPath.row]["Sat"] as! String != "nil")
        cell.btnSun.isEnabled = (arrayValuesForCell[indexPath.row]["Sun"] as! String != "nil")
        
        cell.btnMon.setImage((arrayValuesForCell[indexPath.row]["Mon"] as! String) == "true" ? UIImage(named: "checkboxselected", in: bundle, compatibleWith: nil) : UIImage(named: "checkbox", in: bundle, compatibleWith: nil), for: .normal)
        cell.btnTue.setImage((arrayValuesForCell[indexPath.row]["Tue"] as! String) == "true" ? UIImage(named: "checkboxselected", in: bundle, compatibleWith: nil) : UIImage(named: "checkbox", in: bundle, compatibleWith: nil), for: .normal)
        cell.btnWed.setImage((arrayValuesForCell[indexPath.row]["Wed"] as! String) == "true" ? UIImage(named: "checkboxselected", in: bundle, compatibleWith: nil) : UIImage(named: "checkbox", in: bundle, compatibleWith: nil), for: .normal)
        cell.btnThu.setImage((arrayValuesForCell[indexPath.row]["Thu"] as! String) == "true" ? UIImage(named: "checkboxselected", in: bundle, compatibleWith: nil) : UIImage(named: "checkbox", in: bundle, compatibleWith: nil), for: .normal)
        cell.btnFri.setImage((arrayValuesForCell[indexPath.row]["Fri"] as! String) == "true" ? UIImage(named: "checkboxselected", in: bundle, compatibleWith: nil) : UIImage(named: "checkbox", in: bundle, compatibleWith: nil), for: .normal)
        cell.btnSat.setImage((arrayValuesForCell[indexPath.row]["Sat"] as! String) == "true" ? UIImage(named: "checkboxselected", in: bundle, compatibleWith: nil) : UIImage(named: "checkbox", in: bundle, compatibleWith: nil), for: .normal)
        cell.btnSun.setImage((arrayValuesForCell[indexPath.row]["Sun"] as! String) == "true" ? UIImage(named: "checkboxselected", in: bundle, compatibleWith: nil) : UIImage(named: "checkbox", in: bundle, compatibleWith: nil), for: .normal)
        
        cell.txtStart.text = arrayValuesForCell[indexPath.row]["start"] as? String
        cell.txtEnd.text = arrayValuesForCell[indexPath.row]["end"] as? String
        cell.parentVC = self
        cell.indexPathRow = indexPath.row
        
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .time
        let toolBarStart = UIToolbar().addDoneButton() {
            if(cell.txtStart.text == "")
            {
                cell.startDate = datePickerView.date
                let dateFormatter = DateFormatter()
//                dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
                dateFormatter.dateFormat = "hh:mm a"
                cell.txtStart.text = dateFormatter.string(from: datePickerView.date)
                self.arrayValuesForCell[indexPath.row]["start"] = cell.txtStart.text
            }
            self.view.endEditing(true)
        }
        
        let toolBarEnd = UIToolbar().addDoneButton() {
            if(cell.txtEnd.text == "")
            {
                cell.endDate = datePickerView.date
                let dateFormatter = DateFormatter()
//                dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
                dateFormatter.dateFormat = "hh:mm a"
                cell.txtEnd.text = dateFormatter.string(from: datePickerView.date)
                self.arrayValuesForCell[indexPath.row]["end"] = cell.txtEnd.text
            }
            self.view.endEditing(true)
        }
        
        cell.txtStart.inputAccessoryView = toolBarStart
        cell.txtEnd.inputAccessoryView = toolBarEnd
        cell.txtStart.add(for: .editingDidBegin) {
            cell.txtStart.inputView = datePickerView
            cell.startDate = nil
            datePickerView.minimumDate = nil
            if(cell.endDate != nil)
            {
                cell.txtEnd.text = ""
                cell.endDate = nil
            }
            datePickerView.add(for: .valueChanged, {
                if(cell.txtStart.isFirstResponder)
                {
                    cell.startDate = datePickerView.date
                    let dateFormatter = DateFormatter()
//                    dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
                    dateFormatter.dateFormat = "hh:mm a"
                    cell.txtStart.text = dateFormatter.string(from: datePickerView.date)
                    self.arrayValuesForCell[indexPath.row]["start"] = cell.txtStart.text
                }
            })
        }
        
        cell.txtEnd.add(for: .editingDidBegin) {
            cell.txtEnd.inputView = datePickerView
            if(cell.startDate != nil)
            {
                datePickerView.minimumDate = cell.startDate
                datePickerView.maximumDate = nil
            }
            datePickerView.add(for: .valueChanged, {
                if(cell.txtEnd.isFirstResponder)
                {
                    
                    cell.endDate = datePickerView.date
                    let dateFormatter = DateFormatter()
//                    dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
                    dateFormatter.dateFormat = "hh:mm a"
                    cell.txtEnd.text = dateFormatter.string(from: datePickerView.date)
                    self.arrayValuesForCell[indexPath.row]["end"] = cell.txtEnd.text
                }
            })
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount
    }

    @IBAction func saveAction(_ sender: UIButton) {
        self.delegate?.save(arrData: arrayValuesForCell, numberOfRow: rowCount)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func addMoreAction(_ sender: UIButton) {
        if(rowCount < 7 && trueCount < 7)
        {
            rowCount += 1
            tableViewHours.reloadData()
        }
    }
}
