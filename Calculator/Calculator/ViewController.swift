//
//  ViewController.swift
//  Calculator
//
//  Created by Ping-Ying Yen on 2016/11/10.
//  Copyright © 2016年 Ping-Ying Yen. All rights reserved.
//

import UIKit

extension Double {
    fileprivate var displayString: String {
        let floor = self.rounded(.towardZero)
        let isInteger = self.distance(to: floor).isZero
        
        let string = String(self)
        if isInteger {
            if let indexOfDot = string.characters.index(of: ".") {
                return string.substring(to: indexOfDot)
            }
        }
        return String(self)
    }
}


class ViewController: UIViewController {
    
    var core = Core<Double>()
    
    @IBOutlet weak var displayLabel: UILabel!
    
    // Input
    @IBAction func numericButtonClicked(_ sender: UIButton) {
        let digit = sender.tag - 1000
        let currentText = self.displayLabel.text ?? "0"
        if currentText == "0"{
            self.displayLabel.text = "\(digit)"
        } else{
            self.displayLabel.text = currentText + String(digit)
        }
    }
    
    @IBAction func dotButtonClicked(_ sender: UIButton) {
        let currentText = self.displayLabel.text ?? "0"
        guard !currentText.contains(".") else {
            return
        }
        self.displayLabel.text = currentText + "."
    }
    
    @IBAction func clearButtonClicked(_ sender: UIButton) {
        self.displayLabel.text = "0"
        self.core = Core<Double>()
    }
    
    // Actions
    @IBAction func operatorButtonClicked(_ sender: UIButton) {
        let currentText = self.displayLabel.text ?? "0"
        let currentNumber = Double(currentText)!
        try! self.core.addStep(currentNumber)
        
        if sender.tag == 1100{  // Add
            try! self.core.addStep(+)
        }else if sender.tag == 1101{  // Subtract
            try! self.core.addStep(-)
        }else if sender.tag == 1102{  // Multiply
            try! self.core.addStep(*)
        }else if sender.tag == 1103{  // Divid
            try! self.core.addStep(/)
        }
        self.displayLabel.text = "0"
    }
    
    @IBAction func percentButtonClicked(_ sender: UIButton) {
        let currentText = self.displayLabel.text ?? "0"
        var currentNumber = Double(currentText)!
        currentNumber *= 0.01
        self.displayLabel.text = String(currentNumber)
    }

    @IBAction func positiveNegativeButtonClicked(_ sender: UIButton) {
        let currentText = self.displayLabel.text ?? "0"
        var currentNumber = Double(currentText)!
        currentNumber = -currentNumber
        self.displayLabel.text = String(currentNumber)
    }
    
    @IBAction func equalButtonClicked(_ sender: UIButton) {
        let currentText = self.displayLabel.text ?? "0"
        let currentNumber = Double(currentText)!
        try! self.core.addStep(currentNumber)
        
        let result = self.core.calculate()!
        self.displayLabel.text = "\(result)"
        self.core = Core<Double>()
    }

    
}

