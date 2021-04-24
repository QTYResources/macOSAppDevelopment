//
//  CustomScrollView.swift
//  ScrollView
//
//  Created by iDevFans on 16/6/25.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

import Foundation
import AppKit

final class CustomScrollView: NSScrollView {
    override var isFlipped: Bool {
        get {
            return true
        }
    }
}
