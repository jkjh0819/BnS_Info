//
//  MemberSelectViewController.swift
//  BnS_Info
//
//  Created by Jihye Jegal on 2017. 6. 1..
//  Copyright © 2017년 Jihye Jegal. All rights reserved.
//

import UIKit

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
    
    override func viewWillAppear(_ animated: Bool) {
        let getName = getDungeonName(type: dType)
        dungeonName.text = getName
        //여기에 서버 set team 생성하는 부분 추가
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
        return 1
    }
    
    //여기 셀도 수정 삭제 필요할 것으로 보임
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "팀원"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //팀원의 수만큼 리턴
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamCreateCell", for:indexPath)
        cell.textLabel?.text = members[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .normal, title: "delete") { action, index in
            //self.isEditing = false
            //여기서 그냥 데이터 딜리트 해버리면 됨.
            self.members.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        delete.backgroundColor = UIColor.red
        return [delete]
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "rightSegue" {
            if let destination = segue.destination as?
                MemberSettingDetailViewController {
                destination.dType = self.dType
            }
        }

    }
 

    //팀원 추가하고 테이블 셀 리로드
    @IBAction func unwindToMemberSelectView(segue:UIStoryboardSegue) {
        
        //여기서 서버에 리더랑 던전타입, 팀번호를 넣어주어야 함.
        if let sourceViewController = segue.source as? MemberSettingDetailViewController {
            if let newMember = sourceViewController.cName.text {
                
                members.append(newMember)
            }
            self.tableView.reloadData()
        }
    }
}
