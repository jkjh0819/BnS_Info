//
//  DetailTableViewController.swift
//  BnS_Info
//
//  Created by Jihye Jegal on 2017. 5. 10..
//  Copyright © 2017년 Jihye Jegal. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {

    //팀장인 경우에는 데이터 셋을 받아와서 수정 삭제가 가능
    //팀원인 경우에는 받아온 데이터 셋이 그냥 자기 역할임
    var dungeonData:Dungeon!
    
    var teamNumber:String!
    var teamLeader:String!
    var cName:String!
    var members:[String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = dungeonData?.dungeonName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
       override func numberOfSections(in tableView: UITableView) -> Int {
        if teamLeader == cName {
            return 1
        }
        return 4
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if teamLeader == cName {
            return "팀원"
        }
        return namedData[getDungeonIndex(type: dungeonData.dungeonType)][section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if teamLeader == cName {
            return members.count
        }
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        
        if teamLeader == cName {
            cell.textLabel?.text = members[indexPath.row]
            cell.detailTextLabel?.text = ""
        } else {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "파티"
                cell.detailTextLabel?.text = dungeonData.nameds[indexPath.row].role["파티"]
                break
            case 1:
                cell.textLabel?.text = "역할"
                cell.detailTextLabel?.text = dungeonData.nameds[indexPath.row].role["역할"]
                break
            case 2:
                cell.textLabel?.text = "위치"
                cell.detailTextLabel?.text = dungeonData.nameds[indexPath.row].role["위치"]
                break
            default:
                break
            }
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if teamLeader == cName {
        let change = UITableViewRowAction(style: .normal, title: "change") { action, index in
            let cell = tableView.cellForRow(at: indexPath)
            self.performSegue(withIdentifier: "change", sender: cell)
        }
        change.backgroundColor = UIColor.orange
        
        let delete = UITableViewRowAction(style: .normal, title: "delete") { action, index in
            //7. Server : removeTeamMember호출
            self.members.remove(at: indexPath.row)

            self.tableView.reloadData()
        }
            delete.backgroundColor = UIColor.red
            print(delete)
            return [delete, change]
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if teamLeader == cName {
            return true;
        }
        return false;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
    
        if segue.identifier == "change" {
            //6. Server : getRoleNum 호출
            //destination에 role부분에 대입
            print("change")
        }
    }
    
    @IBAction func unwindToDetailTableView(segue:UIStoryboardSegue) {
        if let sourceViewController = segue.source as? MemberSettingDetailViewController {
        }
    }
    
    @IBAction func unwindToDetailTableViewCancel(segue:UIStoryboardSegue) {
        if let sourceViewController = segue.source as? MemberSettingDetailViewController {
        }
    }
    
}