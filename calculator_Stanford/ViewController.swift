//
//  ViewController.swift
//  calculator_Stanford
//
//  Created by Philippe Blanchette on 2017-02-07.
//  Copyright © 2017 Philippe Blanchette. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet private var display: UILabel!
    
    @IBOutlet var displayEquation: UILabel!

    private var userIsTyping :Bool = false
    private var brain = CalculatorBrain()
    private var IsDecimal :Bool = false
    
    
    private var displayValue: Double {
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    private func displayInfo(){
        
        if brain.description != nil {
            if brain.isPartialResult{
                displayEquation.text = brain.description!
            } else {
                displayEquation.text = brain.description!
            }
        }
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        
        let digit = sender.currentTitle!
        
        
        
        if userIsTyping {
            let currentText = display.text!
            display.text = currentText + digit
        } else {
            display.text = digit
        }
        userIsTyping = true
        displayInfo()
    }
    
    @IBAction func touchDecimal() {
        if !IsDecimal {
        display.text = display.text! + "."
        IsDecimal = true
        }
        displayInfo()
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        
        if userIsTyping{
            brain.setOperand(operand: displayValue)
            userIsTyping = false
            IsDecimal = false
        }
        
        if let mathSymbol = sender.currentTitle{
                brain.performOperation(symbol: mathSymbol)
        }
        displayValue = brain.result
        displayInfo()
    }
    
}

