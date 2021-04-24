//
//  String+Component.swift
//  LocalizationTools
//
//  Created by iDevFans on 16/9/2.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Foundation

extension String {

    func deletingLastPathComponent() ->String {
        return (self as NSString).deletingLastPathComponent
    }
    
    func lastPathComponent() ->String {
        return (self as NSString).lastPathComponent
    }
    
    func deletingPathExtension() ->String {
        return (self as NSString).deletingPathExtension
    }
    
    func appendingPathComponent(path: String) ->String {
        return (self as NSString).appendingPathComponent(path) as String
    }
    
}
