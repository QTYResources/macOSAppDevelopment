//
//  ViewController.swift
//  NSDatePicker
//
//  Created by iDevFans on 16/6/29.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

import Cocoa

class ViewController: NSViewController,NSDatePickerCellDelegate {

    @IBOutlet weak var datePicker: NSDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func valuedChangedAction(_ sender: NSDatePicker) {
        let date = sender.dateValue
        print("date:\(date)")
    }

    // MARK: NSDatePickerCellDelegate
    
    func datePickerCell(_ datePickerCell: NSDatePickerCell, validateProposedDateValue proposedDateValue: AutoreleasingUnsafeMutablePointer<NSDate>, timeInterval proposedTimeInterval: UnsafeMutablePointer<TimeInterval>?) {
        
        let timeInterval = proposedTimeInterval?.pointee
       
        self.datePicker.timeInterval = timeInterval!
    }
}





