//
//  LockPhotoViewController.swift
//  DH.Photo
//
//  Created by 亚派 on 2018/1/17.
//  Copyright © 2018年 亚派. All rights reserved.
//

import UIKit

class LockPhotoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    var ListTableview:UITableView!
    var DocumentName:String!
    var DataList:[ListModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "照片"
    let LeftBtn = UIButton.init(type: UIButtonType.custom)
        LeftBtn.addTarget(self, action: #selector(Newdocument), for: UIControlEvents.touchUpInside)
        LeftBtn.setBackgroundImage(UIImage.init(named: "add"), for: UIControlState.normal)
        LeftBtn.frame = CGRect.init(x: 0, y: 0, width: 33, height: 33)
        
        let LeftNavibtn = UIBarButtonItem.init(customView: LeftBtn)
        self.navigationItem.leftBarButtonItem = LeftNavibtn
//
//        let RightBtn = UIButton.init(type: UIButtonType.custom)
//        RightBtn.setTitle("编辑", for: UIControlState.normal)
//        RightBtn.setTitle("完成", for: UIControlState.selected)
//
//        RightBtn.addTarget(self, action: #selector(self.editBtnSelect(sender:)), for: UIControlEvents.touchUpInside)
//        RightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
//        RightBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
//        RightBtn.frame = CGRect.init(x: 0, y: 0, width: 35, height: 35)
//        let RightNavibtn = UIBarButtonItem.init(customView: RightBtn)
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        initUI()
        // Do any additional setup after loading the view.
    }
    func  initUI(){
         for i in  0..<3
         {
            let model = ListModel()
            model.DocumentName = String(i)
            model.PhtotoCount = i
            self.DataList.append(model)
            
        }
        ListTableview = UITableView()
        ListTableview.register(UINib.init(nibName: "ListViewCell", bundle: nil), forCellReuseIdentifier: "ListCell")
        ListTableview.backgroundColor = UIColor.white
        ListTableview.separatorStyle = .none
        ListTableview.delegate = self
        ListTableview.dataSource = self
        ListTableview.tableFooterView = UIView()
        ListTableview.frame = self.view.bounds
        self.view.addSubview(ListTableview)
    
    }
    @objc func Newdocument(){
        
        let alerVC = UIAlertController.init(title: "请输入新建文件夹的名称", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
    
        alerVC.addAction(UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default) { (Action) in
            
            let model = ListModel()
            model.DocumentName = self.DocumentName
            self.DataList.append(model)
            self.ListTableview.reloadData()
        })
        
        alerVC.addAction(UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel) { (Action) in
            print("取消")

            self.DocumentName = ""
        })
        
        alerVC.addTextField { (textField) in

            textField.addTarget(self, action: #selector(self.textfieldDidChange(sender:)), for: UIControlEvents.editingChanged)

            
        }
  self.present(alerVC, animated: true, completion: nil)
}

    
   @objc func textfieldDidChange(sender:UITextField){
        
        
       self.DocumentName = sender.text

        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
       
        super.setEditing(editing, animated: animated)
       ListTableview.setEditing(editing, animated: animated)
      
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return DataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as? ListViewCell
        cell?.DocumentNameLab.text = DataList[indexPath.row].DocumentName
        cell?.selectionStyle = .none
        cell?.PhtotoCountLab.text = "0张"
        
        return cell!
    }
    //方法
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if tableView.isEditing {
            return  UITableViewCellEditingStyle.delete

        }
        return  UITableViewCellEditingStyle.none
    }
//    //自定义左滑出现的按钮代理方法.如果实现了该方法，下面的方法不会调用
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//
//
//        let deleteAction = UITableViewRowAction.init(style: .normal, title: "") { (action, indexPath) in
//
//            tableView.setEditing(false, animated: true)
//        }
//
//        return [deleteAction]
//    }
    
    
    
    //tableview接受编辑调用的方法
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //delete the row from the data source
            DataList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
        //是否可以移动
    func  tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Don't move the last row
        if indexPath.row != DataList.count{
          
            return true
        
        }else{
            
            return false
        }
    }
    
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 66
    }
    //移动特定的莫行

//    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
//
//        if proposedDestinationIndexPath.row >= DataList.count {
//            //Place as second last item
//            return NSIndexPath.init(row: proposedDestinationIndexPath.row-1, section: proposedDestinationIndexPath.section) as IndexPath
//        }else{
//
//            return proposedDestinationIndexPath
//        }
//    }
    //移动分区index到新的分区newindex

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        if sourceIndexPath.section == destinationIndexPath.section && sourceIndexPath.row == destinationIndexPath.row{
           
            return
        }else{
            //get the moving item an thus retain it!
            let movingItem = DataList[sourceIndexPath.row]
            
            //insert from and delete from dataSource
            DataList.remove(at: sourceIndexPath.row)
            DataList.insert(movingItem, at: destinationIndexPath.row)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }

}
