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
    
    //namedNum:[roles]  roles > party, role, position
    var roles:[Int:[String:String]] = [:]
    
    func changeValue(sender: UISegmentedControl) {
        let section = sender.tag/10
        let row = sender.tag%10
        
        if let data = sender.titleForSegment(at: sender.selectedSegmentIndex) {
            switch row {
            case 0:
                roles[section]?["party"] = data
                print(roles[section])
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
        
        print(roles[section]?["role"])
        
        /*switch sender.selectedSegmentIndex {
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
        }*/
    }
    
    override func viewWillAppear(_ animated: Bool) {
        roles[1] = ["party":"", "role":"", "position":""]
        print(roles[1])
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
        print(getDungeonIndex(type: dType))
        return namedData[getDungeonIndex(type: dType)].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return namedData[getDungeonIndex(type: dType)][section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch dType {
        case 11:
            if section < 3 {
                return 1
            } else {
                return 2
            }
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
            let font = UIFont.systemFont(ofSize: 16)
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
            let font = UIFont.systemFont(ofSize: 16)
            segCon.setTitleTextAttributes([NSFontAttributeName: font], for: .normal)
            
            segCon.selectedSegmentIndex = 0
            
            //section은 10의자리, row는 1의 자리
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
            
            //section은 10의자리, row는 1의 자리
            segCon.tag = indexPath.section*10 + indexPath.row
            segCon.addTarget(self, action: #selector(changeValue(sender:)), for: .valueChanged)
            cell.contentView.addSubview(segCon)
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
