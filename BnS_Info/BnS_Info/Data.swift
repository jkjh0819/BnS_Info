//
//  Data.swift
//  BnS_Info
//
//  Created by Jihye Jegal on 2017. 6. 7..
//  Copyright © 2017년 Jihye Jegal. All rights reserved.
//

import Foundation

var character:Character = Character(name:"이름을 입력해주세요")

func getDungeonName(type:Int) -> String {
    switch type {
    case 11:
        return "밤의 바람평야"
    case 21:
        return "검은 마천루"
    case 22:
        return "서자의 안식처"
    case 23:
        return "소용돌이 사원"
    default:
        return "Dunjeon Code Error"
    }
}

func getDungeonType(Name:String) -> Int {
    switch Name {
        case "밤의 바람평야":
            return 11
        case "검은 마천루":
            return 21
        case "서자의 안식처":
            return 22
        case "소용돌이 사원":
            return 23
        default:
            return -1
    }
}

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
    let teamLeader:String
    
    init(teamNumber:Int, dungeon:Dungeon, teamLeader:String){
        self.teamNumber = teamNumber
        self.dungeon = dungeon
        self.teamLeader = teamLeader
    }
}

class Dungeon {
    //11, 21, 22, 23 - "밤의 바람평야","검은 마천루","서자의 안식처", "소용돌이 사원"
    let dungeonType:Int
    let dungeonName:String
    var nameds:[Named] = []
    
    init(dungeonType:Int){
        self.dungeonType = dungeonType
        self.dungeonName = getDungeonName(type: dungeonType)
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
