//
//  DropDownButton.swift
//  ReportList
//
//  Created by Naresh kumar Nagulavancha on 3/30/19.
//  Copyright © 2019 Naresh kumar Nagulavancha. All rights reserved.
//

import Foundation


import UIKit

class DropDownButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        
    }
}
