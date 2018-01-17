//
//  DHTabBar.swift
//  DH.Photo
//
//  Created by 亚派 on 2018/1/11.
//  Copyright © 2018年 亚派. All rights reserved.
//

import UIKit

@objc protocol DHTabBarDelegate:NSObjectProtocol {
    
    @objc optional func tabBarPlusBtnClick(tabbar:UITabBar)->Void
}

class DHTabBar: UITabBar {

    
    weak var mydelegate:DHTabBarDelegate?
    var plusbtn:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.shadowImage = UIImage.createImageWithColor(color: UIColor.clear)
        plusbtn = UIButton()
        plusbtn.setBackgroundImage(UIImage.init(named: "post_normal"), for: UIControlState.normal)
        plusbtn.setBackgroundImage(UIImage.init(named: "post_normal"), for: UIControlState.highlighted)
        plusbtn.addTarget(self, action: #selector(self.plusBtnDidClick), for: UIControlEvents.touchUpInside)
        self.addSubview(plusbtn)
    }
    @objc func plusBtnDidClick()
    {
    //如果tabbar的代理实现了对应的代理方法，那么就调用代理的该方法
    if self.delegate != nil {
        self.mydelegate?.tabBarPlusBtnClick!(tabbar: self)
        
        }
    
    }
    
    override func layoutSubviews()
    {
    super.layoutSubviews()
    //系统自带的按钮类型是UITabBarButton，找出这些类型的按钮，然后重新排布位置，空出中间的位置
        //调整发布按钮的中线点Y值

    let  Barclass = NSClassFromString("UITabBarButton")
        
        self.plusbtn.Size = CGSize.init(width: (self.plusbtn.currentBackgroundImage?.size.width)!, height: (self.plusbtn.currentBackgroundImage?.size.height)!)

        self.plusbtn.centerX = self.centerX
        print(self.centerX,self.centerX)
        
        self.plusbtn.centerY = self.SizeHeight/2-2*10
        print(self.plusbtn.centerY)
        
        let label = UILabel()
        label.text = "发布";
        label.font = UIFont.systemFont(ofSize: 11)
        label.sizeToFit()
        label.textColor = UIColor.gray
        self.addSubview(label)
        label.centerX = self.plusbtn.centerX
        label.centerY = self.plusbtn.frame.maxY + 10 ;
        
        var  btnIndex = 0;
        for btn in self.subviews {//遍历tabbar的子控件
            if btn.isKind(of: Barclass!) {//如果是系统的UITabBarButton，那么就调整子控件位置，空出中间位置
                //每一个按钮的宽度==tabbar的五分之一
                btn.SizeWidth = self.SizeWidth / 5;
                
                btn.originX = btn.SizeWidth * CGFloat(btnIndex)
                
                btnIndex+=1
                //如果是索引是2(从0开始的)，直接让索引++，目的就是让消息按钮的位置向右移动，空出来发布按钮的位置
                if btnIndex == 2 {
                    btnIndex+=1
                }
                
            }
        }
        
        self.bringSubview(toFront: self.plusbtn)
        
    }
    


    //这一个判断是关键，不判断的话push到其他页面，点击发布按钮的位置也是会有反应的，这样就不好了
    //self.isHidden == NO 说明当前页面是有tabbar的，那么肯定是在导航控制器的根控制器页面
    //在导航控制器根控制器页面，那么我们就需要判断手指点击的位置是否在发布按钮身上
    //是的话让发布按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        if self.isHidden == false {
            let newp = self.convert(point, to: self.plusbtn)
            
            if self.plusbtn.point(inside: newp, with: event){
            return self.plusbtn
            }else
            {
            
            return super.hitTest(point, with: event)
            }
        }else{
            
            return super.hitTest(point, with: event)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
