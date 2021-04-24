//
//  ScrollView.swift
//  NSViewController
//
//  Created by iDevFans on 16/7/14.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class ScrollView: NSScrollView {

    override func updateConstraints(){
        
         Swift.print("NSScrollView updateConstraints")
        super.updateConstraints()
    }
}
