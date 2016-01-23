//
//  ViewController.swift
//  cai
//
//  Created by Vignesh Mohankumar on 1/22/16.
//  Copyright © 2016 Vignesh Mohankumar. All rights reserved.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
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
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let recordingName = "sound.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        print("start")
    }
    
    func endRecording(sender: UIButton!) {
        audioRecorder.stop()
        print("end")
    }
    
    func sendSound(String

}