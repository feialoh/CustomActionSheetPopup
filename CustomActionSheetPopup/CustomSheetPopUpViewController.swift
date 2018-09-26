//
//  CustomSheetPopUpViewController.swift
//  CustomActionSheetPopup
//
//  Created by Feialoh Francis on 9/25/18.
//  Copyright © 2018 Feialoh Francis. All rights reserved.
//


import UIKit


protocol CustomPopUpDelegate {
    
    func itemActionDelegate(_ sender:UIButton)
    
}

class CustomSheetPopUpViewController: UIViewController {
    
    var backgroundView: UIView!
    
    var popUpView: UIView!
    
    var titleView: UIView!
    
    var popUpTitleLabel: UILabel!

    var itemsContainerStackView: UIStackView!
    
    var popUpViewHeight: NSLayoutConstraint!

    var scrollBottomMargin: NSLayoutConstraint!
    

    
    var popUpShowStatus = true
    
    var delegate:CustomPopUpDelegate?
    
    //Default constants
    var titleViewHeight:CGFloat = 50.0
    
    var buttonHeight:CGFloat = 50.0
    
    var buttonSpacing:CGFloat = 20
    
    var fontName = "HelveticaNeue-Bold"
    
    var titleSize:CGFloat  = 16.0
    
    var itemFontSize:CGFloat  = 16.0
    
    /*===============================================================================*/
    // MARK: - View Lifecycle Methods
    /*===============================================================================*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupViews()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupViews() {
        // Initialize views and add them to the ViewController's view
        
        //Adding background view
        
        backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0.3
        backgroundView.tag = 7
        self.view.addSubview(backgroundView)
        
        addConstraints(backgroundView, superView: self.view, safeArea:(true,self.view.layoutMarginsGuide))
        
        
        //Adding popup view
        
        popUpView = UIView()
        popUpView.backgroundColor = UIColor(hexString: "F2F2F2")!
        self.view.addSubview(popUpView)
        addConstraints(popUpView, superView: self.view, top:(false,0.0),bottom:(true,5.0),safeArea:(true,self.view.layoutMarginsGuide))
        
        
        popUpViewHeight = NSLayoutConstraint(item: popUpView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0)
        
        popUpViewHeight.priority = UILayoutPriority(rawValue: 900)
        popUpView.addConstraint(popUpViewHeight)
        
        popUpView.topAnchor.constraint(greaterThanOrEqualTo: self.view.layoutMarginsGuide.topAnchor,
                                    constant: 5.0).isActive = true

        //Popup Subviews
        //Title View
        titleView = UIView()
        titleView.backgroundColor = .clear
        popUpView.addSubview(titleView)
        addConstraints(titleView, superView: popUpView, bottom:(false,0.0),height:(true,titleViewHeight))
        
        //Title Label
        popUpTitleLabel = UILabel()
        popUpTitleLabel.textAlignment = .center
        titleView.addSubview(popUpTitleLabel)
        addConstraints(popUpTitleLabel, superView: titleView, centerX:(true,0.0),centerY:(true,0.0))
        
        //Scroll view
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        popUpView.addSubview(scrollView)
        addConstraints(scrollView, superView: popUpView,top:(false,0.0), bottom:(false,0.0))


        let top = NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: titleView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
            
        popUpView.addConstraint(top)

        scrollBottomMargin = NSLayoutConstraint(item: popUpView, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1.0, constant: 25.0)

        popUpView.addConstraint(scrollBottomMargin)
        
        
        //Item stack view
        
        itemsContainerStackView = UIStackView()
        itemsContainerStackView.axis = .vertical
        itemsContainerStackView.alignment = .center
        itemsContainerStackView.distribution = .fill
        scrollView.addSubview(itemsContainerStackView)
        addConstraints(itemsContainerStackView, superView: scrollView,width:(true,scrollView.frame.width))
        
    }
    
    
    /*===============================================================================*/
    // MARK: - Helper methods
    /*===============================================================================*/
    
    //Add items to stack
    
    func addItemsToStack(title:String,_ itemsArray:[String]){
        
        itemsContainerStackView.removeAllArrangedSubviews()
        itemsContainerStackView.spacing = buttonSpacing
        
        let maxHeight = UIScreen.main.bounds.size.height - Swift.min(UIApplication.shared.statusBarFrame.size.width, UIApplication.shared.statusBarFrame.size.height)
        
        for (index,items) in itemsArray.enumerated() {
            
            let itemButton = UIButton()
            itemButton.widthAnchor.constraint(equalToConstant: itemsContainerStackView.frame.width * 0.9).isActive = true
            itemButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
            itemButton.tag = index
            itemButton.setTitle(items, for: .normal)
            itemButton.setTitleColor(.black, for: .normal)
            attributedButton(itemButton,color: .white)
            itemButton.addAllSideBorder(cornerRadius:4.0, borderColor:UIColor.lightGray)
            itemsContainerStackView.addArrangedSubview(itemButton)
            itemButton.addTarget(self, action:#selector(sayAction(_:)), for: .touchUpInside)
            
        }
        
        let buttonHeights:CGFloat = CGFloat(itemsArray.count) * buttonHeight
        
        let spacing:CGFloat = CGFloat(itemsArray.count-1) * buttonSpacing
        
        let calculatedViewHeight = CGFloat(titleView.frame.height + buttonHeights + spacing + scrollBottomMargin.constant)
        
        popUpViewHeight.constant = (calculatedViewHeight < maxHeight) ? calculatedViewHeight:maxHeight
        
        popUpTitleLabel.text = title
        popUpTitleLabel.font = myFontName(fontName, size: itemFontSize)
        
        popUpView.addShadow(shadowRadius:0, cornerRadius:10.0)
    }
    
    
    
    @objc private func sayAction(_ sender: UIButton) {
        
        self.removeAnimate()
        delegate?.itemActionDelegate(sender)
        
    }
    
    
    func showAnimate()
    {
        popUpShowStatus = false
        self.view.isHidden = false
        
        self.view.frame = CGRect(x: 0 , y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        UIView.animate(withDuration: 0.25, animations: {
            
            self.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
        })
    }
    
    func removeAnimate()
    {
        popUpShowStatus = true
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
        }, completion: { (finished) -> Void in
            self.view.isHidden = true
        })
    }
    
    //For showing or hiding popup
    
    func showHidePopup(_ sender: UIButton,_ currentVC:UIViewController) {
        
        if (popUpShowStatus)  {
            
            currentVC.addChild(self)
            
            currentVC.view.addSubview(self.view)
            
            addConstraints(self.view, superView: currentVC.view)
            
            self.didMove(toParent: currentVC)
            
            showAnimate()
            
        }
        else
        {
            self.removeAnimate()
            
        }
        
    }
    
    
    //For dismissing popup on outerview tap
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if touches.first?.view?.tag == 7{
            removeAnimate()
            super.touchesEnded(touches , with: event)
        }
    }
    
    
    //For setting font with specified size
    func myFontName(_ name:String, size:CGFloat) -> UIFont
    {
        if let customFont = UIFont(name: name, size: size) {
            
            return customFont
        }
        
        return UIFont.systemFont(ofSize: size)
        
    }
    
    //Set button attributes
    func attributedButton(_ sender:UIButton, color: UIColor) {
        sender.clipsToBounds = true
        sender.layer.cornerRadius = 5
        sender.backgroundColor = color
        sender.titleLabel?.font = myFontName(fontName, size: titleSize)
    }
    
    
    //Constraints to safe area
    
    func addConstraints(_ myView:UIView, superView:UIView, leading:(Bool,CGFloat) = (true,0.0), trailing:(Bool,CGFloat) = (true,0.0), top:(Bool,CGFloat) = (true,0.0), bottom:(Bool,CGFloat) = (true,0.0), width: (Bool,CGFloat) = (false,0.0), height: (Bool,CGFloat) = (false,0.0),centerX: (Bool,CGFloat) = (false,0.0),centerY: (Bool,CGFloat) = (false,0.0),safeArea: (Bool,UILayoutGuide) = (false,UILayoutGuide())) {
        
        myView.translatesAutoresizingMaskIntoConstraints = false
        
        var topAnchor: NSLayoutYAxisAnchor!
        var bottomAnchor: NSLayoutYAxisAnchor!
        
        if safeArea.0 {
            
            topAnchor       = safeArea.1.topAnchor
            bottomAnchor    = safeArea.1.bottomAnchor
            
        }
        else {

            topAnchor       = superView.topAnchor
            bottomAnchor    = superView.bottomAnchor
        }
        
        
        if centerX.0 {
            
            myView.centerXAnchor.constraint(equalTo: superView.centerXAnchor,
                                            constant: centerX.1).isActive = true
        }
        else {
            if leading.0 {
                
                myView.leadingAnchor.constraint(equalTo: superView.leadingAnchor,
                                                constant: leading.1).isActive = true
                

            }
            
            if trailing.0 {
                
                myView.trailingAnchor.constraint(equalTo: superView.trailingAnchor,
                                                constant: trailing.1).isActive = true
            }
        }
        
        if centerY.0 {
            
            
            myView.centerYAnchor.constraint(equalTo: superView.centerYAnchor,
                                            constant: centerY.1).isActive = true
            
        }
        else {
            if top.0 {
                
                myView.topAnchor.constraint(equalTo: topAnchor,
                                               constant: top.1).isActive = true
            }
            
            if bottom.0 {
                
                myView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                            constant: bottom.1).isActive = true
                
            }
        }
        
        if width.0 {
            
            myView.widthAnchor.constraint(equalToConstant: width.1).isActive = true
        }
        
        if height.0 {
            
            myView.heightAnchor.constraint(equalToConstant: height.1).isActive = true
            
        }
        
        
        myView.layoutIfNeeded()
    }
}


extension UIStackView {
    
    func removeAllArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}



extension UIView {
    
    
    func addShadow(shadowColor:UIColor = UIColor.gray, shadowOpacity:Float = 100, shadowOffset:CGSize = CGSize.zero, shadowRadius:CGFloat = 5, cornerRadius:CGFloat = 0)
    {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = shadowRadius
        self.layer.cornerRadius = cornerRadius
    }
    
    
    func addAllSideBorder(cornerRadius:CGFloat = 0, borderWidth:CGFloat = 1, borderColor:UIColor = UIColor.gray) {
        
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth  = borderWidth
        self.layer.borderColor  = borderColor.cgColor
        
    }
    
}


extension UIColor {
    ///init method with hex string and alpha(default: 1)
    public convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        var formatted = hexString.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")
        if let hex = Int(formatted, radix: 16) {
            let red = CGFloat(CGFloat((hex & 0xFF0000) >> 16)/255.0)
            let green = CGFloat(CGFloat((hex & 0x00FF00) >> 8)/255.0)
            let blue = CGFloat(CGFloat((hex & 0x0000FF) >> 0)/255.0)
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        } else {
            return nil
        }
    }
    
}
