//
//  SelectPhotoViewController.swift
//  DH.Photo
//
//  Created by 亚派 on 2018/1/18.
//  Copyright © 2018年 亚派. All rights reserved.
//

import UIKit

class SelectPhotoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()

        // Do any additional setup after loading the view.
    }
    func initUI(){
        
        let costomBar = UIView.init(frame: CGRect.init(x: 0, y: self.view.SizeHeight-49, width: self.view.SizeWidth, height: 49))
        let updataBtn = UIButton.init(type: UIButtonType.custom)
        updataBtn.setImage(UIImage.init(named: "up"), for: UIControlState.normal)
        updataBtn.frame = CGRect.init(x: 0, y: 5, width: costomBar.SizeWidth/5, height: 39)
        costomBar.addSubview(updataBtn)
            
        let downBtn = UIButton.init(type: UIButtonType.custom)
        updataBtn.setImage(UIImage.init(named: "down"), for: UIControlState.normal)
        updataBtn.frame = CGRect.init(x:updataBtn.MaxX, y: 5, width: costomBar.SizeWidth/5, height: 39)
        costomBar.addSubview(downBtn)

        let cameraBtn = UIButton.init(type: UIButtonType.custom)
        cameraBtn.setImage(UIImage.init(named: "camera"), for: UIControlState.normal)
        cameraBtn.frame = CGRect.init(x: downBtn.MaxX, y: 5, width: costomBar.SizeWidth/5, height: 39)
        costomBar.addSubview(cameraBtn)

        let EditBtn = UIButton.init(type: UIButtonType.custom)
        EditBtn.setImage(UIImage.init(named: "describe"), for: UIControlState.normal)
        EditBtn.frame = CGRect.init(x: cameraBtn.MaxX, y: 5, width: costomBar.SizeWidth/5, height: 39)
        costomBar.addSubview(EditBtn)

        let deleteBtn = UIButton.init(type: UIButtonType.custom)
        deleteBtn.setImage(UIImage.init(named: "delete"), for: UIControlState.normal)
        deleteBtn.frame = CGRect.init(x: EditBtn.MaxX, y: 5, width: costomBar.SizeWidth/5, height: 39)
        costomBar.addSubview(deleteBtn)

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
