//
//  Segues.swift
//  BnS_Info
//
//  Created by 표영권 on 2017. 5. 25..
//  Copyright © 2017년 Jihye Jegal. All rights reserved.
//

import UIKit

class left: UIStoryboardSegue {
    
    override func perform()
    {
        //ViewContoroller
        let src = self.source as UIViewController
        // LeftViewController
        let dst = self.destination as UIViewController
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        
        // LeftViewController 초기 위치
        dst.view.transform = CGAffineTransform(translationX: -src.view.frame.size.width, y: 0)
        
        //애니메이션 실행
        UIView.animate(withDuration: 0.25,
                                   delay: 0.0,
                                   options: UIViewAnimationOptions.curveEaseInOut,
                                   animations: {
                                    // 이동할 위치
                                    dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
                                    // ViewController 이동할 위치
                                    src.view.transform = CGAffineTransform(translationX: src.view.frame.size.width/3, y: 0)
                                    
                                },
                                   completion: { finished in
                                    // 애니메이션 완료 후 실행
                                    src.present(dst, animated: false, completion: nil)
                                }
                        )
    }
}

// LeftViewController  뷰 닫기
class Unwind_left: UIStoryboardSegue {
    
    override func perform()
    {
        //ViewContoroller
        let src = self.source as UIViewController
        //LeftViewController
        let dst = self.destination as UIViewController
        
        src.view.superview?.insertSubview(dst.view, belowSubview: src.view)
        
        // LeftViewController 초기 위치
        src.view.transform = CGAffineTransform(translationX: 0, y: 0)
        // ViewController 초기 위치
        dst.view.transform = CGAffineTransform(translationX: src.view.frame.size.width/3, y: 0)
        
        UIView.animate(withDuration: 0.25,
                                   delay: 0.0,
                                   options: UIViewAnimationOptions.curveEaseInOut,
                                   animations: {
                                    // LeftViewController 이동할 위치
                                    src.view.transform = CGAffineTransform(translationX: -src.view.frame.size.width, y: 0)
                                    // ViewController 이동할 위치
                                    dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
                                    
                                },
                                   completion: { finished in
                                    // 애니메이션 완료 후 LeftViewController 없애기
                                    src.dismiss(animated: false, completion: nil)
                                }
                        )
    }
    
}
