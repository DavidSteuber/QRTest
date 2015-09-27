//
//  QRCode.swift
//  QRTest
//
//  Created by David Steuber on 4/8/15.
//  Copyright (c) 2015 David Steuber.
//

import UIKit
import CoreImage

extension UIImage {

    class func qrCodeWithMessage(message: String) -> UIImage? {
        let data: NSData = message.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
        let qrEncoder = CIFilter(name: "CIQRCodeGenerator", withInputParameters: ["inputMessage":data, "inputCorrectionLevel":"H"])
        let ciImage = qrEncoder!.outputImage
        return UIImage(CIImage: ciImage!)
    }

    func scaleQRCodeWithNoInterpolation(size: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContext(CGSizeMake(size, size));
        let context = UIGraphicsGetCurrentContext();
        CGContextSetInterpolationQuality(context, CGInterpolationQuality.None)
        self.drawInRect(CGRectMake(0, 0, size, size))
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image
    }

}