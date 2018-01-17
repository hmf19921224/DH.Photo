//
//  ExtensionUIView.swift
//  DH.Photo
//
//  Created by 亚派 on 2018/1/16.
//  Copyright © 2018年 亚派. All rights reserved.
//

import Foundation
import UIKit
extension UIView{
    
    var originX:CGFloat {
        
        set{
            
            var  frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
        
        get{
            
            return self.frame.origin.x

            
        }
        
    }
    var originY:CGFloat {
        
        set{
            
            var  frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
        
        get{
            
            return self.frame.origin.y
            
            
        }
        
    }
    var SizeWidth:CGFloat {
        
        set{
            
            var  frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
        
        get{
            
            return self.frame.size.width
            
            
        }
        
    }
    var SizeHeight:CGFloat {
        
        set{
            
            var  frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
        
        get{
            
            return self.frame.size.height
            
            
        }
        
    }
    var Size:CGSize {
        
        set{
            
            var  frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
        
        get{
            
            return self.frame.size
            
            
        }
        
    }
    var centerX:CGFloat {
        
        set{
            
            center = CGPoint.init(x: newValue, y: center.y)
        }
        
        get{
            
            return center.x
            
        }
        
    }
    var centerY:CGFloat {
        
        set{
            var  center = self.center
            center.y = newValue
            self.center = center
        }
        
        get{
            
            return self.center.y
            
        }
        
    }
    
  
    
  
    
   

  func isShowOnWindow()->Bool
    {
    //主窗口
    let keyWindow = UIApplication.shared.keyWindow
    
    //相对于父控件转换之后的rect
    /*
 
 
         // 将像素point由point所在视图转换到目标视图view中，返回在目标视图view中的像素值
         - (CGPoint)convertPoint:(CGPoint)point toView:(UIView *)view;
         // 将像素point从view中转换到当前视图中，返回在当前视图中的像素值
         - (CGPoint)convertPoint:(CGPoint)point fromView:(UIView *)view;
         
         // 将rect由rect所在视图转换到目标视图view中，返回在目标视图view中的rect
         - (CGRect)convertRect:(CGRect)rect toView:(UIView *)view;
         // 将rect从view中转换到当前视图中，返回在当前视图中的rect
         - (CGRect)convertRect:(CGRect)rect fromView:(UIView *)view;
 
 */
        
        
    let newRect = keyWindow?.convert(self.frame, from: self.superview)
    //主窗口的bounds
    let winBounds = keyWindow?.bounds
    //判断两个坐标系是否有交汇的地方，返回bool值
        let  isIntersects =  winBounds?.intersects(newRect!)
        if self.isHidden != true && self.alpha > 0.01 && self.window == keyWindow && isIntersects! {
    
        return true
    }else{
        
    return false
    }
    }
    
   
   
    
    
}
