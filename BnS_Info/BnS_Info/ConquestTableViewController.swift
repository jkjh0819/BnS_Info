//
//  ConquestTableViewController.swift
//  BnS_Info
//
//  Created by 표영권 on 2017. 5. 12..
//  Copyright © 2017년 Jihye Jegal. All rights reserved.
//

import UIKit

class ConquestTableViewController: UITableViewController {
    
let dungeonNames = ["밤의 바람평야", "검은 마천루", "서자의 안식처", "소용돌이 사원"]
let conquestUrls = [
                    [],
                    [["천독룡","전체공략","conquest1","http://bns.plaync.com/board/job/warlock/article/5895798"]],
                    [["적패왕","전체공략","","http://bns.plaync.com/board/job/warlock/article/7051249"]],
                    [["초열검, 혹한검", "기공사시점", "","http://bns.plaync.com/board/job/forcemaster/article/6641201"],
                     ["초마령","전체공략","","http://bns.plaync.com/board/job/warlock/article/6793129"]]
                   ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "공략 보기"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return dungeonNames.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dungeonNames[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conquestUrls[section].count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = NSURL(string: conquestUrls[indexPath.section][indexPath.row][3])
        
        if url != nil{
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
        }
            
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "conquest", for: indexPath) as! ConquestTableViewCell
        cell.title.text = conquestUrls[indexPath.section][indexPath.row][0]
        cell.subTitle.text = conquestUrls[indexPath.section][indexPath.row][1]
        cell.imageView?.image = UIImage(named: conquestUrls[indexPath.section][indexPath.row][2])
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
