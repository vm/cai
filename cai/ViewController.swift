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
import SwiftyJSON

class ViewController: UIViewController {
    var audioRecorder: AVAudioRecorder!
    var filePath: NSURL?

    override func viewDidLoad() {
        super.viewDidLoad()

        let english = UILabel()
        self.addCharacter(english, char: "wǒ", size: 20, alignView: self.view)

        let chinese = UILabel()
        self.addCharacter(chinese, char: "我", size: 100, alignView: english)

        self.addButton(UIButton(type: UIButtonType.System))
    }

    func addCharacter(label: UILabel, char: String, size: CGFloat, alignView: UIView) {
      label.text = char
      label.font = UIFont(name: label.font.fontName, size: size)

      self.view.addSubview(label)

      label.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(alignView)
            make.top.equalTo(alignView).offset(80)
        }
    }

    func addButton(recordButton: UIButton) {
        recordButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Thin", size: 25)
        recordButton.setTitle("record", forState: UIControlState.Normal)

        recordButton.addTarget(self, action: Selector("startRecording:"), forControlEvents: UIControlEvents.TouchDown)
        recordButton.addTarget(self, action: Selector("endRecording:"), forControlEvents: UIControlEvents.TouchUpInside)

        self.view.addSubview(recordButton)

        recordButton.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.view).offset(80)
            make.bottom.equalTo(self.view).offset(-50)
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
        if let data = NSData(contentsOfURL: filePath!) {
            Alamofire
                .upload(.POST, "cai-tones.herokuapp.com", data: data)
                .responseJSON { response in
                    switch response.result {
                    case .Success:
                        if let value = response.result.value {
                            let json = JSON(value)
                            print("JSON: \(json)")
                        }
                    case .Failure(let error):
                        print(error)
                    }
            }
        }
    }

}
