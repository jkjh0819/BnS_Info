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
    var dungeonData:Dungeon?
    var dungeonName:String!
    var teamLeader:String!
    
    //sampleData
    let cName:String = "리엘 베르디"
    var tempNames:[String] = ["리엘 베르디", "쵸쿄파이", "늘빈님", "천상극법", "천상원이", "쿠코상", "천화도", "쬬퍄", "암살자꼼이", "힘쎈슈야"]
    let tempRole = [["1파티", "탱커", "6시"], ["1파티","탱커","내부"], ["1파티","탱커","모장군"], ["1파티","탱커","12시"]]
    let dType = 21
    
    
    //던전 이름 별로 섹션 갯수 나누고 역할 띄우기
    
       override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = dungeonName
        self.title = "검은 마천루"
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // TODO : arccodian animation 구현
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if teamLeader == cName {
            return 1
        }
        return 4
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if teamLeader == cName {
            return "팀원"
        }
        return namedData[getDungeonIndex(type: dType)][section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if teamLeader == cName {
            return tempNames.count
        }
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)

        // Configure the cell...
        /*if let partyText = character?.tactic?[indexPath.row].party {
            if let roleText = character?.tactic?[indexPath.row].role {
                cell.textLabel?.text = String(partyText) + "파티, " + roleText
            }
        }*/
        
        if teamLeader == cName {
            cell.textLabel?.text = tempNames[indexPath.row]
            cell.detailTextLabel?.text = ""
        } else {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "파티"
                break
            case 1:
                cell.textLabel?.text = "역할"
                break
            case 2:
                cell.textLabel?.text = "위치"
                break
            default:
                break
            }
            cell.detailTextLabel?.text = tempRole[indexPath.section][indexPath.row]
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if teamLeader == cName {
        let change = UITableViewRowAction(style: .normal, title: "change") { action, index in
            //self.isEditing = false
            let cell = tableView.cellForRow(at: indexPath)
            self.performSegue(withIdentifier: "change", sender: cell)
            print("change button tapped")
        }
        change.backgroundColor = UIColor.orange
        
        let delete = UITableViewRowAction(style: .normal, title: "delete") { action, index in
            //self.isEditing = false
            //여기서 그냥 데이터 딜리트 해버리면 됨.
            self.tempNames.remove(at: indexPath.row)
            self.tableView.reloadData()
            print("delete button tapped")
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
        
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
    
        print("prepare move segue")
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "change" {
            
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
