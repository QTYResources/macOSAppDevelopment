//
//  UndoManager.swift
//  ComputeUndoRedo
//
//  Created by iDevFans on 2017/1/7.
//  Copyright © 2017年 chinamums. All rights reserved.
//
import Cocoa

extension UndoManager
{
    /// Registers an undo operation using a closure. Behaves in the same wasy as
    /// `registerUndo(withTarget:handler)` but it compatible with older OS versions.
    func compatibleRegisterUndo<TargetType : AnyObject>(withTarget target: TargetType, handler: @escaping (TargetType) -> ())
    {
        if #available(iOS 9.0, macOS 10.11, *)
        {
            self.registerUndo(withTarget: target, handler: handler)
        }
        else
        {
            let operation = BlockOperation {
                handler(target)
            }
            self.registerUndo(withTarget: self, selector: #selector(UndoManager.performUndo(operation:)), object: operation)
        }
    }
    
    /// Performs an undo operation after it has been registered
    /// by `compatibleRegisterUndo`. Should not be called directly.
    @objc func performUndo(operation: Operation)
    {
        operation.start()
    }
}
