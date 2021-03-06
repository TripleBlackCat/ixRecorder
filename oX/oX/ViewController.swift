//
//  ViewController.swift
//  oX
//
//  Created by Kavilan Nair on 2017/06/26.
//  Copyright © 2017 Kavilan Nair. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    
    var urlSound: URL?
    
    
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var stopButton: UIButton!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        stopButton.isHidden = true
        
        recordButton.isHidden = false
        
        let fileMgr = FileManager.default
        
        let dirPaths = fileMgr.urls(for: .documentDirectory,
                                    in: .userDomainMask)
        
        let soundFileURL = dirPaths[0].appendingPathComponent("sound.caf")
        
        self.urlSound = soundFileURL
        
        let recordSettings =
            [AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue,
             AVEncoderBitRateKey: 16,
             AVNumberOfChannelsKey: 2,
             AVSampleRateKey: 44100.0] as [String : Any]
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(
                AVAudioSessionCategoryPlayAndRecord)
        } catch let error as NSError {
            print("audioSession error: \(error.localizedDescription)")
        }
        
        do {
            try audioRecorder = AVAudioRecorder(url: soundFileURL,
                                                settings: recordSettings as [String : AnyObject])
            audioRecorder?.prepareToRecord()
        } catch let error as NSError {
            print("audioSession error: \(error.localizedDescription)")
        }
    
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    //This is how to parse information between view controllers over a segue.
    
    var someData = "I am data from View Controller one"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        if (segue.identifier == "stopRecording"){

            let playVC = segue.destination as! PlayViewController
            
           playVC.urlSound = urlSound
            
        }
    }
    
    
    @IBAction func startRecording(_ sender: UIButton) {
        
        
        stopButton.isHidden = false
        print("The button has been pressed")
    }
    
    

    @IBAction func stopRecording(_ sender: Any) {
        
        self.view.backgroundColor = UIColor.white
        recordButton.isEnabled = true
        
    
        
        if audioRecorder?.isRecording == true {
            audioRecorder?.stop()
        } else {
            audioPlayer?.stop()
        }
        
        if audioRecorder?.isRecording == false {
            stopButton.isEnabled = true
            recordButton.isEnabled = false
            
            /*do {
                try audioPlayer = AVAudioPlayer(contentsOf:
                    (audioRecorder?.url)!)
                audioPlayer!.delegate = self
                audioPlayer!.prepareToPlay()
                audioPlayer!.play()
            } catch let error as NSError {
                print("audioPlayer error: \(error.localizedDescription)")
            }*/
        }
        
        stopButton.isEnabled = false
        stopButton.isHidden = true
        recordButton.isHidden = false
        recordButton.isEnabled = true
        
        
    }
    
    @IBAction func recordSound(_ sender: Any) {
        
        recordButton.isHidden = true
        stopButton.isHidden = false
        self.view.backgroundColor = UIColor.red
        
        
        
        if audioRecorder?.isRecording == false {
            stopButton.isEnabled = true
            audioRecorder?.record()
        }
        
        
    }
    
    
    
}

