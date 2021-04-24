//
//  String+Replace.swift
//  OpenMacX
//
//  Created by iDevFans on 16/9/4.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Foundation


extension String {
    func replace(target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString, options: .literal, range: nil)
    }
}
