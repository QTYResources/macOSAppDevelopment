//
//  ViewController.swift
//  HTTPCookie
//
//  Created by iDevFans on 16/9/28.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa




class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let cookie = HTTPCookie(properties: [HTTPCookiePropertyKey.domain:".reddit.com",
                                             HTTPCookiePropertyKey.path:"/",
                                             HTTPCookiePropertyKey.path:"__cfduid",
                                        HTTPCookiePropertyKey.path:"d9bd1fa536e04314a996b04554849dc811455934534",
            
            
            ])
        
        
        HTTPCookieStorage.shared.setCookie(cookie!)
      
       
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                HTTPCookieStorage.shared.deleteCookie(cookie)
            }
        }
        
        
        
        
      
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

