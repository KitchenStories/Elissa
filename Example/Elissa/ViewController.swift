//
//  ViewController.swift
//  Elissa
//
//  Created by Kersten Broich on 05/25/2016.
//  Copyright (c) 2016 Kersten Broich. All rights reserved.
//

import UIKit
import Elissa

class ViewController: UIViewController {

    @IBOutlet weak var someActionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func someActionTrigger(sender: UIButton) {
        
        let elissaConfig = ElissaConfiguration()
        elissaConfig.message = "Find your favorites here"
        elissaConfig.image = UIImage(named: "heartIcon")
        elissaConfig.font = UIFont.systemFont(ofSize: 17)
        elissaConfig.textColor = UIColor(red: 91/255, green: 91/255, blue: 91/255, alpha: 1.0)
        elissaConfig.backgroundColor = UIColor(red: 241/255, green: 215/255, blue: 85/255, alpha: 1.0)
        
        showElissaFromTabbar(at: 4, configuration: elissaConfig) {            
            Elissa.dismiss()
        }
    }
}
