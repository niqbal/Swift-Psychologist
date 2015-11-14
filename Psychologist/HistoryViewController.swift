//
//  HistoryViewController.swift
//  Psychologist
//
//  Created by Nawab Zada Asad Iqbal on 11/13/15.
//  Copyright © 2015 Nawab Zada Asad Iqbal. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {


    @IBOutlet weak var historyTextView: UITextView! {
        didSet {
            historyTextView.text = historyString
        }
    }

    var historyString = "";
    
    func setHistory(hist : [Int]) {
        self.historyString = "\(hist)"
    }
    
    override var preferredContentSize : CGSize {
        get {
            if historyTextView != nil && presentingViewController != nil {
                return historyTextView.sizeThatFits(presentingViewController!.view.bounds.size)
            } else {
                return super.preferredContentSize
            }            
        }
        set { super.preferredContentSize = newValue }
    }
    
    
}
