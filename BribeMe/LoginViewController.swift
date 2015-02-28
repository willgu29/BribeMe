//
//  LoginViewController.swift
//  BribeMe
//
//  Created by William Gu on 2/27/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login() {
        var bribesVC = BribesViewController(nibName: "BribesViewController", bundle: nil);
        self.presentViewController(bribesVC, animated: true, completion: nil);
    }
    
    @IBAction func createAccount() {
        
    }

}
