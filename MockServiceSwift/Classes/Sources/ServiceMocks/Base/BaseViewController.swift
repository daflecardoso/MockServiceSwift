//
//  BaseViewController.swift
//  Alamofire
//
//  Created by Dafle on 01/10/21.
//

import Foundation
import UIKit

public class BaseViewController: UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            navigationItem.backButtonTitle = ""
        } else {
            // Fallback on earlier versions
        }
    }
}
