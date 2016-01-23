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
import Charts

class ViewController: UIViewController {
    var audioRecorder: AVAudioRecorder!
    var filePath: NSURL?

    override func viewDidLoad() {
        super.viewDidLoad()

        let english = UILabel()
        english.text = "wǒ"
        english.font = UIFont(name: english.font.fontName, size: 40)
        let chinese = UILabel()
        chinese.text = "我"
        chinese.font = UIFont(name: chinese.font.fontName, size: 40)

        self.view.addSubview(english)
        self.view.addSubview(chinese)
        english.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.view).offset(100)
            make.top.equalTo(self.view).offset(130)
        }
        chinese.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(self.view).offset(-100)
            make.top.equalTo(self.view).offset(130)
        }

        
        let recordButton = UIButton(type: UIButtonType.System) as UIButton
        recordButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Thin", size: 25)
        recordButton.setTitle("record", forState: UIControlState.Normal)
        recordButton.addTarget(self, action: Selector("startRecording:"), forControlEvents: UIControlEvents.TouchDown)
        recordButton.addTarget(self, action: Selector("endRecording:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(recordButton)
        recordButton.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.view).offset(80)
            make.bottom.equalTo(self.view).offset(-30)
            make.right.equalTo(self.view).offset(-80)
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
            Alamofire
                .upload(.POST, "meow.com/", data: data)
                .responseJSON { _ in }

        }
    }

}