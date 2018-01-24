//
//  NormalCollectionViewCell.swift
//  DH.Photo
//
//  Created by 亚派 on 2018/1/23.
//  Copyright © 2018年 亚派. All rights reserved.
//

import UIKit

class NormalCollectionViewCell: UICollectionViewCell {
  
    var PhotoImageview:UIImageView!
   var maskImageView:UIImageView!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.PhotoImageview = UIImageView.init(frame: self.bounds)
        self.addSubview(self.PhotoImageview)
        self.maskImageView =  UIImageView.init(frame:self.bounds)
        maskImageView.image =  UIImage.init(named: "Overlay")
        self.addSubview(self.maskImageView)
        maskImageView.isHidden = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 open override var isSelected: Bool {
        didSet{
            if isSelected {
                
                self.maskImageView.isHidden = false
            
            }else{
                
                self.maskImageView.isHidden = true
                
            }
        }
    }
}
