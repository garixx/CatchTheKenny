//
//  ViewController.swift
//  CatchTheKenny
//
//  Created by Ihor Isametov on 23.12.2023.
//

import UIKit

class ViewController: UIViewController {
    var score = 0
    var highScore = 0
    var counter = 0
    var kennyArray = [UIImageView]()
    
    var timer = Timer()
    var hideTimer = Timer()
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highestScoreLabel: UILabel!
    
    @IBOutlet weak var kenny9: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny1: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scoreLabel.text = "Score: \(score)"
        
        if let hs = UserDefaults.standard.object(forKey: "kenny_highscore") {
            highScore = hs as! Int
        }
        
        highestScoreLabel.text = "HighScore: \(highScore)"
        
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        let gestureRecongnizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecongnizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecongnizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecongnizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecongnizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecongnizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecongnizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecongnizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecongnizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        kenny1.addGestureRecognizer(gestureRecongnizer1)
        kenny2.addGestureRecognizer(gestureRecongnizer2)
        kenny3.addGestureRecognizer(gestureRecongnizer3)
        kenny4.addGestureRecognizer(gestureRecongnizer4)
        kenny5.addGestureRecognizer(gestureRecongnizer5)
        kenny6.addGestureRecognizer(gestureRecongnizer6)
        kenny7.addGestureRecognizer(gestureRecongnizer7)
        kenny8.addGestureRecognizer(gestureRecongnizer8)
        kenny9.addGestureRecognizer(gestureRecongnizer9)
        
        kennyArray = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]
        
        counter = 10
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
        hideKenny()
    }
    
    @objc func hideKenny() {
        for kenny in kennyArray {
            kenny.isHidden = true
        }
        
        let random = arc4random_uniform(UInt32(kennyArray.count - 1))
        kennyArray[Int(random)].isHidden = false
    }
    
    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countDown() {
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for kenny in kennyArray {
                kenny.isHidden = true
            }
            
            if self.score > self.highScore {
                self.highScore = self.score
                highestScoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "kenny_highscore")
            }
            
            let alert = UIAlertController(title: "Time's up!!!", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                self.score = 0
                self.counter = 10
                
                self.scoreLabel.text = "Score: \(self.score)"
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        
        }
    }

}

