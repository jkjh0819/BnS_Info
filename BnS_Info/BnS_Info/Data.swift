//
//  Data.swift
//  BnS_Info
//
//  Created by Jihye Jegal on 2017. 6. 7..
//  Copyright © 2017년 Jihye Jegal. All rights reserved.
//

import Foundation

var character:Character = Character(name:"이름을 입력해주세요")

let namedData = [["1성 구무악", "2성 구무악", "3성 구무악", "4성 구무악", "5성 구무악", "6성 구무악"], ["천독룡", "사안장군", "모순장군", "촉마왕"], ["적패왕"], ["초열검, 혹한검", "초마령", "흑풍마녀"]]

//접근은 dungeonTactic[getDungeonIndex(dType)][row][section]
let dungeonTactic = [nightTactic, macheonrooTactic, seojaTactic, sosaTactic]

let nightTactic = [nightRole, nightPosition]
let nightRole = [["탱커", "딜러"], ["탱커","딜러","거미","정화"]]
let nightPosition:[[String]] = []

let macheonrooTactic = [macheonrooRole, macheonrooPosition]
let macheonrooRole = [["탱커","딜러","독배달"],["탱커", "딜러", "내부"], ["탱커","딜러", "리딩", "띄우기"],["탱커", "딜러","발묶", "80격리", "30격리"]]
let macheonrooPosition = [["12시","3시","6시","9시"], ["12시","5시","7시"], ["모장군","순장군"], ["12시", "5시","7시"]]

let seojaTactic = [seojaRole, seojaPosition]
let seojaRole = [["탱커", "쫄", "철주","장판","파멸기"]]
let seojaPosition:[[String]] = []
    //[["중앙"], ["5,11", "1,7"], ["6,8","10,12","2,4"], ["3","9"], ["6,8","10,12","2,4"]]

let sosaTactic = [sosaRole, sosaPosition]
let sosaRole = [["탱커", "힐러","키퍼","딜러"], ["탱커","딜러"], ["탱커","표적","쫄"]]
let sosaPosition = [["초열검","혹한검"],["내부","외부"],[""]]


//11, 21, 22, 23 - "밤의 바람평야","검은 마천루","서자의 안식처", "소용돌이 사원"
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

func getDungeonIndex(type:Int) -> Int {
    switch type {
    case 11:
        return 0
    case 21:
        return 1
    case 22:
        return 2
    case 23:
        return 3
    default:
        return -1
    }
}

func getDungenRole(type:Int, section:Int, index:Int) -> [String] {
    return dungeonTactic[getDungeonIndex(type: type)][index][section]
}

func getDungeonRoleIdx(type:Int, section:Int, index:Int, title:String) -> Int {
    if type == 11 {
        if section > 3 {
            return dungeonTactic[getDungeonIndex(type: type)][index-1][1].index(of: title)!
        } else {
            return dungeonTactic[getDungeonIndex(type: type)][index-1][0].index(of: title)!
        }
    }
    return dungeonTactic[getDungeonIndex(type: type)][index-1][section].index(of: title)!
}

func getTeamIndex(teamNumber:String) -> Int {
    for i in 0...character.teams.count {
        if character.teams[i].teamNumber == teamNumber {
            return i
        }
    }
    return -1
}

func getMyRole(namedIdx:Int, Named:[Named]) -> [String:String] {
    for idx in 0...Named.count {
        if Named[idx].namedIdx == namedIdx {
            return Named[idx].role
        }
    }
    return ["":""]
}

class Character {
    let name:String
    var teams:[Team] = []
    
    init(name:String){
        self.name = name
    }
    
}

class Team {
    let teamNumber:String
    let dungeon:Dungeon
    let teamLeader:String
    
    init(teamNumber:String, dungeon:Dungeon, teamLeader:String){
        self.teamNumber = teamNumber
        self.dungeon = dungeon
        self.teamLeader = teamLeader
    }
}

class Dungeon {
    
    let dungeonType:Int
    let dungeonName:String
    var nameds:[Named] = []
    
    init(dungeonType:Int){
        self.dungeonType = dungeonType
        self.dungeonName = getDungeonName(type: dungeonType)
    }
}

class Named {
    //name은 네임드 이름, party는 몇 파티에 속하는지, role은 역할 ex > 탱커_12시
    //json에서 받아올 때는 ex > 1파티_탱커_12시와 같은식으로 받아와서 separate하게 됨
    let name:String
    let namedIdx:Int
    let role:[String:String]
    
    init(dType:Int,index:Int , role:[String:String]) {
        self.name = namedData[getDungeonIndex(type: dType)][index]
        self.namedIdx = index
        self.role = role
    }
}
