//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation


var player: AVAudioPlayer?



class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var mainTitle: UILabel!
    
    let eggTimes = [
        "Soft":5, "Medium":7, "Hard":12
    ]
    
    var timer = Timer()
    var cookingTime = 0
    var passTime = 0
    
    
    
    
    @IBAction func heardnessSelected(_ sender: UIButton) {
        
        
        
        timer.invalidate()
        cookingTime = 0
        passTime = 0
        progressBar.progressTintColor = .blue
        progressBar.setProgress(0.0,animated: false)
        
        let hardness = sender.currentTitle
        
        cookingTime = eggTimes[hardness!]!
        
        timer = Timer.scheduledTimer(timeInterval:1.0 , target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
        
    }
    @objc func timerAction() {
        // execute change map setting
        if cookingTime - passTime > 0 {
            passTime += 1
            mainTitle.text = "Finish in \(cookingTime - passTime) Sec."
            
            let progress = Float(passTime)/Float(cookingTime)
            
            progressBar.setProgress(progress , animated:true)
            
        }else if cookingTime - passTime == 0{
            cookingTime = 0
            passTime = 0
            mainTitle.text = "Done!"
            mainTitle.textColor = .orange
            progressBar.progressTintColor = .orange
            
            playSound()
            timer.invalidate()
           
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player!.numberOfLoops = 0
        player!.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.6) {
            player?.stop()
            
        }
    }
}
