//
//  UIBarButtonItem.swift
//  DYZB
//
//  Created by 阿鲍 on 16/11/4.
//  Copyright © 2016年 abble. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(imageName : String, highImageName : String = "", size : CGSize = CGSize.zero) {
        
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: UIControlState())
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        self.init(customView : btn)
    }
}
