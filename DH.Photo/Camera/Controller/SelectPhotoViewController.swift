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
let ItemSPace:CGFloat = 5.0


let ItemWidth:CGFloat = (UIScreen.main.bounds.width - CGFloat(5) * ItemEdge)/4
class SelectPhotoViewController: UIViewController {
    var PhotoCollectionView:UICollectionView!
    var imageManager:PHCachingImageManager!

    var dataList:[PHAsset] = []
    

    var assetGridThumbnailSize:CGSize!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //根据单元格的尺寸计算我们需要的缩略图大小
        let scale = UIScreen.main.scale

        let cellSize = (self.PhotoCollectionView.collectionViewLayout as!
            UICollectionViewFlowLayout).itemSize
        
        assetGridThumbnailSize = CGSize(width: cellSize.width*scale ,
                                        height: cellSize.height*scale)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        self.navigationController?.navigationBar.isTranslucent = false
        self.imageManager = PHCachingImageManager()

    }
    func initUI(){
        print(self.view.SizeHeight)
        self.view.backgroundColor = UIColor.white
        let costomBar = UIView.init(frame: CGRect.init(x: 0, y: self.view.SizeHeight-49-64, width: self.view.SizeWidth, height: 49))
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
        collectionlaout.minimumLineSpacing = ItemSPace
        collectionlaout.minimumInteritemSpacing = ItemSPace
        collectionlaout.sectionInset = UIEdgeInsetsMake(ItemEdge, ItemEdge, ItemEdge, ItemEdge)
        PhotoCollectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.SizeWidth, height: self.view.SizeHeight-49-64), collectionViewLayout: collectionlaout)
        PhotoCollectionView.register(NormalCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        PhotoCollectionView.delegate = self
        PhotoCollectionView.dataSource = self
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
                print("count\(self.dataList.count)")
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
    

   
    
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension SelectPhotoViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataList.count
    }
    
    // 获取单元格
    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //获取storyboard里设计的单元格，不需要再动态添加界面元素
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",for: indexPath) as! NormalCollectionViewCell
        let asset = self.dataList[indexPath.row]
        //获取缩略图
        self.imageManager.requestImage(for: asset, targetSize: assetGridThumbnailSize,
                                       contentMode: .aspectFill, options: nil) {
                                        (image, nfo) in
                                cell.PhotoImageview.image = image
        }
        
        return cell
    }
    
    //单元格选中响应
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
      let scrollview = ScrollViewController()
        
        scrollview.dataList = self.dataList
        scrollview.JumpIndex = indexPath.row
        self.navigationController?.pushViewController(scrollview, animated: true)
        

        
    }
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {

        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
     
        
    }
    
}
