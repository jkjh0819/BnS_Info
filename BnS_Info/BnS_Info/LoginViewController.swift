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
        if segue.identifier == "LoginSegue" {
            if let tab = segue.destination as? UITabBarController{
                print("here1")
                if let nav = tab.viewControllers?[0] as? UINavigationController {
                    print("here2")
                    if let dest = nav.topViewController as? TacticTableViewController {
                        dest.characterName.text = self.characterName.text
                        
                    }
                }
            }
        }
        
    }
}

class right: UIStoryboardSegue {
    
    override func perform()
    {
        let src = self.source as UIViewController
        let dst = self.destination as UIViewController
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
        
        UIView.animate(withDuration: 0.25,
                                   delay: 0.0,
                                   options: UIViewAnimationOptions.curveEaseInOut,
                                   animations: {
                                    dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
                                    src.view.transform = CGAffineTransform(translationX: -src.view.frame.size.width/3, y: 0)
        },
                                   completion: { finished in
                                    src.present(dst, animated: false, completion: nil)
        }
        )
    }
}
