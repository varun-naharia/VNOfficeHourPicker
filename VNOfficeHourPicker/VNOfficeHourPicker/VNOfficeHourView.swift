//
//  VNOfficeHourView.swift
//  OfficeHourPicker
//
//  Created by Varun Naharia on 14/07/17.
//  Copyright © 2017 Varun. All rights reserved.
//

import UIKit

@IBDesignable
public class VNOfficeHourView: UIView, UIGestureRecognizerDelegate, VNOfficeHourViewDelegate {

    
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
    
    fileprivate var _fontSize:CGFloat = 18
    @IBInspectable
    var font:CGFloat
    {
        set
        {
            _fontSize = newValue
            lblPlaceholder.font = UIFont(name: _fontName, size: _fontSize)
        }
        get
        {
            return _fontSize
        }
    }
    
    fileprivate var _fontName:String = "Helvetica"
    @IBInspectable
    var fontName:String
    {
        set
        {
            _fontName = newValue
            lblPlaceholder.font = UIFont(name: _fontName, size: _fontSize)
        }
        get
        {
            return _fontName
        }
    }
    
    fileprivate var _placeholder:String?
    @IBInspectable
    var Placeholder:String
    {
        set
        {
            _placeholder = newValue
            if(_placeholder != "")
            {
                addPlaceholder()
            }
        }
        get
        {
            return _placeholder!
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
        xibSetup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.setUpView()
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        view.backgroundColor = self.backgroundColor
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
    var lblPlaceholder:UILabel = UILabel()
    func addPlaceholder(){
        lblPlaceholder.text = _placeholder
        lblPlaceholder.textColor = UIColor.lightGray
        self.view.addSubview(lblPlaceholder)
    }
    
    //var underline = UILabel()
    func setUpView() {
        
        //underline.backgroundColor = UIColor.lightGray
        //self.addSubview(underline)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        tap.delegate = self
        self.addGestureRecognizer(tap)
    }
    
    override public func layoutSubviews() {
        lblPlaceholder.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 30)
    }
    
    func handleTap(sender: UITapGestureRecognizer? = nil) {
        // handling code
        print("Tap")
        let bundle = Bundle(for: type(of: self))
        let storyboard = UIStoryboard.init(name: "VNOfficeHour", bundle: bundle)
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
            lblPlaceholder.isHidden = true
        }
        else
        {
            lblPlaceholder.isHidden = false
            viewHeight.constant = 0
        }
        
        self.numberOfRows = numberOfRow
        
        lblMondayValue.text = getDayTime(forDay: "Mon")
        lblTuesdayValue.text = getDayTime(forDay: "Tue")
        lblWednesdayValue.text = getDayTime(forDay: "Wed")
        lblThruesdayValue.text = getDayTime(forDay: "Thu")
        lblFridayValue.text = getDayTime(forDay: "Fri")
        lblSaturdayValue.text = getDayTime(forDay: "Sat")
        lblSundayValue.text = getDayTime(forDay: "Sun")
        
        lblMondayValue.textColor = lblMondayValue.text == "Closed" ? UIColor.red :UIColor.blue
        lblTuesdayValue.textColor = lblTuesdayValue.text == "Closed" ? UIColor.red :UIColor.blue
        lblWednesdayValue.textColor = lblWednesdayValue.text == "Closed" ? UIColor.red :UIColor.blue
        lblThruesdayValue.textColor = lblThruesdayValue.text == "Closed" ? UIColor.red :UIColor.blue
        lblFridayValue.textColor = lblFridayValue.text == "Closed" ? UIColor.red :UIColor.blue
        lblSaturdayValue.textColor = lblSaturdayValue.text == "Closed" ? UIColor.red :UIColor.blue
        lblSundayValue.textColor = lblSundayValue.text == "Closed" ? UIColor.red :UIColor.blue
        
        
    }
    
    func getDayTime(forDay:String) -> String {
        for item in arrayValuesForCell {
            if(item[forDay] != nil)
            {
                if((item[forDay] as! String) == "true" && (item["start"] as! String) != "" && (item["end"] as! String) != "" )
                {
                    return "\((item["start"] as! String)) To \((item["end"] as! String))"
                }
            }
        }
        
        return "Closed"
    }
    
    func getStartTime(forDay:String) -> String {
        for item in arrayValuesForCell {
            if(item[forDay] != nil)
            {
                if((item[forDay] as! String) == "true" && (item["start"] as! String) != "" && (item["end"] as! String) != "" )
                {
                    return "\((item["start"] as! String))"
                }
            }
        }
        
        return "Closed"
    }
    
    func getEndTime(forDay:String) -> String {
        for item in arrayValuesForCell {
            if(item[forDay] != nil)
            {
                if((item[forDay] as! String) == "true" && (item["start"] as! String) != "" && (item["end"] as! String) != "" )
                {
                    return "\((item["end"] as! String))"
                }
            }
        }
        
        return "Closed"
    }
    
    func getStatus(forDay:String) -> Bool {
        for item in arrayValuesForCell {
            if(item[forDay] != nil)
            {
                if((item[forDay] as! String) == "true" && (item["start"] as! String) != "" && (item["end"] as! String) != "" )
                {
                    return true
                }
            }
        }
        
        return false
    }
    
    public func getOpeningHour()-> [[String:Any]] {
        
        var arrOpeningHour:[[String:Any]] = []
        arrOpeningHour.append(["day":"Monday", "fromTime": getStartTime(forDay: "Mon"), "toTime":getEndTime(forDay: "Mon"), "status":getStatus(forDay: "Mon")])
        arrOpeningHour.append(["day":"Tuesday", "fromTime": getStartTime(forDay: "Tue"), "toTime":getEndTime(forDay: "Tue"), "status":getStatus(forDay: "Tue")])
        arrOpeningHour.append(["day":"Wednesday", "fromTime": getStartTime(forDay: "Wed"), "toTime":getEndTime(forDay: "Wed"), "status":getStatus(forDay: "Wed")])
        arrOpeningHour.append(["day":"Thuresday", "fromTime": getStartTime(forDay: "Thu"), "toTime":getEndTime(forDay: "Thu"), "status":getStatus(forDay: "Thu")])
        arrOpeningHour.append(["day":"Friday", "fromTime": getStartTime(forDay: "Fri"), "toTime":getEndTime(forDay: "Fri"), "status":getStatus(forDay: "Fri")])
        arrOpeningHour.append(["day":"Saturday", "fromTime": getStartTime(forDay: "Sat"), "toTime":getEndTime(forDay: "Sat"), "status":getStatus(forDay: "Sat")])
        arrOpeningHour.append(["day":"Sunday", "fromTime": getStartTime(forDay: "Sun"), "toTime":getEndTime(forDay: "Sun"), "status":getStatus(forDay: "Sun")])
        return arrOpeningHour
    }
    
}
