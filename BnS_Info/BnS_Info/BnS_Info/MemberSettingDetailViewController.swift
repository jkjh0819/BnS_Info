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
    @IBOutlet weak var cName: UITextField!

    var dType:Int = -1
    var roles:[Int:[String:String]] = [:]
    
    func changeValue(sender: UISegmentedControl) {
        //section은 10의자리, row는 1의 자리
        let section = sender.tag/10
        let row = sender.tag%10
        
        if let data = sender.titleForSegment(at: sender.selectedSegmentIndex) {
            switch row {
            case 0:
                roles[section]?["party"] = data
                break
            case 1:
                roles[section]?["role"] = data
                break
            case 2:
                roles[section]?["position"] = data
                break
            default:
                break
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //role dictionary 초기화
        for idx in 0...namedData[getDungeonIndex(type: dType)].count-1 {
            if dType == 11 {
                if idx >= 3 {
                    roles[idx] = ["party":"1","role":getDungenRole(type: dType, section: 1, index: 0)[0]]
                } else {
                    roles[idx] = ["party":"1","role":getDungenRole(type: dType, section: 0, index: 0)[0]]
                }
                
            } else if dType == 22 {
                roles[idx] = ["party":"1","role":getDungenRole(type: dType, section: idx, index: 0)[0]]
            } else {
                roles[idx] = ["party":"1","role":getDungenRole(type: dType, section: idx, index: 0)[0], "position":getDungenRole(type: dType, section: idx, index: 1)[0]]
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return namedData[getDungeonIndex(type: dType)].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return namedData[getDungeonIndex(type: dType)][section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch dType {
        case 11:
            return 2
        case 21:
            return 3
        case 22:
            return 2
        case 23:
            if section == 2 {
                return 2
            } else {
                return 3
            }
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MemberSettingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MemberSettingCell", for:indexPath) as! MemberSettingTableViewCell
        var items:[String]
        
        if indexPath.row == 0 {
            cell.role.text = "파티"
            items = ["1","2","3","4"]
            let segCon = UISegmentedControl(items: items)
            segCon.frame = CGRect(x: Int(cell.frame.maxX)-5-46*items.count, y: 5, width: 46 * items.count, height: 34)
            let font = UIFont.systemFont(ofSize: 15)
            segCon.setTitleTextAttributes([NSFontAttributeName: font], for: .normal)
            
            segCon.selectedSegmentIndex = 0
            segCon.tag = indexPath.section*10 + indexPath.row
            segCon.addTarget(self, action: #selector(changeValue(sender:)), for: .valueChanged)
            cell.contentView.addSubview(segCon)
            
        } else if indexPath.row == 1  {
            cell.role.text = "역할"
            if dType == 11 {
                if indexPath.section >= 3 {
                    items = getDungenRole(type: dType, section: 1, index: indexPath.row-1)
                } else {
                    items = getDungenRole(type: dType, section:0, index: indexPath.row-1)
                }
                
            } else {
                items = getDungenRole(type: dType, section:indexPath.section, index: indexPath.row-1)
            }
            let segCon = UISegmentedControl(items: items)
            segCon.frame = CGRect(x: Int(cell.frame.maxX)-5-46*items.count, y: 5, width: 46 * items.count, height: 34)
            let font = UIFont.systemFont(ofSize: 15)
            segCon.setTitleTextAttributes([NSFontAttributeName: font], for: .normal)
            
            segCon.selectedSegmentIndex = 0
            
            
            segCon.tag = indexPath.section*10 + indexPath.row
            segCon.addTarget(self, action: #selector(changeValue(sender:)), for: .valueChanged)
            cell.contentView.addSubview(segCon)
        } else {
            cell.role.text = "위치"
            let items = getDungenRole(type: dType, section:indexPath.section, index: indexPath.row-1)
            let segCon = UISegmentedControl(items: items)
            segCon.frame = CGRect(x: Int(cell.frame.maxX)-5-46*items.count, y: 5, width: 46 * items.count, height: 34)
            let font = UIFont.systemFont(ofSize: 16)
            segCon.setTitleTextAttributes([NSFontAttributeName: font], for: .normal)
            
            segCon.selectedSegmentIndex = 0
            
            segCon.tag = indexPath.section*10 + indexPath.row
            segCon.addTarget(self, action: #selector(changeValue(sender:)), for: .valueChanged)
            cell.contentView.addSubview(segCon)
        }
        
        return cell
    }
}
