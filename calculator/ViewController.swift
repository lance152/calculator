//
//  ViewController.swift
//  calculator
//
//  Created by Lance Fan on 16/6/29.
//  Copyright © 2016年 Lance Fan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    
    @IBAction func append(sender: UIButton) {
        let digit = sender.currentTitle!
        display.text = display.text! + digit
    }
}

