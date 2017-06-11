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
    var teamLeader:String!
    var teamNumber:Int = 0
    
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
        return 2
    }
    
    //여기 셀도 수정 삭제 필요할 것으로 보임
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "1성"
        }
        return "2성"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
