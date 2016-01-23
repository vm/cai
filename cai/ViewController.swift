//
//  ViewController.swift
//  cai
//
//  Created by Vignesh Mohankumar on 1/22/16.
//  Copyright © 2016 Vignesh Mohankumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recordButton = UIButton(type: UIButtonType.System) as UIButton
        recordButton.frame = CGRectMake(100, 100, 100, 50)
        recordButton.setTitle("we out here", forState: UIControlState.Normal)
        recordButton.addTarget(self, action: Selector("startRecording:"), forControlEvents: UIControlEvents.TouchDown)
        recordButton.addTarget(self, action: Selector("endRecording:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(recordButton)
    }

    func startRecording(sender: UIButton!) {
        print("start")
    }
    
    func endRecording(sender: UIButton!) {
        print("end")
    }

}