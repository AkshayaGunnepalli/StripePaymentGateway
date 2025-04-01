//
//  ViewController.swift
//  StripeSwiftPackage
//
//  Created by Akshaya Gunnepalli on 01/04/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func showStripe() {
        let clientScrete = ""
        DispatchQueue.main.async {
            StripePayment.shared.initiate(from: self) { error, response  in
                if error == nil && response != nil {
                   print("success")
                }
            }
        }
    }

}

