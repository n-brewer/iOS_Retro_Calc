//
//  ViewController.swift
//  Retro-Calc
//
//  Created by Nathan Brewer on 1/25/16.
//  Copyright © 2016 Nathan Brewer. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
     //these are outlets on open screen
    
    @IBOutlet weak var retroCalc: UIImageView!
    @IBOutlet weak var robotBtn: UIButton!
    @IBOutlet weak var launchBg: UIImageView!
    @IBOutlet weak var launchGround: UIImageView!
    
    //these are outlets for main screen
    
    @IBOutlet weak var outputLbl: UILabel!
    @IBOutlet weak var spaceBg: UIImageView!
    @IBOutlet weak var ground: UIImageView!
    @IBOutlet weak var calcBody: UIStackView!
    @IBOutlet weak var calcControls: UIStackView!
    @IBOutlet weak var clearBtn: UIButton!
    
   
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var btnSound: AVAudioPlayer!
    
    
    var runningNumber = ""
    var leftValString = ""
    var rightValString = ""
    var currentOperation = Operation.Empty
    var result = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
           try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    
    @IBAction func robotPressed(btn: UIButton) {
        robotBtn.hidden = true
        retroCalc.hidden = true
        launchBg.hidden = true
        launchGround.hidden = true
        
        outputLbl.hidden = false
        spaceBg.hidden = false
        ground.hidden = false
        calcBody.hidden = false
        calcControls.hidden = false
        clearBtn.hidden = false
    }
    
    @IBAction func clearBtnPressed(btn: UIButton) {
        playSound()
        runningNumber = ""
        leftValString = ""
        rightValString = ""
        currentOperation = Operation.Empty
        result = ""
        outputLbl.text = "0"
        
    }
    
    @IBAction func numPressed(btn: UIButton) {
        playSound()
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }

    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }

    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }

    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(type: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            // run math
            
            if runningNumber != "" {
                rightValString = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValString)! / Double(rightValString)!)"
                } else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftValString)! - Double(rightValString)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValString)! + Double(rightValString)!)"
                }
                
                leftValString = result
                outputLbl.text = result
            }
            
    
            currentOperation = type
        }
            
            
         else {
            //this is the first time operation has been pressed
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = type
            
        }
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
            btnSound.play()
    }
}




