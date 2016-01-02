//
//  QRCodeViewController.swift
//  AngelHack Manhattan
//
//  Created by Mohan Dhar on 7/11/15.
//  Copyright © 2015 Mohan Dhar. All rights reserved.
//

import UIKit

class QRCodeViewController: UIViewController {

    var uniqueID:String?
    
    @IBOutlet var QRImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
/*
    func generateQR() {
        if let id = uniqueID {
            let data = id.dataUsingEncoding  (NSISOLatin1StringEncoding)
            var filter = CIFilter(name: "CIQRCodeGenerator")
        
            filter?.setValue(data, forKey: "uniqueID")
            filter?.setValue("Q", forKey: "inputCorrectionLevel")
        
            self.QRImage.image = filter?.outputImage
        }
        
    }

*/
    
}
