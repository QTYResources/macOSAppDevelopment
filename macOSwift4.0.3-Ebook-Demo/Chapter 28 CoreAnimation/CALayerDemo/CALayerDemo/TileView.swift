//
//  TileView.swift
//  CALayerDemo
//
//  Created by iDevFans on 16/10/12.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class TileView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    override func makeBackingLayer() -> CALayer {
        let tileLayer = CATiledLayer()
        tileLayer.tileSize = CGSize(width: 60, height: 60)
        tileLayer.delegate = self
        return tileLayer
    }
}

extension TileView: CALayerDelegate {
    
    func draw(_ layer: CALayer, in ctx: CGContext) {
        let tileLayer = layer as! CATiledLayer
        let bounds =  ctx.boundingBoxOfClipPath
        let row = floor(bounds.origin.x / tileLayer.tileSize.width)
        let col = floor(bounds.origin.y / tileLayer.tileSize.height)
        let r = CGFloat(arc4random() % 255) / 255.0
        let g = CGFloat(arc4random() % 255) / 255.0
        let b = CGFloat(arc4random() % 255) / 255.0
        let fillColor = NSColor(calibratedRed: r, green: g, blue: b, alpha: 1)
        ctx.setFillColor(fillColor.cgColor)
        ctx.fill(bounds)
        NSLog("row= \(row) col = \(col) bounds ＝ \(bounds) ")
    }

}
