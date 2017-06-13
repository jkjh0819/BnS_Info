//
//  TeamCreateController.swift
//  BnS_Info
//
//  Created by 표영권 on 2017. 5. 11..
//  Copyright © 2017년 Jihye Jegal. All rights reserved.
//

import UIKit
import Alamofire

class TeamCreateController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var leaderName:String!
    var dType:Int = 11
    
    @IBOutlet weak var leader: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var pickerData = ["밤의 바람평야","검은 마천루","서자의 안식처", "소용돌이 사원"]
    
    @IBAction func BackToMain(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        leader.text = character.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row] as String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.dType = getDungeonType(Name: pickerData[row])
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MemberSelect" {
            //1. Server : setTeam 호출
            //reponse로 teamNumber 받아서 destination.teamNumber에 넣어주면 됨
            let params = [
                "teamLeader": self.leaderName,
                "dType": self.dType
            ] as [String : Any]
            print(params)
            var teamNum:String!
            Alamofire.request(
                "http://127.0.0.1:8000/newTeam/",
                method: .post,
                parameters: params,
                encoding: JSONEncoding.default,
                headers: nil).responseJSON { response in
                    guard response.result.isSuccess else {
                        print("error!")
                        print(response.result.error)
                        return
                    }
                    print("success")
                    if response.result.value != nil {
                        let result = response.result.value as! [String:String]
                        teamNum = result["teamNumber"]
                    }
            }
            
            
                if let destination = segue.destination as?
                    MemberSelectViewController {
                    print("dest correct")
                    destination.dType = self.dType
                    destination.teamLeader = self.leader.text
                    destination.teamNumber = teamNum
            }
        }
    }
}
