//
//  ViewController.swift
//  QRTest
//
//  Created by David Steuber on 4/4/15.
//  Copyright (c) 2015 David Steuber. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let qrimage = image {
            qrimage.image = QRCodeImage("This is what I want!")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func QRCodeImage(message: String) -> UIImage? {
        let data: NSData = message.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
        let qrEncoder = CIFilter(name: "CIQRCodeGenerator", withInputParameters: ["inputMessage":data, "inputCorrectionLevel":"H"])
        let ciImage: CIImage = qrEncoder.outputImage
        var image = UIImage(CIImage: ciImage)

        // Scale image without aliasing. Thanks, OOPer!

        UIGraphicsBeginImageContext(CGSizeMake(200, 200));
        let context = UIGraphicsGetCurrentContext();
        CGContextSetInterpolationQuality(context, kCGInterpolationNone)//
        image!.drawInRect(CGRectMake(0, 0, 200, 200))
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image
    }

}

