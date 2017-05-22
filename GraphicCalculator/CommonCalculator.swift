//
//  FirstViewController.swift
//  GraphicCalculator
//
//  Created by Apple on 2017/5/20.
//  Copyright © 2017年 NJU. All rights reserved.
//

import UIKit

class CommonCalculatorViewController: UIViewController {
    
    @IBOutlet weak var ExpressionMonitor: UILabel!
    @IBOutlet weak var ResultMonitor: UILabel!
    
    @IBAction func PerformAction(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.hidesBottomBarWhenPushed=true
        //self.tabBarController?.tabBar.isHidden=true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func panView(sender: UIPanGestureRecognizer){
        
    }

    
}

