//
//  ViewController.swift
//  QRTest
//
//  Created by David Steuber on 4/4/15.
//  Copyright (c) 2015 David Steuber.
//

import UIKit
import CoreImage

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let qrimage = image {
            qrimage.image = QRCodeImage("https://www.david-steuber.com")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UITextFieldDelegate Methods. All of them are optional.

    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        println("textFieldShouldBeginEditing called")
        return true
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        println("textFieldDidBeginEditing called")
    }

    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        println("textFieldShouldEndEditing called")
        return true
    }

    func textFieldDidEndEditing(textField: UITextField) {
        println("textFieldDidEndEditing called")
    }

    func textFieldShouldClear(textField: UITextField) -> Bool {
        println("textFieldShouldClear called")
        textField.resignFirstResponder()
        return true
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        println("textFieldShouldReturn called")
        if let text = textField.text {
            println(text)
            image.image = QRCodeImage(text)
        }
        textField.resignFirstResponder()
        return true
    }

    // MARK: QRCodeImage is what generates the UIImage from a String

    func QRCodeImage(message: String) -> UIImage? {
        let data: NSData = message.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
        let qrEncoder = CIFilter(name: "CIQRCodeGenerator", withInputParameters: ["inputMessage":data, "inputCorrectionLevel":"H"])
        let ciImage: CIImage = qrEncoder.outputImage
        var image = UIImage(CIImage: ciImage)

        // Scale image without aliasing. Thanks, OOPer!

        UIGraphicsBeginImageContext(CGSizeMake(200, 200));
        let context = UIGraphicsGetCurrentContext();
        CGContextSetInterpolationQuality(context, kCGInterpolationNone)
        image!.drawInRect(CGRectMake(0, 0, 200, 200))
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image
    }

}

