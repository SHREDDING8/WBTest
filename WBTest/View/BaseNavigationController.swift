//
//  BaseNavigationController.swift
//  WBTest
//
//  Created by SHREDDING on 23.09.2023.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationBar.prefersLargeTitles = true

    }
    
}
