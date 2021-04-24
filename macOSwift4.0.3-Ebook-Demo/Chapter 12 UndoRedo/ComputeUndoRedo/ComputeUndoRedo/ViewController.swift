//
//  ViewController.swift
//  ComputeUndoRedo
//
//  Created by iDevFans on 16/7/24.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var firstAddParaTextField: NSTextField!
    @IBOutlet weak var secondAddParaTextField: NSTextField!
    @IBOutlet weak var sumTextField: NSTextField!
    
    lazy var viewUndoManager: UndoManager = {
        let undoManager = UndoManager()
        return undoManager
    }()
    
    var para1:NSInteger = 0
    var para2:NSInteger = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.compute(para1: 1, para2: 2)
    }

    //计算按钮事件
    @IBAction func computeAction(_ sender: NSButton) {
        
        let para1 = self.firstAddParaTextField.integerValue
        let para2 = self.secondAddParaTextField.integerValue
        self.compute(para1: para1, para2: para2)
    }
    
    //Undo按钮对应的事件
    @IBAction func undoAction(_ sender: NSButton) {
        
        self.viewUndoManager.undo()
    }

    //Redo按钮对应的事件
    @IBAction func redoAction(_ sender: NSButton) {
        
        self.viewUndoManager.redo()
    }

    //执行计算的处理函数
    func compute(para1 firstPara: NSInteger,para2 secondPara: NSInteger) {
        let p1 = self.para1
        let p2 = self.para2
        if self.para1 == firstPara && self.para2 == secondPara {
            //return
        }
        else {
            self.viewUndoManager.compatibleRegisterUndo(withTarget: self) {targetSelf in
                targetSelf.compute(para1: p1, para2: p2)
                let actionName = "\(firstPara)+\(secondPara)"
                print("actionName = \(actionName)")
                targetSelf.viewUndoManager.setActionName(actionName)
                
            }
        }
        let ss = self.viewUndoManager.prepare(withInvocationTarget: self)
        print("ss = \(ss)")
        
        if let tar = ss as? ViewController {
             print("tar = \(tar)")
        }
        

        self.para1 = firstPara
        self.para2 = secondPara
        let sum = firstPara + secondPara
        
        self.firstAddParaTextField.integerValue = self.para1
        self.secondAddParaTextField.integerValue = self.para2
        self.sumTextField.integerValue = sum
        
    }

}


