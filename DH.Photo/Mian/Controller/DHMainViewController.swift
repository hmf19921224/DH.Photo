//
//  DHMainViewController.swift
//  DH.Photo
//
//  Created by 亚派 on 2018/1/11.
//  Copyright © 2018年 亚派. All rights reserved.
//

import UIKit

class DHMainViewController: UITabBarController,DHTabBarDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBarItem = UITabBarItem.appearance(whenContainedInInstancesOf: [DHMainViewController.self])
        
        var dictNormal:[NSAttributedStringKey : Any] = [:]
        dictNormal[NSAttributedStringKey.foregroundColor] = UIColor.gray
        dictNormal[NSAttributedStringKey.font] = UIFont.systemFont(ofSize: 11)
        
        var dictSelected : [NSAttributedStringKey : Any] = [:]
        dictSelected[NSAttributedStringKey.backgroundColor] = UIColor.darkGray
        dictSelected[NSAttributedStringKey.font] = UIFont.systemFont(ofSize: 11)
        tabBarItem.setTitleTextAttributes(dictNormal, for: UIControlState.normal)
        tabBarItem.setTitleTextAttributes(dictSelected, for: UIControlState.selected)
       let tabbar = DHTabBar()
        tabbar.mydelegate = self
        //kvc实质是修改了系统的_tabBar
        self.setValue(tabbar, forKeyPath: "tabBar")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tabBarPlusBtnClick(tabbar: UITabBar) {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
