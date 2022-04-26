//
//  ViewController.swift
//  goracing
//
//  Created by Гость on 26.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pcCar: UIImageView!
    @IBOutlet weak var userCar: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var semaforLabel: UILabel!
    @IBOutlet weak var lineFinish: UIImageView!
    
    
    var stateSemafor: Int = 1
    var timerGame: Timer!
    var timerPC: Timer!
    
    @objc func psDrive() {
        if stateSemafor == 2{
            pcCar.center.x += 10
            
        }
        
        if pcCar.center.x > lineFinish.center.x {
            resultLabel.isHighlighted = false
            resultLabel.text = "YOU LOSE!"
            resultLabel.textColor = .red
            timerPC.invalidate()
            timerGame.invalidate()
        }
    }
    
    @objc func intervalTimer() {
        
        stateSemafor += 1
    }
    
    if stateSemafor {
    case 1:
        semaforLabel.text = "STOP"
        semaforLabel.textColor = .red
    case 2:
        semaforLabel.text = "DRIVE"
        semaforLabel.textColor = .green
    default:
        break
    }
   @IBAction func startGame(_ sender: UIButton) {
    semaforLabel.isHidden = false
       
       timerGame =
       Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(intervalTimer), userInfo: nil, repeats: true)
       timerPC = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(psDrive), userInfo: <#T##Any?#>, repeats: <#T##Bool#>)
}
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

