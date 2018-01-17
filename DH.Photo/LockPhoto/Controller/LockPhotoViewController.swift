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
        
        let RightBtn = UIButton.init(type: UIButtonType.custom)
        RightBtn.setTitle("编辑", for: UIControlState.normal)
        RightBtn.addTarget(self, action: #selector(self.editBtnSelect(sender:)), for: UIControlEvents.touchUpInside)
        RightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        RightBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        RightBtn.frame = CGRect.init(x: 0, y: 0, width: 35, height: 35)
        let RightNavibtn = UIBarButtonItem.init(customView: RightBtn)
        self.navigationItem.rightBarButtonItem = RightNavibtn
        initUI()
        // Do any additional setup after loading the view.
    }
    func  initUI(){
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return DataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as? ListViewCell
        cell?.DocumentNameLab.text = DataList[indexPath.row].DocumentName
        cell?.PhtotoCountLab.text = "0张"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 66
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func editBtnSelect(sender:UIButton){
        
        sender.isSelected = !sender.isSelected
        self.ListTableview.allowsMultipleSelectionDuringEditing = true
        // 进入编辑模式
        self.ListTableview.setEditing(sender.isSelected, animated: true)
    }

    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        return "删除"
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
