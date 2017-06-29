//
//  PlayViewController.swift
//  oX
//
//  Created by Kavilan Nair on 2017/06/28.
//  Copyright © 2017 Kavilan Nair. All rights reserved.
//

import UIKit
import AVFoundation



class PlayViewController: UIViewController, AVAudioPlayerDelegate{
    
    var urlSound: URL?
    var message: String? //just used for testing, passing data through a segue
    
    var audioPlayer: AVAudioPlayer?
    var engine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let msg = message {
            print(msg)
        }
        
        engine = AVAudioEngine()
        
        
        do {
            audioFile = try AVAudioFile(forReading: urlSound!)
        } catch {
            print(error)
        }
        
        
        
        // Do any additional setup after loading the view.
    }

    
    
    func playSound(value: Float, rateOrPitch: String){
        var audioPlayerNode = AVAudioPlayerNode()
        
        audioPlayerNode.stop()
        engine.stop()
        engine.reset()
        
        engine.attach(audioPlayerNode)
        
        var changeAudioUnitTime = AVAudioUnitTimePitch()
        
        if (rateOrPitch == "rate") {
            changeAudioUnitTime.rate = value
        } else {
            changeAudioUnitTime.pitch = value
        }
        
        engine.attach(changeAudioUnitTime)
        engine.connect(audioPlayerNode, to: changeAudioUnitTime, format: nil)
        engine.connect(changeAudioUnitTime, to: engine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile, at: nil, completionHandler: nil)
        audioPlayerNode.play()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func playSound(_ sender: Any) {
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf:
                (urlSound)!)
            audioPlayer!.delegate = self
            audioPlayer!.prepareToPlay()
            audioPlayer!.play()
        } catch let error as NSError {
            print("audioPlayer error: \(error.localizedDescription)")
        }
        
        

        
        
    }

    @IBAction func stopSoundPlayBack(_ sender: UIButton) {
        
    }
}

