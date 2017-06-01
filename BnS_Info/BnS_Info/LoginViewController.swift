//
//  LoginViewController.swift
//  BnS_Info
//
//  Created by Jihye Jegal on 2017. 5. 19..
//  Copyright © 2017년 Jihye Jegal. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var characterNameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(_ sender: Any) {
        let characterName = characterNameField.text!
        switch self.presentingViewController {
        case let tabBarC as UITabBarController :
            if let navigationC = tabBarC.selectedViewController as? UINavigationController, let tacticTableVC = navigationC.topViewController as? TacticTableViewController {
                tacticTableVC.checkTeam(name: characterName)
            }
        case let navigationC as UINavigationController:
            if let tacticTableVC = navigationC.topViewController as? TacticTableViewController {
                tacticTableVC.checkTeam(name: characterName)
            }
        case let tacticTableVC as TacticTableViewController:
            tacticTableVC.checkTeam(name: characterName)
        default:
            break
        }
        self.dismiss(animated: true, completion: nil)
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

