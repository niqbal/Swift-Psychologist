//
//  ViewController.swift
//  Psychologist
//
//  Created by Nawab Zada Asad Iqbal on 11/7/15.
//  Copyright © 2015 Nawab Zada Asad Iqbal. All rights reserved.
//

import UIKit

class PsychologistViewController: UIViewController {

    @IBAction func nothingAction(sender: AnyObject) {
        performSegueWithIdentifier("nothing", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var vc = segue.destinationViewController as? HappinessViewController
        
        if let tvc = segue.destinationViewController as? UINavigationController {
            vc = tvc.visibleViewController as? HappinessViewController
        }
        
        if vc != nil {
            if let segueType = segue.identifier {
                switch segueType {
                    case "showHappy" :
                        vc!.happiness = 100;
                    case "showSad" :
                        vc!.happiness = 0;
                    case "nothing" :
                        vc!.happiness = 25;
                    default:
                        vc!.happiness = 50;
                }
            }
        }
    }
}

