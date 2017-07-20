//
//  CustomTextField.swift
//  OfficeHourPicker
//
//  Created by Varun Naharia on 08/03/17.
//  Copyright © 2017 Varun Naharia. All rights reserved.
//

import UIKit

@IBDesignable
class CustomTextField: UITextField,UITextFieldDelegate {

    @IBOutlet weak var validationLabel:CustomLabel!
    var placeholdertext: String?
    @IBInspectable
    public var cornerRadius :CGFloat {
        
        set { layer.cornerRadius = newValue }
        
        get {
            return layer.cornerRadius
        }
        
    }
    
    // Provides left padding for images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x -= rightPadding
        return textRect
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var isUnderLine:Bool = false
    {
        didSet{
            updateView()
        }
    }
    
    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    var errorLable:CustomLabel = CustomLabel()
    func setError(error:String?){
        if(error != nil)
        {
            self.text = ""
            if(validationLabel == nil)
            {
                self.attributedPlaceholder = NSAttributedString(string: error!, attributes: [NSForegroundColorAttributeName: UIColor.red])
            }
            else
            {
                validationLabel.text = error!
                validationLabel.textColor = UIColor.red
                validationLabel.leftImage = #imageLiteral(resourceName: "alert")
                self.delegate = self
                //let heightConstraint = validationLabel.heightAnchor.constraint(equalToConstant: 23)
                //NSLayoutConstraint.activate([heightConstraint])
                for constraint in validationLabel.constraints {
                    if(constraint.firstAttribute == NSLayoutAttribute.height)
                    {
                        
                        validationLabel.alpha = 0.5
                        self.validationLabel.center.y = self.validationLabel.center.y-25
                        constraint.constant = 25
                        UIView.animate(withDuration: 0.5,
                                       delay: 0.0,
                                       options: UIViewAnimationOptions.transitionCurlDown,
                                       animations: { () -> Void in
                                        self.validationLabel.alpha = 1.0
                                        self.validationLabel.center.y = self.validationLabel.center.y + 25
                                        
                        }, completion: { (finished) -> Void in
                            if(finished)
                            {
                            }
                        })
                        
                    }
                }
            }
            
        }
        
    }
    
    @IBInspectable var leftPadding: CGFloat = 0
    @IBInspectable var rightPadding: CGFloat = 0
    @IBInspectable var textLeftPadding:CGFloat = 0
    
    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    @IBInspectable var underlineColor:UIColor = UIColor.black
    {
        didSet{
            self.updateView()
        }
    }
    private var placeholderColorValue:UIColor = UIColor.lightGray
    @IBInspectable public var placeholderColor:UIColor
    {
        set{
            self.attributedPlaceholder = NSAttributedString(string:placeholder!, attributes: [NSForegroundColorAttributeName: newValue])
            placeholderColorValue = newValue
        }
        get{
            return placeholderColorValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    func setUpView() {
        if(rightImage != nil)
        {
            self.leftViewMode = UITextFieldViewMode.always
            let rightImageView:UIImageView = UIImageView(image: rightImage)
            rightImageView.frame = CGRect(x: 0, y: 0, width: self.frame.size.height, height: self.frame.size.height)
            self.rightView = rightImageView
        }
        else {
            rightViewMode = UITextFieldViewMode.never
            rightView = nil
        }
    }
    
    func updateView() {
        if let imageLeft = leftImage {
            leftViewMode = UITextFieldViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.image = imageLeft
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            leftView = imageView
        } else {
            leftViewMode = UITextFieldViewMode.never
            leftView = nil
        }
        
        if let imageRight = rightImage {
            rightViewMode = UITextFieldViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.image = imageRight
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            rightView = imageView
        } else {
            rightViewMode = UITextFieldViewMode.never
            rightView = nil
        }
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSForegroundColorAttributeName: color])
        if(self.isUnderLine)
        {
            let underline:UIView = UIView()
            underline.frame = CGRect(x: 0, y: self.frame.size.height-1, width: self.frame.size.width, height: 1)
            underline.backgroundColor = underlineColor
            self.addSubview(underline)
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: textLeftPadding, y: 0, width: bounds.width, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(validationLabel != nil && validationLabel.alpha > 0.0)
        {
            for constraint in validationLabel.constraints {
                if(constraint.firstAttribute == NSLayoutAttribute.height)
                {
                    
                    validationLabel.alpha = 0.5
                    UIView.animate(withDuration: 0.5,
                                   delay: 0.0,
                                   options: UIViewAnimationOptions.transitionCurlDown,
                                   animations: { () -> Void in
                                    self.validationLabel.alpha = 0.0
                                    self.validationLabel.center.y = self.validationLabel.center.y - 25
                                    
                    }, completion: { (finished) -> Void in
                        if(finished)
                        {
                            constraint.constant = 0
                        }
                    })
                    
                }
            }
        }
        
    }

}
