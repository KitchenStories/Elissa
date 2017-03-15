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
    
    private var elissa: Elissa?
    
    private var elissaConfiguration: ElissaConfiguration {
        let elissaConfig = ElissaConfiguration()
        elissaConfig.message = "Find your favorites here"
        elissaConfig.image = UIImage(named: "heartIcon")
        elissaConfig.font = UIFont.systemFont(ofSize: 17)
        elissaConfig.textColor = UIColor(red: 91/255, green: 91/255, blue: 91/255, alpha: 1.0)
        elissaConfig.backgroundColor = UIColor(red: 241/255, green: 215/255, blue: 85/255, alpha: 1.0)
        return elissaConfig
    }

    @IBOutlet weak var elissaSwitch: UISwitch!
    @IBOutlet weak var someActionButton: UIButton!
    @IBOutlet weak var configLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        someActionButton.backgroundColor = .clear
        someActionButton.layer.cornerRadius = 5
        someActionButton.layer.borderWidth = 1
        someActionButton.layer.borderColor = someActionButton.tintColor.cgColor
        someActionButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 25, bottom: 10, right: 25)
        
        elissaSwitch.onTintColor = someActionButton.tintColor
        
        configLabel.textColor = .darkGray
        configLabel.text = "Present from Tabbar"
        
        elissaSwitch.setOn(true, animated: false)
    }
    
    @IBAction func someActionTrigger(sender: UIButton) {
        
        if elissaSwitch.isOn {
            presentFromTabBar()
        } else {
            presentFrom(anchorView: sender)
        }
    }
    
    @IBAction func didChangeSwitch(_ sender: Any) {
        if elissaSwitch.isOn {
            configLabel.text = "Present from Tabbar"
        } else {
            configLabel.text = "Present from anchor view"
        }
    }
    
    private func presentFromTabBar() {
        showElissaFromTabbar(at: 4, configuration: elissaConfiguration) {
            Elissa.dismiss()
        }
    }
    
    private func presentFrom(anchorView: UIView) {
        if let elissa = elissa {
            elissa.removeFromSuperview()
        }
        
        elissa = view.showElissa(fromSourceView: anchorView, configuration: elissaConfiguration) { [unowned self] in
            self.elissa?.removeFromSuperview()
        }
    }
}
