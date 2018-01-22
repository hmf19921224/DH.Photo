//
//  PhotoShowListCell.swift
//  DH.Photo
//
//  Created by 亚派 on 2018/1/19.
//  Copyright © 2018年 亚派. All rights reserved.
//

import UIKit

class PhotoShowListCell: UICollectionViewCell {

    @IBOutlet weak var selectedIcon: UIImageView!
    @IBOutlet weak var PhotoImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        PhotoImageView.contentMode = .scaleAspectFill
        PhotoImageView.clipsToBounds = true
        // Initialization code
    }
    open override var isSelected: Bool {
        didSet{
            if isSelected {
                selectedIcon.image = UIImage(named: "success")
            }else{
                selectedIcon.image = UIImage(named: "success_fill")
            }
        }
    }

    //播放动画，是否选中的图标改变时使用
    func playAnimate() {
        //图标先缩小，再放大
        UIView.animateKeyframes(withDuration: 0.4, delay: 0, options: .allowUserInteraction,
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2,
                                                       animations: {
                                                        self.selectedIcon.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                                    })
                                    UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.4,
                                                       animations: {
                                                        self.selectedIcon.transform = CGAffineTransform.identity
                    })
        }, completion: nil)
    }
}
