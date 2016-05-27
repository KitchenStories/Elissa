//
//  ViewController.swift
//  Elissa
//
//  Created by Kersten Broich on 05/25/2016.
//  Copyright (c) 2016 Kersten Broich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var someActionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func someActionTrigger(sender: UIButton) {
        
        print("show elissa")
    }

}

