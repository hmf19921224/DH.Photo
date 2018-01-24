//
//  AllPhotoViewController.swift
//  DH.Photo
//
//  Created by 亚派 on 2018/1/19.
//  Copyright © 2018年 亚派. All rights reserved.
//

import UIKit
import Photos




class AllPhotoViewController: UIViewController {
    //下方工具栏
    var collectionView:UICollectionView!
    //带缓存的图片管理对象
    var imageManager:PHCachingImageManager!
    //下方工具栏
    var toolBar:UIToolbar!
    //缩略图大小
    var assetGridThumbnailSize:CGSize!
    //相薄列表集合
    var items:[PHAsset] = []

    //每次最多可选择的照片数量
    var maxSelected:Int = Int.max
    
    //照片选择完毕后的回调
    var completeHandler:((_ assets:[PHAsset])->Void)?
    
    //完成按钮
    var completeButton:HGImageCompleteButton!
    
    //全选按钮
    var selectAllBtn:UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //根据单元格的尺寸计算我们需要的缩略图大小
        let scale = UIScreen.main.scale
        
        let cellSize = (self.collectionView.collectionViewLayout as!
            UICollectionViewFlowLayout).itemSize
        
        assetGridThumbnailSize = CGSize(width: cellSize.width*scale ,
                                        height: cellSize.height*scale)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "所有照片"
        self.imageManager = PHCachingImageManager()
        self.resetCachedAssets()
        let RightBtn = UIButton.init(type: UIButtonType.custom)
        RightBtn.setTitle("取消", for: UIControlState.normal)
        RightBtn.addTarget(self, action: #selector(self.cancel), for: UIControlEvents.touchUpInside)
        RightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        RightBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        RightBtn.frame = CGRect.init(x: 0, y: 0, width: 35, height: 35)
        let RightNavibtn = UIBarButtonItem.init(customView: RightBtn)
        self.navigationItem.rightBarButtonItem = RightNavibtn
 
  
        let collectionlaout = UICollectionViewFlowLayout()
        //允许多选
        collectionlaout.itemSize = CGSize.init(width: ItemWidth, height: ItemWidth)
        collectionlaout.minimumInteritemSpacing = ItemSPace
        collectionlaout.sectionInset = UIEdgeInsetsMake(ItemEdge, ItemEdge, ItemEdge, ItemEdge)
        
        collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.SizeWidth, height: self.view.SizeHeight-49-64), collectionViewLayout: collectionlaout)
        collectionView.register(UINib.init(nibName: "PhotoShowListCell", bundle: nil), forCellWithReuseIdentifier: "Photocell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
        collectionView.backgroundColor = UIColor.white
        self.view.addSubview(collectionView)
        
        
        toolBar =  UIToolbar.init(frame: CGRect.init(x: 0, y: self.view.SizeHeight-49-64, width: self.view.SizeWidth, height: 49))
        toolBar.backgroundColor = UIColor.white
        self.view.addSubview(toolBar)
        toolBar.layoutIfNeeded()

        completeButton = HGImageCompleteButton()
        completeButton.addTarget(target: self, action: #selector(finishSelect))
        completeButton.center = CGPoint(x: UIScreen.main.bounds.width - 50, y: 22)
        completeButton.isEnabled = false

        self.toolBar.addSubview(completeButton)
        

        selectAllBtn = UIButton.init(type: UIButtonType.custom)
        selectAllBtn.setTitleColor( UIColor.gray, for: UIControlState.normal)
        selectAllBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        selectAllBtn.setTitle("全选", for: UIControlState.normal)
        selectAllBtn.setTitle("取消全选", for: UIControlState.highlighted)
        selectAllBtn.addTarget(self, action: #selector(checktAll), for: UIControlEvents.touchUpInside)
        selectAllBtn.frame = CGRect.init(x: 15, y: 12, width: 40, height: 20)
       
        toolBar.layoutIfNeeded()

        self.toolBar.addSubview(selectAllBtn)

        PHPhotoLibrary.requestAuthorization({ (status) in
            if status != .authorized {
                return
            }
            // 列出所有系统的智能相册
            let smartOptions = PHFetchOptions()
            let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum,
                                                                      subtype: .albumRegular,
                                                                      options: smartOptions)
            self.convertCollection(collection: smartAlbums)
            
//            //列出所有用户创建的相册
//            let userCollections = PHCollectionList.fetchTopLevelUserCollections(with: nil)
//            self.convertCollection(collection: userCollections
//                as! PHFetchResult<PHAssetCollection>)
            
            //异步加载表格数据,需要在主线程中调用reloadData() 方法
            DispatchQueue.main.async{
                
                self.collectionView.reloadData()
                
            }
        })

    }
    
    private func convertCollection(collection:PHFetchResult<PHAssetCollection>){
        
        for i in 0..<collection.count{
            //获取出但前相簿内的图片
            let resultsOptions = PHFetchOptions()
            resultsOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate",
                                                               ascending: false)]
            
            resultsOptions.predicate = NSPredicate(format: "mediaType = %d",
                                                   PHAssetMediaType.image.rawValue)
            let c = collection[i]
            let assetsFetchResult = PHAsset.fetchAssets(in: c , options: resultsOptions)
            //没有图片的空相簿不显示
            if assetsFetchResult.count > 0 {
                assetsFetchResult.enumerateObjects({ (asset, index, stop) in
                    if !self.items.contains(asset){
                        
                        self.items.append(asset)

                    }
                })
            }
        }
    }
    

    //重置缓存
    func resetCachedAssets(){
        
        self.imageManager.stopCachingImagesForAllAssets()
    }
    
    //点击完成按钮
    @objc func finishSelect(){
        
        var assets:[PHAsset] = []
        if let indexPaths = self.collectionView.indexPathsForSelectedItems{
            for indexPath in indexPaths{
                
                assets.append(items[indexPath.row])
            }
        }
        self.completeHandler!(assets)
        print("确定")
        self.navigationController?.popViewController(animated: true)

    }
    
    //全选按钮
    @objc func checktAll(sender:UIButton) {
        
        sender.isSelected = !sender.isSelected
        for indexPath in self.collectionView.indexPathsForVisibleItems{
            
            if sender.isSelected {
                
              self.collectionView(collectionView, didSelectItemAt: indexPath)
            }else
            {
                
                self.collectionView(collectionView, didDeselectItemAt: indexPath)
                
            }
            
        }
        let count = self.selectedCount()
        
        sender.isSelected = !sender.isSelected
        completeButton.num = count
        //改变完成按钮数字，并播放动画
        if count == 0{
            completeButton.isEnabled = false
        }
        
       if count > 0 && !self.completeButton.isEnabled{
            completeButton.isEnabled = true
        }
        
            
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //取消按钮点击

   @objc func cancel(){
        
        //退出当前视图控制器
        self.navigationController?.popViewController(animated: true)
    
    }
    
    //获取已选择个数
    func selectedCount() -> Int {
        return self.collectionView.indexPathsForSelectedItems?.count ?? 0
    }

}

//图片缩略图集合页控制器UICollectionViewDataSource,UICollectionViewDelegate协议方法的实现
extension AllPhotoViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.items.count
    }
    
    // 获取单元格
    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //获取storyboard里设计的单元格，不需要再动态添加界面元素
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Photocell",for: indexPath) as! PhotoShowListCell
        let asset = self.items[indexPath.row]
        //获取缩略图
        self.imageManager.requestImage(for: asset, targetSize: assetGridThumbnailSize,
                                       contentMode: .aspectFill, options: nil) {
                                        (image, nfo) in
                            cell.PhotoImageView.image = image
        }
        
        return cell
    }
    
    //单元格选中响应
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath)
            as? PhotoShowListCell{
            //获取选中的数量
            let count = self.selectedCount()
            
                //如果不超过最大选择数
                //改变完成按钮数字，并播放动画
                completeButton.num = count
                if count > 0 && !self.completeButton.isEnabled{
                    completeButton.isEnabled = true
                }
                cell.playAnimate()
        }
    }
    //单元格取消选中响应
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? PhotoShowListCell{
            //获取选中的数量
            let count = self.selectedCount()
            completeButton.num = count
            //改变完成按钮数字，并播放动画
            if count == 0{
                completeButton.isEnabled = false
            }
            cell.playAnimate()
        }
    }
}





