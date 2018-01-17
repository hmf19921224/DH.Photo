//
//  ListViewCell.swift
//  DH.Photo
//
//  Created by 亚派 on 2018/1/17.
//  Copyright © 2018年 亚派. All rights reserved.
//

import UIKit

class ListViewCell: UITableViewCell {

    @IBOutlet weak var PhtotoCountLab: UILabel!
    @IBOutlet weak var DocumentNameLab: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func draw(_ rect: CGRect) {
        let cont = UIGraphicsGetCurrentContext()
        cont?.setStrokeColor(UIColor.gray.cgColor)
        cont?.setLineWidth(1)
        cont?.setLineDash(phase: 0, lengths: [2,2])
        cont?.beginPath()
        cont?.move(to: CGPoint.init(x: 0, y: rect.size.height-1))
        cont?.addLine(to:CGPoint.init(x: rect.size.width, y: rect.size.height-1))
        cont?.strokePath()

    }
    
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
