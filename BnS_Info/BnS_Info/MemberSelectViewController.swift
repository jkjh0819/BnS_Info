//
//  MemberSelectViewController.swift
//  BnS_Info
//
//  Created by Jihye Jegal on 2017. 6. 1..
//  Copyright © 2017년 Jihye Jegal. All rights reserved.
//

import UIKit
import Alamofire

class MemberSelectViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var dType:Int!
    
    var members:[String] = []
    
    var teamLeader:String!
    var teamNumber:String!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dungeonName: UILabel!
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 3
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if(self.isMovingFromParentViewController){
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
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let getName = getDungeonName(type: dType)
        dungeonName.text = getName
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let params = [
            "teamLeader": teamLeader,
            "dType": self.dType
            ] as [String : Any]
        
        Alamofire.request(
            "http://127.0.0.1:8000/Team/",
            method: .post,
            parameters: params,
            encoding: JSONEncoding.default,
            headers: nil).responseJSON { response in
                
                switch(response.result) {
                case .success(_):
                    if response.result.value != nil{
                        let result = response.result.value as! [String:String]
                        self.teamNumber = result["teamNumber"]
                        print(self.teamNumber)
                        
                    }
                    break
                    
                case .failure(_):
                    print(response.result.error)
                    break
                    
                }
                
        }
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "팀원"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamCreateCell", for:indexPath)
        cell.textLabel?.text = members[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .normal, title: "delete") { action, index in
            
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
                    
                    if response.result.value != nil {
                        print(response.result.value)
                    }
                    
                    
            }
            self.members.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        delete.backgroundColor = UIColor.red
        return [delete]
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "rightSegue" {
            if let destination = segue.destination as?
                MemberSettingDetailViewController {
                destination.dType = self.dType
            }
        }

    }
 
    @IBAction func unwindToMemberSelectView(segue:UIStoryboardSegue) {
    
        if let sourceViewController = segue.source as? MemberSettingDetailViewController {
            if let newMember = sourceViewController.cName.text {
                let keys = sourceViewController.roles.keys
            
                for k in keys {
                    let roles = sourceViewController.roles[k]?.keys
                    var role:String = ""
                    for r in roles!{
                        role += r+":"
                        role += (sourceViewController.roles[k]?[r])! + "_"
                    }
                    print(k,role)
                    let params = [
                        "characterName": newMember,
                        "teamNumber": self.teamNumber,
                        "dType": self.dType,
                        "namedNum": k,
                        "role" : role
                        ] as [String : Any]
                    
                    Alamofire.request(
                        "http://127.0.0.1:8000/Member/",
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
                members.append(newMember)
            }
            self.tableView.reloadData()
        }
    }
    
}
    

