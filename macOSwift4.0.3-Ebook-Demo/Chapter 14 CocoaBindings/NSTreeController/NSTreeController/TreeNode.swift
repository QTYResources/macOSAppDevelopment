//
//  TreeNode.swift
//  NSTreeController
//
//  Created by iDevFans on 16/7/29.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class TreeNode: NSObject {
    var nodeName:String?      //名称
    var count: NSInteger      //子节点个数
    var isLeaf: Bool          //是否叶子节点
    var children:[TreeNode]   //子节点
    
    override init() {
        count = 0
        isLeaf = true
        children = []
        super.init()
    }
}
