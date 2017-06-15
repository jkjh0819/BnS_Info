//
//  MemberChangeViewController.swift
//  BnS_Info
//
//  Created by Jihye Jegal on 2017. 6. 15..
//  Copyright © 2017년 Jihye Jegal. All rights reserved.
//

import UIKit
import Alamofire

class MemberChangeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cName: UITextField!
    
    var dType:Int = -1
    var roles:[Int:[String:String]] = [:]
    var nameText:String!
    var teamNum:String!
    var loaded:Bool = false
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
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
    
    func getRole(completion:@escaping (_ result:String) -> Void)
    {
        Alamofire.request("http://211.209.10.187:80/requestRole/", method: .post, parameters: ["characterName": self.cName.text , "teamNum": self.teamNum, "dType": self.dType], encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(_):
                let result = response.result.value as! NSDictionary
                for k in result.allKeys {
                    if let namedNumber = Int(k as! String) {
                    
                    let roleStr = result[k] as! String
                    var tRole:[String:String] = [:]
                    for temp in roleStr.components(separatedBy: "_") {
                        if temp.contains(":") {
                            tRole[temp.components(separatedBy: ":")[0]] = temp.components(separatedBy: ":")[1]
                        }
                    }
                    self.roles[namedNumber] = tRole
                    }
                    
                }
                self.loaded = true
                completion("Success")
                self.tableView.reloadData()
                
            case .failure(_):
                completion("Fail")
            }
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cName.text = nameText
        getRole() { (result) in }
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
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        var items:[String]
        
        if indexPath.row == 0 {
            let role = UILabel()
            role.frame = CGRect(x: 18, y: 11, width: 174, height: 21)
            role.text = "파티"
            cell.contentView.addSubview(role)
            
            items = ["1","2","3","4"]
            let segCon = UISegmentedControl(items: items)
            segCon.frame = CGRect(x: Int(cell.frame.maxX)-5-46*items.count, y: 5, width: 46 * items.count, height: 34)
            let font = UIFont.systemFont(ofSize: 15)
            segCon.setTitleTextAttributes([NSFontAttributeName: font], for: .normal)
            
            if loaded {
                print(roles[indexPath.section]?["party"])
                segCon.selectedSegmentIndex = Int((roles[indexPath.section]?["party"])!)! - 1
            } else {
                segCon.selectedSegmentIndex = 0
            }
            
            
            segCon.tag = indexPath.section*10 + indexPath.row
            segCon.addTarget(self, action: #selector(changeValue(sender:)), for: .valueChanged)
            cell.contentView.addSubview(segCon)
            
        } else if indexPath.row == 1  {
            let role = UILabel()
            role.frame = CGRect(x: 18, y: 11, width: 174, height: 21)
            role.text = "역할"
            cell.contentView.addSubview(role)
            
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
            let font = UIFont.systemFont(ofSize: 14)
            segCon.setTitleTextAttributes([NSFontAttributeName: font], for: .normal)
            
            if loaded {
                segCon.selectedSegmentIndex = getDungeonRoleIdx(type: self.dType, section: indexPath.section, index: indexPath.row, title: (roles[indexPath.section]?["role"])!)
            } else {
                segCon.selectedSegmentIndex = 0
            }
            
            
            segCon.tag = indexPath.section*10 + indexPath.row
            segCon.addTarget(self, action: #selector(changeValue(sender:)), for: .valueChanged)
            cell.contentView.addSubview(segCon)
        } else {
            let role = UILabel()
            role.frame = CGRect(x: 18, y: 11, width: 174, height: 21)
            role.text = "위치"
            cell.contentView.addSubview(role)
            
            let items = getDungenRole(type: dType, section:indexPath.section, index: indexPath.row-1)
            let segCon = UISegmentedControl(items: items)
            segCon.frame = CGRect(x: Int(cell.frame.maxX)-5-46*items.count, y: 5, width: 46 * items.count, height: 34)
            let font = UIFont.systemFont(ofSize: 14)
            segCon.setTitleTextAttributes([NSFontAttributeName: font], for: .normal)
            
            if loaded {
                segCon.selectedSegmentIndex = getDungeonRoleIdx(type: self.dType, section: indexPath.section, index: indexPath.row, title: (roles[indexPath.section]?["position"])!)
            } else {
                segCon.selectedSegmentIndex = 0
            }
            
            segCon.tag = indexPath.section*10 + indexPath.row
            segCon.addTarget(self, action: #selector(changeValue(sender:)), for: .valueChanged)
            cell.contentView.addSubview(segCon)
        }
        
        return cell
    }

}
