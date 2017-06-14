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
    
    @IBOutlet weak var characterName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return character.teams.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tacticCell", for: indexPath)
        cell.textLabel?.text = character.teams[indexPath.row].dungeon.dungeonName
        return cell
    }
    
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
                    character.teams.removeAll()
                    
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
        Alamofire.request("http://127.0.0.1:8000/login/", method: .post, parameters: ["characterName": self.characterName.text], encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    character.teams.removeAll()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            if let destination = segue.destination as? DetailTableViewController {
                if let selectedIndex = self.tableView.indexPathForSelectedRow?.row {
                    destination.teamNumber = character.teams[selectedIndex].teamNumber
                    destination.cName = characterName.text
                    destination.teamLeader = character.teams[selectedIndex].teamLeader
                    destination.dungeonData = character.teams[selectedIndex].dungeon
                    }
                }
            }
    
        if segue.identifier == "TeamCreate" {
            var DestViewController = segue.destination as! UINavigationController
            
            let targetController = DestViewController.topViewController as! TeamCreateController
            targetController.leaderName = self.characterName?.text
        }
        
        
    }
    
}
