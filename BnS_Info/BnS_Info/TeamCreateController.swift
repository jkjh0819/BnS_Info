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
            if let destination = segue.destination as?
                MemberSelectViewController {
                destination.dType = self.dType
                destination.teamLeader = self.leader.text
            }
        }
    }
}
