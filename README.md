# CustomActionSheetPopup
[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/swift-4.2-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)
![OS](https://img.shields.io/badge/ios-10.0%2B-blue.svg)

A simple project showing how to create a custom action sheet style popup using StackView programmatically and also with a view.

# ScreenShot
![Alt][screenshot1]		![Alt][screenshot2]

[screenshot1]:https://github.com/feialoh/CustomActionSheetPopup/blob/master/CustomSheetScreenShot1.png
[screenshot2]:https://github.com/feialoh/CustomActionSheetPopup/blob/master/CustomSheetScreenShot2.png

# Usage

Drag and drop CustomSheetPopUpViewController.swift in your project file.

``` swift
// Using in ViewController
//Initialization
var myPopUp:CustomSheetPopUpViewController!
myPopUp = CustomSheetPopUpViewController()
myPopUp.delegate = self

// Calling popup
myPopUp.buttonHeight = 50
myPopUp.showHidePopup(sender, self)
myPopUp.addItemsToStack(title: "My Pop Up",["Item 1, Item 2, Item 3"])
myPopUp.popUpView.backgroundColor = .red

//Get button actions in delegate
extension ViewController:CustomPopUpDelegate {
    func itemActionDelegate(_ sender: UIButton) {
        //Do something here using button tags or title
    } 
}

```

## LICENSE

Available under the MIT license. See the LICENSE file for more info.
