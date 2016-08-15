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
        
        var elissaConfig = ElissaConfiguration()
        elissaConfig.message = "Find it here or there"
        elissaConfig.image = UIImage(named: "heartIcon") ?? UIImage()
        elissaConfig.backgroundColor = UIColor.redColor()
        
        showElissaFromTabbar(itemIndex: 4, configuration: elissaConfig) { [weak self] in
            self?.dismissElissa()
        }
    }

}
