//
//  DetailTableViewController.swift
//  BnS_Info
//
//  Created by Jihye Jegal on 2017. 5. 10..
//  Copyright © 2017년 Jihye Jegal. All rights reserved.
//

import UIKit
import Alamofire

class DetailTableViewController: UITableViewController {

    //팀장인 경우에는 데이터 셋을 받아와서 수정 삭제가 가능
    //팀원인 경우에는 받아온 데이터 셋이 그냥 자기 역할임
    var dungeonData:Dungeon!
    
    var teamNumber:String!
    var teamLeader:String!
    var cName:String!
    var members:[String] = []
    

    func getMemberList(completion:@escaping (_ result:NSDictionary) -> Void)
    {
        Alamofire.request("http://127.0.0.1:8000/getMemberList/", method: .post, parameters:
            ["teamNum": teamNumber], encoding: JSONEncoding.default, headers: nil).responseJSON { response in
                switch(response.result) {
                case .success(_):
                    let result = response.result.value as! NSDictionary
                    for k in result.allKeys {
                        if let newMember = result[k] {
                            self.members.append(newMember as! String)
                        }
                    }
                    completion(response.result.value as! NSDictionary)
                    
                case .failure(_):
                    completion(response.result.error as! NSDictionary)
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = dungeonData?.dungeonName
        if self.teamLeader == self.cName {
            getMemberList() { (result) in
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if teamLeader == cName {
            return 1
        }
        return dungeonData.nameds.count
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
                cell.detailTextLabel?.text = dungeonData.nameds[indexPath.row].role["party"]
                break
            case 1:
                cell.textLabel?.text = "역할"
                cell.detailTextLabel?.text = dungeonData.nameds[indexPath.row].role["role"]
                break
            case 2:
                cell.textLabel?.text = "위치"
                cell.detailTextLabel?.text = dungeonData.nameds[indexPath.row].role["position"]
                break
            default:
                break
            }
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if teamLeader == cName {
            let cell = tableView.cellForRow(at: indexPath)
            let change = UITableViewRowAction(style: .normal, title: "change") { action, index in
            self.performSegue(withIdentifier: "change", sender: cell)
        }
        change.backgroundColor = UIColor.orange
        
        let delete = UITableViewRowAction(style: .normal, title: "delete") { action, index in
            
            if self.members[indexPath.row] == self.teamLeader {
                let params = [
                    "teamNum": self.teamNumber
                ]
                
                Alamofire.request(
                    "http://127.0.0.1:8000/Team/",
                    method: .delete,
                    parameters: params,
                    encoding: JSONEncoding.default,
                    headers: nil).responseJSON { response in
                        switch(response.result) {
                        case .success(_):
                            print("delete team success")
                            break
                        case .failure(_):
                            print(response.result.error)
                            break
                        }
                }
                character.teams.remove(at: getTeamIndex(teamNumber: self.teamNumber))
                self.members.removeAll()
            } else {
                let params = [
                    "characterName": self.members[indexPath.row],
                    "teamNumber": self.teamNumber
                ]
                
                Alamofire.request(
                    "http://127.0.0.1:8000/Member/",
                    method: .delete,
                    parameters: params,
                    encoding: JSONEncoding.default,
                    headers: nil).responseJSON { response in
                        guard response.result.isSuccess else {
                            print(response.result.error)
                            return
                        }
                }
                self.members.remove(at: indexPath.row)
            }

            self.tableView.reloadData()
        }
            delete.backgroundColor = UIColor.red
            if cell?.textLabel?.text != self.teamLeader {
              return [delete, change]
            }
            return [delete]
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
            if let destination = segue.destination as? MemberChangeViewController {
                if let selectedIndex = tableView.indexPath(for: sender as! UITableViewCell)?.row {
                    destination.dType = dungeonData.dungeonType
                    destination.nameText = members[selectedIndex]
                    destination.teamNum = self.teamNumber
                }
            }
        }
    }
    
    @IBAction func unwindToDetailTableView(segue:UIStoryboardSegue) {
        if let sourceViewController = segue.source as? MemberChangeViewController {
            if let changedMember = sourceViewController.cName.text {
                let keys = sourceViewController.roles.keys
                
                for k in keys {
                    let roles = sourceViewController.roles[k]?.keys
                    var role:String = ""
                    for r in roles!{
                        role += r+":"
                        role += (sourceViewController.roles[k]?[r])! + "_"
                    }
                    let params = [
                        "prevName" : sourceViewController.nameText,
                        "characterName": changedMember,
                        "teamNum": self.teamNumber,
                        "dType": self.dungeonData.dungeonType,
                        "namedNumber": k,
                        "role" : role
                        ] as [String : Any]
                    
                    Alamofire.request(
                        "http://127.0.0.1:8000/modifyRole/",
                        method: .post,
                        parameters: params,
                        encoding: JSONEncoding.default,
                        headers: nil).responseJSON { response in
                            guard response.result.isSuccess else {
                                return
                            }
                    }
                    usleep(100000)
                }
                members[members.index(of: sourceViewController.nameText)!] = changedMember
            }
            self.tableView.reloadData()
        }
    }
}
