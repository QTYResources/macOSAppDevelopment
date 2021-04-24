//
//  CustomTableView.swift
//  NSTableViewCustomBackgroud
//
//  Created by iDevFans on 16/10/17.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class CustomTableView: NSTableView {
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

    }
    private func
        alternateBackgroundColor() -> NSColor? {
        return NSColor.darkGray // Return any color you like
    }
    
    override func drawBackground(inClipRect clipRect: NSRect) {
        
       // super.drawBackground(inClipRect:clipRect)
        
        NSColor.green.setFill()
        
        clipRect.fill()
        
        return
        NSLog("clipRect = \(clipRect)")
        NSLog("bounds = \(self.bounds)")
        //self.backgroundColor = NSColor.white
        if alternateBackgroundColor() == nil {
            // If we didn't set the alternate colour, fall back to the default behaviour
            super.drawBackground(inClipRect:clipRect)
        } else {
            // Fill in the background colour
            self.backgroundColor.set()
            clipRect.fill()
            
            // Check if we should be drawing alternating coloured rows
            if !usesAlternatingRowBackgroundColors {
                // Set the alternating background colour
                alternateBackgroundColor()!.set()
                
                // Go through all of the intersected rows and draw their rects
                var checkRect = bounds
                checkRect.origin.y = clipRect.origin.y
                checkRect.size.height = clipRect.size.height
                let rowsToDraw = rows(in: checkRect)
                
                var curRow = rowsToDraw.location
                
                repeat {
                    if curRow % 2 != 0 {
                        // This is an alternate row
                        var rowRect = rect(ofRow: curRow)
                      
                        rowRect.origin.x = clipRect.origin.x
                        rowRect.size.width = clipRect.size.width
                        
                        NSColor.headerColor.set()
                        
                        rowRect.fill()
                    }
                    
                    curRow = curRow + 1
                    
                    NSLog("curRow = \(curRow)")
                    
                } while curRow < rowsToDraw.location + rowsToDraw.length
                
                // Figure out the height of "off the table" rows
                var thisRowHeight = rowHeight
                if gridStyleMask.contains(NSTableView.GridLineStyle.solidHorizontalGridLineMask)
                    || gridStyleMask.contains(NSTableView.GridLineStyle.dashedHorizontalGridLineMask) {
                    thisRowHeight += 2.0 // Compensate for a grid
                }
                
                // Draw fake rows below the table's last row
                var virtualRowOrigin = 0.0 as CGFloat
                var virtualRowNumber = numberOfRows
                if numberOfRows > 0 {
                    let finalRect = rect(ofRow: numberOfRows-1)
                    virtualRowOrigin = finalRect.origin.y + finalRect.size.height
                }
                repeat {
                    if virtualRowNumber % 2 != 0 {
                        // This is an alternate row
                        let virtualRowRect = NSRect(x: clipRect.origin.x, y: virtualRowOrigin, width: clipRect.size.width, height: thisRowHeight)
                        NSColor.blue.set()
                        virtualRowRect.fill()
                    }
                    
                    virtualRowNumber = virtualRowNumber + 1
                    virtualRowOrigin += thisRowHeight
                    
                    NSLog("virtualRowNumber = \(virtualRowNumber)")
                    
                } while virtualRowOrigin < clipRect.origin.y + clipRect.size.height
                
                // Draw fake rows above the table's first row
                virtualRowOrigin = -1 * thisRowHeight
                virtualRowNumber = -1
                repeat {
                    if abs(virtualRowNumber) % 2 != 0 {
                        // This is an alternate row
                        let virtualRowRect = NSRect(x: clipRect.origin.x, y: virtualRowOrigin, width: clipRect.size.width, height: thisRowHeight)
                         NSColor.red.set()
                        virtualRowRect.fill()
                    }
                    
                    virtualRowNumber = virtualRowNumber - 1
                    virtualRowOrigin -= thisRowHeight
                    NSLog("virtualRowNumber2 = \(virtualRowNumber)")
                    
                } while virtualRowOrigin + thisRowHeight > clipRect.origin.y
            }
        }
    }
}

