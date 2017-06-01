//
//  SampleData.swift
//  BnS_Info
//
//  Created by Jihye Jegal on 2017. 5. 10..
//  Copyright © 2017년 Jihye Jegal. All rights reserved.
//

import Foundation

let sampleData:SampleData = SampleData()

class SampleData {
    var characters:[Character] = []
    
    init() {
        let character1 = Character(name : "리엘 베르디", teamNumber : 1)
        
        let role1 = Macheonroo(party: 1, role: "12시")
        let role2 = Macheonroo(party: 2, role: "5시")
        let role3 = Macheonroo(party: 3, role: "모장군")
        let role4 = Macheonroo(party: 4, role: "80격리")
        
        character1.tactic = [role1, role2, role3, role4]
        
        characters.append(character1)
        
    }
}

class Character {
    var name:String
    var teamNumber:Int
    var tactic:[Macheonroo]?
    
    init(name:String, teamNumber:Int){
        self.name = name
        self.teamNumber = teamNumber
    }
    
}

class Macheonroo {
    var party:Int
    var role:String
    
    init(party:Int, role:String) {
        self.party = party
        self.role = role
    }
}
