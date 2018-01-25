//
//  ScrollViewController.swift
//  DH.Photo
//
//  Created by 亚派 on 2018/1/23.
//  Copyright © 2018年 亚派. All rights reserved.
//

import UIKit
import Photos
import SnapKit
class ScrollViewController: UIViewController,UIScrollViewDelegate {
    lazy var offset:CGFloat = {
        
      return  CGFloat(self.JumpIndex) * self.view.SizeWidth
    }()
    var PhotoScrollView:UIScrollView!
    var dataList:[PHAsset] = []
    var JumpIndex:NSInteger!
    var isStatusBarHidden = false
    var imageManager :PHCachingImageManager =  PHCachingImageManager()
    var  titlepage:UIButton!
    var shareBtn:UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shareBtn = UIButton.init(type: UIButtonType.custom)
        shareBtn.frame = CGRect.init(x: 0, y: 0, width: 35, height: 35)
        shareBtn.setImage(UIImage.init(named: "share"), for: UIControlState.normal)
        shareBtn.setImage(UIImage.init(named: "share_fill"), for: UIControlState.highlighted)
        shareBtn.addTarget(self, action: #selector(self.shareclick), for: UIControlEvents.touchUpInside)
        let RightItem = UIBarButtonItem.init(customView: shareBtn)
        self.navigationItem.rightBarButtonItem = RightItem
        
        titlepage = UIButton.init(type: UIButtonType.custom)
        self.navigationController?.toolbar.layoutIfNeeded()
        self.navigationController!.toolbar.addSubview(titlepage)
        titlepage.setTitle("设为登陆图片", for: UIControlState.normal)
        titlepage.setTitleColor(UIColor.blue, for: UIControlState.normal)
        titlepage.snp.makeConstraints { (make) in
            make.center.equalTo((self.navigationController?.toolbar)!)
            make.height.equalTo(self.navigationController!.toolbar)
        }
        titlepage.addTarget(self, action: #selector(setPagetitle), for: UIControlEvents.touchDragInside)
        title = String(JumpIndex+1)+"/"+String(dataList.count)
        self.view.backgroundColor = UIColor.black
        PhotoScrollView = UIScrollView()
        PhotoScrollView.delegate = self
        PhotoScrollView.isPagingEnabled = true
        self.view.addSubview(PhotoScrollView)
        PhotoScrollView.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.width.equalTo(self.view.snp.width)
            make.height.equalTo(self.view.snp.width)
        }
        if #available(iOS 11.0, *) {
            
            self.PhotoScrollView.contentInsetAdjustmentBehavior = .never
        } else {
            
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        
        var lastImageview:UIImageView!
        for i in 0..<dataList.count
        {
            let asset = dataList[i]
            let imageView = UIImageView()
            imageView.backgroundColor = UIColor.white
            imageView.isUserInteractionEnabled = true
            let tapGester = UITapGestureRecognizer.init(target: self, action: #selector(self.Imageclick))
            imageView.addGestureRecognizer(tapGester)
            self.imageManager.requestImage(for: dataList[i], targetSize: CGSize.init(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .aspectFill, options: nil) { (image, nfo) in
                imageView.image = image
            }
            self.PhotoScrollView.addSubview(imageView)
            self.PhotoScrollView.showsHorizontalScrollIndicator = false
            imageView.snp.makeConstraints({ (make) in
                make.top.equalTo(self.PhotoScrollView)
                make.size.equalTo(self.PhotoScrollView)
                if lastImageview != nil{
                    
                    make.left.equalTo(lastImageview.snp.right)
                }else{
                    make.left.equalTo(self.PhotoScrollView)

                }
                if i == dataList.count-1{
                    
                    make.right.equalTo(self.PhotoScrollView)
                    
                }
            })
           lastImageview = imageView
       
        }
        PhotoScrollView.setContentOffset(CGPoint.init(x: self.view.SizeWidth * CGFloat(JumpIndex), y: 0), animated: false)

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.isStatusBarHidden = true
        self.setNeedsStatusBarAppearanceUpdate()
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    
   @objc func shareclick(){
        
        
        
        
        
    }
    @objc func setPagetitle(){
        
        
        
        
        
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            
            self.scrollViewDidEndDecelerating(scrollView)
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        print("\(offset)---\(scrollView.contentOffset.x)---\(self.view.SizeWidth)")
        
        let  swipe = Int((scrollView.contentOffset.x - offset)/self.view.SizeWidth)
        self.title = String(JumpIndex+1+swipe)+"/"+String(dataList.count)
    }
    
    override var prefersStatusBarHidden: Bool {
        
        return self.isStatusBarHidden
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func Imageclick(){
    let navBarState = self.navigationController?.isNavigationBarHidden//获取当前的导航栏是否隐藏
        self.navigationController?.setNavigationBarHidden(!navBarState!, animated: true)
        self.navigationController?.setToolbarHidden(!navBarState!,animated:true)
        if !navBarState! {
            
            self.isStatusBarHidden = true
            self.setNeedsStatusBarAppearanceUpdate()

    }else {
        
            self.isStatusBarHidden = false
            self.setNeedsStatusBarAppearanceUpdate()
    }
}
   

}
