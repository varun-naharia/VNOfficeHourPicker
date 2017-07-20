//
//  VNOfficeHourView.swift
//  OfficeHourPicker
//
//  Created by Varun Naharia on 14/07/17.
//  Copyright © 2017 Varun. All rights reserved.
//

import UIKit

@IBDesignable
class VNOfficeHourView: UIView, UIGestureRecognizerDelegate, VNOfficeHourViewDelegate {

    
    @IBOutlet weak var lblMondayValue: UILabel!
    @IBOutlet weak var lblTuesdayValue: UILabel!
    @IBOutlet weak var lblWednesdayValue: UILabel!
    @IBOutlet weak var lblThruesdayValue: UILabel!
    @IBOutlet weak var lblFridayValue: UILabel!
    @IBOutlet weak var lblSaturdayValue: UILabel!
    @IBOutlet weak var lblSundayValue: UILabel!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    var arrayValuesForCell:[[String:Any]] = []
    var view: UIView!
    var numberOfRows = 0
    
    @IBInspectable
    public var cornerRadius :CGFloat {
        
        set { layer.cornerRadius = newValue }
        
        get {
            return layer.cornerRadius
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "VNOfficeHourView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    //var underline = UILabel()
    func setUpView() {
        
        //underline.backgroundColor = UIColor.lightGray
        //self.addSubview(underline)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        tap.delegate = self
        self.addGestureRecognizer(tap)
    }
    
    override func layoutSubviews() {
        //underline.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
    }
    
    func handleTap(sender: UITapGestureRecognizer? = nil) {
        // handling code
        print("Tap")
        let storyboard = UIStoryboard.init(name: "VNOfficeHour", bundle: nil)
        let vc:VNOfficeHourViewController = storyboard.instantiateViewController(withIdentifier: "VNOfficeHourViewController") as! VNOfficeHourViewController
        vc.delegate = self
        if(self.arrayValuesForCell.count > 0)
        {
            vc.arrayValuesForCell = self.arrayValuesForCell
        }
        if(numberOfRows != 0)
        {
            vc.rowCount = numberOfRows
        }
        self.getParentViewController()?.present(vc, animated: true, completion: nil)
    }
    
    
    func save(arrData: [[String : Any]], numberOfRow: Int) {
        self.arrayValuesForCell = arrData
        if(arrayValuesForCell.count > 0)
        {
            viewHeight.constant = 211
        }
        else
        {
            viewHeight.constant = 0
        }
        
        self.numberOfRows = numberOfRow
        
        lblMondayValue.text = getDayTime(data: arrData, For: "Mon")
        lblTuesdayValue.text = getDayTime(data: arrData, For: "Tue")
        lblWednesdayValue.text = getDayTime(data: arrData, For: "Wed")
        lblThruesdayValue.text = getDayTime(data: arrData, For: "Thu")
        lblFridayValue.text = getDayTime(data: arrData, For: "Fri")
        lblSaturdayValue.text = getDayTime(data: arrData, For: "Sat")
        lblSundayValue.text = getDayTime(data: arrData, For: "Sun")
        
        lblMondayValue.textColor = lblMondayValue.text == "Closed" ? UIColor.red :UIColor.blue
        lblTuesdayValue.textColor = lblTuesdayValue.text == "Closed" ? UIColor.red :UIColor.blue
        lblWednesdayValue.textColor = lblWednesdayValue.text == "Closed" ? UIColor.red :UIColor.blue
        lblThruesdayValue.textColor = lblThruesdayValue.text == "Closed" ? UIColor.red :UIColor.blue
        lblFridayValue.textColor = lblFridayValue.text == "Closed" ? UIColor.red :UIColor.blue
        lblSaturdayValue.textColor = lblSaturdayValue.text == "Closed" ? UIColor.red :UIColor.blue
        lblSundayValue.textColor = lblSundayValue.text == "Closed" ? UIColor.red :UIColor.blue
        
        
    }
    
    func getDayTime(data:[[String:Any]], For:String) -> String {
        for item in data {
            if(item[For] != nil)
            {
                if((item[For] as! String) == "true" && (item["start"] as! String) != "" && (item["end"] as! String) != "" )
                {
                    return "\((item["start"] as! String)) To \((item["end"] as! String))"
                }
            }
        }
        
        return "Closed"
    }
    
}
