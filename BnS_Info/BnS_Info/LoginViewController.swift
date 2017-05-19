//
//  LoginViewController.swift
//  BnS_Info
//
//  Created by Jihye Jegal on 2017. 5. 19..
//  Copyright © 2017년 Jihye Jegal. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var characterName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }

}
