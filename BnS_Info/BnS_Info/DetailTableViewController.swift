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
    
    //던전 이름 별로 섹션 갯수 나누고 역할 띄우기
    
       override func viewDidLoad() {
        super.viewDidLoad()
        self.title = dungeonName
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let rowCount = sampleData.characters[0].tactic?.count else {
            return 0
        }
        return rowCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)

        // Configure the cell...
        /*if let partyText = character?.tactic?[indexPath.row].party {
            if let roleText = character?.tactic?[indexPath.row].role {
                cell.textLabel?.text = String(partyText) + "파티, " + roleText
            }
        }*/
        return cell
    }
    

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let change = UITableViewRowAction(style: .normal, title: "change") { action, index in
            //self.isEditing = false
            let cell = tableView.cellForRow(at: indexPath)
            print("before move segue")
            self.performSegue(withIdentifier: "change", sender: cell)
            print("change button tapped")
        }
        change.backgroundColor = UIColor.orange
        
        let delete = UITableViewRowAction(style: .normal, title: "delete") { action, index in
            //self.isEditing = false
            //여기서 그냥 데이터 딜리트 해버리면 됨.
            print("favorite button tapped")
        }
        delete.backgroundColor = UIColor.red
        
        return [delete, change]
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
