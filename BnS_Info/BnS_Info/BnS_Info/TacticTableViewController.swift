//
//  TacticTableViewController.swift
//  BnS_Info
//
//  Created by 표영권 on 2017. 5. 7..
//  Copyright © 2017년 Jihye Jegal. All rights reserved.
//

import UIKit
import Alamofire

class TacticTableViewController: UITableViewController {

    let sampleTeam = ["검은 마천루", "소용돌이사원", "밤의 바람평야", "서자의 안식처"]
    
    
    @IBOutlet weak var characterName: UILabel!
    
    @IBAction func CheckTeam(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        // 캐릭터당 팀 갯수 만큼 row만들도록 수정해야 함.
        //return character.teams.count
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tacticCell", for: indexPath)
        //cell.textLabel?.text = character.teams[indexPath.row].dungeon.dungeonName
        cell.textLabel?.text = sampleTeam[indexPath.row]
        return cell
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
    // 로그인 화면의 unwind 목적지가 될 곳
    @IBAction func unwindToTacticTable(segue:UIStoryboardSegue) {
        
        if let sourceViewController = segue.source as? LoginViewController {
            self.characterName.text = sourceViewController.characterName.text
            if let newName = self.characterName.text {
                character = Character(name: newName)
            }
        }
        
        Alamofire.request("http://127.0.0.1:8000/login/", method: .post, parameters: ["characterName": self.characterName.text], encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    //teamNumber:dungeonType
                    let result = response.result.value as! NSDictionary
                    let keys = result.allKeys
                    for key in keys {
                        let teamNumber = key as! String
                        let values = result.value(forKey: teamNumber) as! NSArray
                        let dungeonData = Dungeon(dungeonType: values[0] as! Int)
                        let teamData = Team(teamNumber: String(teamNumber)!, dungeon: dungeonData, teamLeader: values[1] as! String)
                        character.teams.append(teamData)
                    }
                }
                break
                
            case .failure(_):
                print(response.result.error)
                break
                
            }
            self.tableView.reloadData()
        }
        
    }
    
    @IBAction func unwindToTacticTable2(segue:UIStoryboardSegue) {
        // 팀 생성 후 돌아오는 액션
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "DetailSegue" {
            if let destination = segue.destination as? DetailTableViewController {
                if let selectedIndex = self.tableView.indexPathForSelectedRow?.row {
                   /* Alamofire.request("http://127.0.0.1:8000/requestRole/", method: .post, parameters: ["characterName": self.characterName.text, "teamNum": character.teams[selectedIndex].teamNumber, "dType": character.teams[selectedIndex].dungeon.dungeonType], encoding: JSONEncoding.default, headers: nil).responseJSON { response in
                        switch(response.result) {
                        case .success(_):
                            //namedNum: tactic 받아오므로 파싱해서 데이터에집어넣어주어야 함.
                            if response.result.value != nil{
                                print(response.result.value)
                            }
                            break
                            
                        case .failure(_):
                            print(response.result.error)
                            break
                            
                        }
                    }*/
                    
                    destination.teamLeader = self.characterName.text
                    
                    /*destination.dungeonData = character.teams[selectedIndex].dungeon
                    destination.dungeonName = character.teams[selectedIndex].dungeon.dungeonName*/
                }
            }
        }
        
        if segue.identifier == "TeamCreate" {
            if let destination = segue.destination as? TeamCreateController {
                if let leaderName = self.characterName?.text {
                    destination.leaderName = leaderName
                }
            }
        }
        
        
    }
    
}
