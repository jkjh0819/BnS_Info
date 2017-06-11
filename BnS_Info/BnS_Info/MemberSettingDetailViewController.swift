//
//  MemberSettingDetailViewController.swift
//  BnS_Info
//
//  Created by 표영권 on 2017. 6. 2..
//  Copyright © 2017년 Jihye Jegal. All rights reserved.
//

import UIKit

class MemberSettingDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    var dType:Int = -1
    var roles:[String] = ["first","second", "third"]
    
    func changeValue1(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            roles[0] = "first role changed"
            break
        case 1:
            roles[1] = "second role changed"
            break
        case 2:
            roles[2] = "third role changed"
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return namedData[getDungeonIndex(type: dType)].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return namedData[getDungeonIndex(type: dType)][section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MemberSettingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MemberSettingCell", for:indexPath) as! MemberSettingTableViewCell
        cell.role.text = "sample role"
        
        if indexPath.row == 0 {
            let items = ["first", "second", "third"]
            let roleSelect = UISegmentedControl(items: items)
            roleSelect.frame = CGRect(x: 187.5 , y: 5, width: 182.5, height: 34)
            //roleSelect function added
            roleSelect.addTarget(self, action: #selector(changeValue1(sender:)), for: .valueChanged)
            //add Subview
            cell.contentView.addSubview(roleSelect)
        } else {
            let items = ["first", "second", "third","fourth"]
            let roleSelect = UISegmentedControl(items: items)
            roleSelect.frame = CGRect(x: 187.5 , y: 5, width: 182.5, height: 34)
            cell.contentView.addSubview(roleSelect)
        }
        
        return cell
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
