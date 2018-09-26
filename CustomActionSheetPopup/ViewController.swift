//
//  ViewController.swift
//  CustomActionSheetPopup
//
//  Created by Feialoh Francis on 9/20/18.
//  Copyright © 2018 Feialoh Francis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var popUpVC:CustomSheetpopUpWithViewController!
    
    var myPopUp:CustomSheetPopUpViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        popUpVC = getViewController(storyboardID: "CustomPopups", viewControllerID: "AddFundsPopUpVC") as? CustomSheetpopUpWithViewController
        popUpVC.delegate = self
        
        myPopUp = CustomSheetPopUpViewController()
        myPopUp.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func showPopupWithLimited1ButtonAction(_ sender: UIButton) {
        
        var itemsArray = [String]()
        
        for index in 1...5{
            
            itemsArray.append("Item \(index)")
        }
        
        popUpVC.showHidePopup(sender, self)
        popUpVC.addItemsToStack(title: "My Pop Up",itemsArray)
        
    }
    
     @IBAction func showPopupWithUnLimited1ButtonAction(_ sender: UIButton) {
        
        
        var itemsArray = [String]()
        
        for index in 1...20{
            
            itemsArray.append("Item \(index)")
        }
        
        popUpVC.showHidePopup(sender, self)
        popUpVC.addItemsToStack(title: "My Pop Up",itemsArray)
        
    }
    
    
    @IBAction func showPopupWithLimited2ButtonAction(_ sender: UIButton) {
        
        var itemsArray = [String]()
        
        for index in 1...5{
            
            itemsArray.append("Item \(index)")
        }
        
        myPopUp.showHidePopup(sender, self)
        myPopUp.addItemsToStack(title: "My Pop Up",itemsArray)
        
    }
    
    
    @IBAction func showPopupWithUnLimited2ButtonAction(_ sender: UIButton) {
        
        var itemsArray = [String]()
        
        for index in 1...20{
            
            itemsArray.append("Item \(index)")
        }
        
        myPopUp.showHidePopup(sender, self)
        myPopUp.addItemsToStack(title: "My Pop Up",itemsArray)
        
    }
    
    
    
    
    //Get viewcontroller for storyboard
    
    func getViewController(storyboardID:String,viewControllerID:String) -> UIViewController
    {
        
        let storyboard = UIStoryboard(name: storyboardID, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerID)
        
        return viewController
    }
    
    
}

extension ViewController:CustomPopUpDelegate {
    
    
    /*===============================================================================*/
    // MARK: - Custom Popup Delegate
    /*===============================================================================*/
    
    
    func itemActionDelegate(_ sender: UIButton) {

        print(sender.titleLabel?.text ?? "No Title")

    }
    
    
}

extension ViewController:CustomSheetPopUpWithViewDelegate {
    
    
    /*===============================================================================*/
    // MARK: - Add Funds Popup Delegate
    /*===============================================================================*/
    
    
    func buttonActionDelegate(_ sender: UIButton) {
        
        print(sender.titleLabel?.text ?? "No Title")
        
//        switch(sender.tag){
//        case 0:
//            print(sender.titleLabel?.text ?? "No Title")
//            
//            break
//        case 1:
//            print(sender.titleLabel?.text ?? "No Title")
//            
//            break
//        case 2:
//            print(sender.titleLabel?.text ?? "No Title")
//            
//            break
//        case 3:
//            print(sender.titleLabel?.text ?? "No Title")
//            
//            break
//            
//        case 4:
//            print(sender.titleLabel?.text ?? "No Title")
//            
//            break
//            
//        default:
//            print("default\n")
//        }
    }
    
    
}
