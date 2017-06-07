//
//  Data.swift
//  BnS_Info
//
//  Created by Jihye Jegal on 2017. 6. 7..
//  Copyright © 2017년 Jihye Jegal. All rights reserved.
//

import Foundation

var character = Character(name:"이름을 입력해주세요")

class Character {
    let name:String
    var teams:[Team] = []
    
    init(name:String){
        self.name = name
    }
    
}

class Team {
    let teamNumber:Int
    let dungeon:Dungeon
    
    init(teamNumber:Int, dungeon:Dungeon){
        self.teamNumber = teamNumber
        self.dungeon = dungeon
    }
}

class Dungeon {
    //11, 21, 22, 23 - "밤의 바람평야","검은 마천루","서자의 안식처", "소용돌이 사원"
    let dungeonType:Int
    let dungeonName:String
    var nameds:[Named] = []
    
    init(dungeonType:Int){
        self.dungeonType = dungeonType
        switch dungeonType {
        case 11:
            self.dungeonName = "밤의 바람평야"
        case 21:
            self.dungeonName = "검은 마천루"
        case 22:
            self.dungeonName = "서자의 안식처"
        case 23:
            self.dungeonName = "소용돌이 사원"
        default:
            self.dungeonName = "Dunjeon Code Error"
        }
    }
}

class Named {
    let name:String
    let party:Int
    let role:String
    
    init(name:String, party:Int, role:String) {
        self.name = name
        self.party = party
        self.role = role
    }
}
