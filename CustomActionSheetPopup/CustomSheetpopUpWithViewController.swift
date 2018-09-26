//
//  AddFundsPopUpViewController.swift
//  CustomActionSheetPopup
//
//  Created by Feialoh Francis on 9/20/18.
//  Copyright © 2018 Feialoh Francis. All rights reserved.
//

import UIKit


protocol CustomSheetPopUpWithViewDelegate {
    
    func buttonActionDelegate(_ sender:UIButton)
    
}

class CustomSheetpopUpWithViewController: UIViewController {
    
    
    @IBOutlet weak var addFundsPopView: UIView!
    
    @IBOutlet weak var addFundsTitleLabel: UILabel!
    
    @IBOutlet weak var itemsContainerStackView: UIStackView!
    
    @IBOutlet weak var popUpViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var titleView: UIView!
    
    @IBOutlet weak var scrollBottomMargin: NSLayoutConstraint!
    
    
    var BUTTON_HEIGHT:CGFloat = 50.0
    
    var BUTTON_SPACING:CGFloat = 20
    
    var FONT_NAME = "HelveticaNeue-Bold"
    
    var TITLE_SIZE:CGFloat  = 16.0
    
    var ITEM_FONT_SIZE:CGFloat  = 16.0
    
    var popUpShowStatus = true
    
    var delegate:CustomSheetPopUpWithViewDelegate?
    
 
    /*===============================================================================*/
    // MARK: - View Lifecycle Methods
    /*===============================================================================*/
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    
    /*===============================================================================*/
    // MARK: - Helper methods
    /*===============================================================================*/
    
    //Add items to stack
    
    func addItemsToStack(title:String,_ itemsArray:[String]){
        
        itemsContainerStackView.removeAllArrangedSubviews()
        itemsContainerStackView.spacing = BUTTON_SPACING
        
        let maxHeight = UIScreen.main.bounds.size.height - Swift.min(UIApplication.shared.statusBarFrame.size.width, UIApplication.shared.statusBarFrame.size.height)
        
        for (index,items) in itemsArray.enumerated() {
            
            let itemButton = UIButton()
            itemButton.widthAnchor.constraint(equalToConstant: itemsContainerStackView.frame.width * 0.9).isActive = true
            itemButton.heightAnchor.constraint(equalToConstant: BUTTON_HEIGHT).isActive = true
            itemButton.tag = index
            itemButton.setTitle(items, for: .normal)
            itemButton.setTitleColor(.black, for: .normal)
            attributedButton(itemButton,color: .white)
            itemButton.addAllSideBorder(cornerRadius:4.0, borderColor:UIColor.lightGray)
            itemsContainerStackView.addArrangedSubview(itemButton)
            itemButton.addTarget(self, action:#selector(sayAction(_:)), for: .touchUpInside)
            
        }
        
        let buttonHeights:CGFloat = CGFloat(itemsArray.count) * BUTTON_HEIGHT
        
        let buttonSpacing:CGFloat = CGFloat(itemsArray.count-1) * BUTTON_SPACING
        
        let calculatedViewHeight = CGFloat(titleView.frame.height + buttonHeights + buttonSpacing + scrollBottomMargin.constant)

        popUpViewHeight.constant = (calculatedViewHeight < maxHeight) ? calculatedViewHeight:maxHeight
        
        addFundsTitleLabel.text = title
        addFundsTitleLabel.font = myFontName(FONT_NAME, size: ITEM_FONT_SIZE)
        
        addFundsPopView.addShadow(shadowRadius:0, cornerRadius:10.0)
    }
    
    
    
    @objc private func sayAction(_ sender: UIButton) {
        
        self.removeAnimate()
        delegate?.buttonActionDelegate(sender)
        
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
        
        if touches.first?.view?.tag == 8{
            removeAnimate()
            super.touchesEnded(touches , with: event)
        }
    }
    
    
    //For adding all constraints
    func addConstraints(_ myView:UIView, superView:UIView, leading:(Bool,CGFloat) = (true,0.0), trailing:(Bool,CGFloat) = (true,0.0), top:(Bool,CGFloat) = (true,0.0), bottom:(Bool,CGFloat) = (true,0.0), width: (Bool,CGFloat) = (false,0.0), height: (Bool,CGFloat) = (false,0.0),centerX: (Bool,CGFloat) = (false,0.0),centerY: (Bool,CGFloat) = (false,0.0)) {
        
        myView.translatesAutoresizingMaskIntoConstraints = false
        
        if centerX.0 {
            
            let centerX = NSLayoutConstraint(item: myView, attribute: .centerX, relatedBy: .equal,
                                             toItem: superView, attribute: .centerX,
                                             multiplier: 1.0, constant: centerX.1)
            
            superView.addConstraint(centerX)
        }
        else {
            if leading.0 {
                
                let leading = NSLayoutConstraint(item: myView, attribute: .leading, relatedBy: .equal, toItem: superView, attribute: .leading, multiplier: 1.0, constant: leading.1)
                
                superView.addConstraint(leading)
            }
            
            if trailing.0 {
                
                let trailing = NSLayoutConstraint(item: myView, attribute: .trailing, relatedBy: .equal, toItem: superView, attribute: .trailing, multiplier: 1.0, constant: trailing.1)
                
                superView.addConstraint(trailing)
            }
        }
        
        if centerY.0 {
            
            let centerY = NSLayoutConstraint(item: myView, attribute: .centerY, relatedBy: .equal,
                                             toItem: superView, attribute: .centerY,
                                             multiplier: 1.0, constant: centerY.1)
            
            superView.addConstraint(centerY)
            
        }
        else {
            if top.0 {
                
                let top = NSLayoutConstraint(item: myView, attribute: .top, relatedBy: .equal, toItem: superView, attribute: .top, multiplier: 1.0, constant: top.1)
                
                superView.addConstraint(top)
            }
            
            if bottom.0 {
                
                let bottom = NSLayoutConstraint(item: myView, attribute: .bottom, relatedBy: .equal, toItem: superView, attribute: .bottom, multiplier: 1.0, constant: bottom.1)
                
                superView.addConstraint(bottom)
                
            }
        }
        
        if width.0 {
            
            let width = NSLayoutConstraint(item: myView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: width.1)
            
            superView.addConstraint(width)
            
        }
        
        if height.0 {
            
            let height = NSLayoutConstraint(item: myView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: height.1)
            
            superView.addConstraint(height)
            
        }
        
        
        myView.layoutIfNeeded()
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
        sender.titleLabel?.font = myFontName(FONT_NAME, size: TITLE_SIZE)
    }

}
