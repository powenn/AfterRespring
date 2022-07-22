// codes from https://github.com/Paisseon/Chocola
// some modifications by powen

import CepheiPrefs
import Cephei
import UIKit
import CoreGraphics

class RootListController: HBRootListController { // PSListController  HBRootListController
	override var specifiers: NSMutableArray? {
		get {
			if let specifiers = value(forKey: "_specifiers") as? NSMutableArray {
				return specifiers
			} else {
				let specifiers = loadSpecifiers(fromPlistName: "Root", target: self)
				setValue(specifiers, forKey: "_specifiers")
				return specifiers
			}
		}
		set {
			super.specifiers = newValue
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let appearanceSettings = HBAppearanceSettings()
		appearanceSettings.tintColor = UIColor(red: 0.4, green: 0, blue: 0.4, alpha: 1)
//        let tap = UITapGestureRecognizer(target: self.specifiers, action: #selector(dismissKeyboard))
//        view.addGestureRecognizer(tap)
        self.table.keyboardDismissMode = .onDrag
    }
	
	@objc func respring() {
		HBRespringController.respring()
	}
//    @objc func dismissKeyboard() {
//        //Causes the view (or one of its embedded text fields) to resign the first responder status.
//        view.endEditing(true)
//    }
//    override func _returnKeyPressed(_ arg1: Any!) {
//            view.endEditing(true)
//        }
}
