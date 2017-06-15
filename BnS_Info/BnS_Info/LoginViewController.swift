//
//  LoginViewController.swift
//  BnS_Info
//
//  Created by Jihye Jegal on 2017. 5. 19..
//  Copyright © 2017년 Jihye Jegal. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var characterName: UITextField!
    var connected:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func login(_ sender: Any) {
        Alamofire.request("http://211.209.10.187:80/", method: .post, parameters: ["check":"check"], encoding: JSONEncoding.default, headers: nil).responseString { response in
            switch (response.result) {
            case .success(_):
                self.performSegue(withIdentifier: "unwindLogin", sender: self)
                break
            case.failure(_):
                var alert = UIAlertView(title: "No Server Connection", message: "Please email to jkjh0819@naver.com", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
                break
            }
        }

    }
}
