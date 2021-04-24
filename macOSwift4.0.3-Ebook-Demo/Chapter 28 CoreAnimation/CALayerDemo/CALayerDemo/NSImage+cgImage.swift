//
//  NSImage+cgImage.swift
//  CALayerDemo
//
//  Created by iDevFans on 16/10/12.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

extension NSImage {
    var cgImage: CGImage {
        get {
            let imageData = self.tiffRepresentation
            let source = CGImageSourceCreateWithData(imageData as! CFData, nil)
            let maskRef = CGImageSourceCreateImageAtIndex(source!, 0, nil)
            return maskRef!
        }
    }
}
