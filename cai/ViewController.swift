//
//  ViewController.swift
//  cai
//
//  Created by Vignesh Mohankumar on 1/22/16.
//  Copyright © 2016 Vignesh Mohankumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordButton = UIButton()
        self.view.addSubview(recordButton)
        recordButton.addTarget(self, action: Selector("startRecording:"), forControlEvents: UIControlEvents.TouchUpInside)
    }

    func startRecording(sender: UIButton!) {
        print("meow")
    }

}