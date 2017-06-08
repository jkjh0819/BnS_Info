//
//  MemberSettingDetailViewController.swift
//  BnS_Info
//
//  Created by 표영권 on 2017. 6. 2..
//  Copyright © 2017년 Jihye Jegal. All rights reserved.
//

import UIKit

class MemberSettingDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MemberSettingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MemberSettingCell", for:indexPath) as! MemberSettingTableViewCell
        
        let frame = cell.frame
        print(frame.minX, frame.minY, frame.maxX, frame.maxY)
        
        if indexPath.row == 0 {
            let items = ["first", "second", "third"]
            let roleSelect = UISegmentedControl(items: items)
            roleSelect.frame = CGRect(x: frame.maxX/2 , y: frame.minY, width: frame.maxX/2, height: (frame.maxY-frame.minY)*0.8)
            cell.contentView.addSubview(roleSelect)
        } else {
            let items = ["first", "second", "third","fourth"]
            let roleSelect = UISegmentedControl(items: items)
            roleSelect.frame = CGRect(x: frame.maxX, y: frame.minY, width: frame.minX*0.5, height: frame.minY*0.5)
            cell.contentView.addSubview(roleSelect)
        }
        
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
