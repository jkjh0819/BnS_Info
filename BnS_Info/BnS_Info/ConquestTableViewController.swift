//
//  ConquestTableViewController.swift
//  BnS_Info
//
//  Created by 표영권 on 2017. 5. 12..
//  Copyright © 2017년 Jihye Jegal. All rights reserved.
//

import UIKit

class ConquestTableViewController: UITableViewController {
    
//    요구사항:
//    셀에는 이미지, 타이틀, 서브타이틀이 들어간다.
//    이미지는 해당 던전을 대표하는 이미지,
//    타이틀은 OOO 공략
//    서브타이틀은 해도 되고 안 해도 되는데 간단한 스크립션을 넣을 수 있도록.

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
        return 1
    }
    
    // Pop up browser with under urls if user tabs the cell.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url : NSURL?
        
        switch indexPath.section{
        case 0:
            switch indexPath.row{
            case 0:
                url = NSURL(string: "http://section0.row0.com")
            case 1:
                url = NSURL(string: "http://section0.row1.com")
            default:
                return;
            }
            
        case 1:
            switch indexPath.row{
            case 0:
                url = NSURL(string: "http://section1.row0.com")
            case 1:
                url = NSURL(string: "http://section1.row1.com")
            default:
                return;
            }
        default:
            return;
        }
        
        if url != nil{
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
            //UIApplication.shared.openURL(url! as URL)
        }

    }

    // reuseidentifier 꼭 체크해서 수정!!!!!
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "temp", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = "test"

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
