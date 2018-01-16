//
//  ExtensionImage.swift
//  ProvinceHospital
//
//  Created by 亚派 on 2018/1/5.
//  Copyright © 2018年 亚派. All rights reserved.
//

import Foundation
import UIKit
extension UIImage{
    
    class func  createImageWithColor(color:UIColor)->UIImage{
        
       
        //开启图形上下文

        let rect = CGRect.init(x: 0, y: 0, width: 1, height: 1)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        //获得图形上下文
       let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        //渲染上下文

        context!.fill(rect);
        let heImage = UIGraphicsGetImageFromCurrentImageContext()
        //关闭图形上下文

        UIGraphicsEndImageContext()
        return heImage!
        
    }
    
}
