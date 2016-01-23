//
//  ViewController.swift
//  cai
//
//  Created by Vignesh Mohankumar on 1/22/16.
//  Copyright © 2016 Vignesh Mohankumar. All rights reserved.
//

import AVFoundation
import UIKit
import Alamofire
import SnapKit

class ViewController: UIViewController {
    var audioRecorder: AVAudioRecorder!
    var filePath: NSURL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let recordButton = UIButton(type: UIButtonType.System) as UIButton
        recordButton.frame = CGRectMake(100, 100, 100, 50)
        recordButton.setTitle("we out here", forState: UIControlState.Normal)
        recordButton.addTarget(self, action: Selector("startRecording:"), forControlEvents: UIControlEvents.TouchDown)
        recordButton.addTarget(self, action: Selector("endRecording:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(recordButton)
        recordButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(20)
            make.left.equalTo(self.view).offset(20)
            make.bottom.equalTo(self.view).offset(-20)
            make.right.equalTo(self.view).offset(-20)
        }
    }

    func startRecording(sender: UIButton!) {
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let recordingName = "sound.wav"
        let pathArray = [dirPath, recordingName]
        filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func endRecording(sender: UIButton!) {
        audioRecorder.stop()
        showGraph()
    }
    
    func showGraph() {
        if let data = NSData(contentsOfURL: filePath!) {
            Alamofire.upload(.POST, "meow.com/", data: data)
            .responseJSON { _ in }
        }
    }
    
}