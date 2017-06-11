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
    //character name이랑 role이랑 같이 받도록 수정해야 함
    var roles:[String] = []
    
    let tempNames:[String] = ["리엘 베르디", "쵸쿄파이", "늘빈님", "천상극법", "천상원이", "쿠코상", "천화도", "쬬퍄", "암살자꼼이", "힘쎈슈야"]
    
    var teamLeader:String!
    var teamNumber:String!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dungeonName: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        let getName = getDungeonName(type: dType)
        dungeonName.text = getName
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
        return tempNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamCreateCell", for:indexPath)
        cell.textLabel?.text = tempNames[indexPath.row]
        
        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "rightSegue" {
            //set Team호출하고 teamNumber 받아서 함께 넘겨줘야함
            if let destination = segue.destination as?
                MemberSettingDetailViewController {
                destination.dType = self.dType
            }
        }

    }
 

    //팀원 추가하고 테이블 셀 리로드
    @IBAction func unwindToMemberSelectView(segue:UIStoryboardSegue) {
        //이 뷰에서 리더랑 던전타입, 팀번호를 넣어주어야 함.
        if let sourceViewController = segue.source as? MemberSettingDetailViewController {
            self.roles = sourceViewController.roles
            print(self.roles)
        }
    }
    
    @IBAction func unwindToMemberSelectViewCancel(segue:UIStoryboardSegue) {
        //role 생성 취소
    }
}
