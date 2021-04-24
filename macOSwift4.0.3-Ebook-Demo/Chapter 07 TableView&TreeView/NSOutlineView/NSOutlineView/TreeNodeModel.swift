//
//  TreeNodeModel.swift
//  NSOutlineView
//
//  Created by iDevFans on 16/7/11.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class TreeNodeModel: NSObject {
    var name: String?
    lazy var childNodes: Array = {
        return [TreeNodeModel]()
    }()
}
