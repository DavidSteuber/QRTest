//
//  ViewController.swift
//  QRTest
//
//  Created by David Steuber on 4/4/15.
//  Copyright (c) 2015 David Steuber.
//

import UIKit
import CoreImage

class ViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let uiimage = image {
            let code = UIImage.qrCodeWithMessage("https://www.david-steuber.com")
            uiimage.image = code?.scaleQRCodeWithNoInterpolation(200)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UITextFieldDelegate Methods. All of them are optional.

    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        print("textFieldShouldBeginEditing called")
        return true
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        print("textFieldDidBeginEditing called")
    }

    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing called")
        return true
    }

    func textFieldDidEndEditing(textField: UITextField) {
        print("textFieldDidEndEditing called")
    }

    func textFieldShouldClear(textField: UITextField) -> Bool {
        print("textFieldShouldClear called")
        textField.resignFirstResponder()
        return true
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("textFieldShouldReturn called")
        if let text = textField.text {
            print(text)
            let code = UIImage.qrCodeWithMessage(text)
            image.image = code?.scaleQRCodeWithNoInterpolation(200)
        }
        textField.resignFirstResponder()
        return true
    }
}

