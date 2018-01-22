//
//  SelectPhotoViewController.swift
//  DH.Photo
//
//  Created by 亚派 on 2018/1/18.
//  Copyright © 2018年 亚派. All rights reserved.
//

import UIKit
import Photos

let ItemEdge:CGFloat = 5.0
let ItemWidth:CGFloat = (UIScreen.main.bounds.width - CGFloat(3) * ItemEdge)/4
class SelectPhotoViewController: UIViewController {
    var PhotoCollectionView:UICollectionView!
    
    var dataList:[PHAsset] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()

        // Do any additional setup after loading the view.
    }
    func initUI(){
        self.view.backgroundColor = UIColor.white
        let costomBar = UIView.init(frame: CGRect.init(x: 0, y: self.view.SizeHeight-49, width: self.view.SizeWidth, height: 49))
        self.view.addSubview(costomBar)
        let lab = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: costomBar.SizeWidth, height: 1))
        lab.backgroundColor = UIColor.lightGray
        costomBar.addSubview(lab)
        
        let updataBtn = UIButton.init(type: UIButtonType.custom)
        updataBtn.setImage(UIImage.init(named:"up"), for: UIControlState.normal)
        updataBtn.frame = CGRect.init(x: 0, y: 5, width: costomBar.SizeWidth/5, height: 39)
        updataBtn.addTarget(self, action: #selector(self.UpSelectDocument), for: UIControlEvents.touchUpInside)
        costomBar.addSubview(updataBtn)
            
        let downBtn = UIButton.init(type: UIButtonType.custom)
        downBtn.setImage(UIImage.init(named: "down"), for: UIControlState.normal)
        downBtn.frame = CGRect.init(x:updataBtn.MaxX, y: 5, width: costomBar.SizeWidth/5, height: 39)
        downBtn.addTarget(self, action: #selector(self.DownSelectDocument), for: UIControlEvents.touchUpInside)
        costomBar.addSubview(downBtn)

        let cameraBtn = UIButton.init(type: UIButtonType.custom)
        cameraBtn.setImage(UIImage.init(named: "camera"), for: UIControlState.normal)
        cameraBtn.frame = CGRect.init(x: downBtn.MaxX, y: 5, width: costomBar.SizeWidth/5, height: 39)
        cameraBtn.addTarget(self, action: #selector(self.jumpCamera), for: UIControlEvents.touchUpInside)
        costomBar.addSubview(cameraBtn)

        let EditBtn = UIButton.init(type: UIButtonType.custom)
        EditBtn.setImage(UIImage.init(named: "editor"), for: UIControlState.normal)
        EditBtn.frame = CGRect.init(x: cameraBtn.MaxX, y: 5, width: costomBar.SizeWidth/5, height: 39)
        EditBtn.addTarget(self, action: #selector(self.DocumentSetting), for: UIControlEvents.touchUpInside)
        costomBar.addSubview(EditBtn)

        let deleteBtn = UIButton.init(type: UIButtonType.custom)
        deleteBtn.setImage(UIImage.init(named: "trash"), for: UIControlState.normal)
        deleteBtn.frame = CGRect.init(x: EditBtn.MaxX, y: 5, width: costomBar.SizeWidth/5, height: 39)
        deleteBtn.addTarget(self, action: #selector(self.deleteDocument), for: UIControlEvents.touchUpInside)
        costomBar.addSubview(deleteBtn)
        
        let collectionlaout = UICollectionViewFlowLayout()
        collectionlaout.itemSize = CGSize.init(width: ItemWidth, height: ItemWidth)
        collectionlaout.minimumLineSpacing = ItemEdge
        collectionlaout.minimumInteritemSpacing = ItemEdge
        PhotoCollectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.SizeWidth, height: self.view.SizeHeight-49), collectionViewLayout: collectionlaout)
        PhotoCollectionView.backgroundColor = UIColor.white
        self.view.addSubview(PhotoCollectionView)
        
    }
    
    @objc func UpSelectDocument(){
        
        let alerVc = UIAlertController.init(title: nil, message: "导出照片", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        alerVc.addAction(UIAlertAction.init(title: "选中文件->已有文件夹", style: UIAlertActionStyle.default, handler: { (Action) in
            
        }))
        alerVc.addAction(UIAlertAction.init(title: "选中文件->系统相册", style: UIAlertActionStyle.default, handler: { (Action) in
            
        }))
        alerVc.addAction(UIAlertAction.init(title: "选中文件->电脑iTunes文件共享", style: UIAlertActionStyle.default, handler: { (Action) in
            
        }))
        alerVc.addAction(UIAlertAction.init(title: "选中照片->加密pdf发送邮件", style: UIAlertActionStyle.default, handler: { (Action) in
            
        }))
        alerVc.addAction(UIAlertAction.init(title: "选中文件->修复缩略图", style: UIAlertActionStyle.default, handler: { (Action) in
            
        }))
        alerVc.addAction(UIAlertAction.init(title: "AirDrop分享", style: UIAlertActionStyle.default, handler: { (Action) in
            
        }))
        alerVc.addAction(UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel, handler: { (Action) in
            
        }))
        self.present(alerVc, animated: true, completion: nil)
        
    }
    
    @objc func DownSelectDocument(){
        
        let alerVc = UIAlertController.init(title: nil, message: "导入照片", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        alerVc.addAction(UIAlertAction.init(title: "从系统相册导入", style: UIAlertActionStyle.default, handler: { (Action) in
            
            let vc =  AllPhotoViewController()
            //设置选择完毕后的回调

            vc.completeHandler = { (PHasset) in
                
                self.dataList = PHasset
                
                self.PhotoCollectionView.reloadData()
            }
            //将图片选择视图控制器外添加个导航控制器，并显示
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        }))
        
        alerVc.addAction(UIAlertAction.init(title: "从iTunes导入", style: UIAlertActionStyle.default, handler: { (Action) in
            
        }))
        alerVc.addAction(UIAlertAction.init(title: "从WiFi导入", style: UIAlertActionStyle.default, handler: { (Action) in
            
        }))
        
        alerVc.addAction(UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel, handler: { (Action) in
            
        }))
        self.present(alerVc, animated: true, completion: nil)

    }
    
    @objc func jumpCamera(){
    
    
    }
    
    @objc func DocumentSetting(){

    }
    @objc func deleteDocument(){
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//    }
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        
        return true
    }
   
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        
        let  cell = collectionView.cellForItem(at: indexPath)
        //设置(Highlight)高亮下的颜色
        
        if #available(iOS 11.0, *) {
            cell?.backgroundColor = UIColor.init(named: "f2f2f2")
        } else {
            // Fallback on earlier versions
        }
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let  cell = collectionView.cellForItem(at: indexPath)
        //设置(Nomal)正常状态下的颜色
        cell?.backgroundColor = UIColor.white

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
