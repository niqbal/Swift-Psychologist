//
//  HappinessViewController.swift
//  Happiness
//
//  Created by Nawab Zada Asad Iqbal on 11/5/15.
//  Copyright © 2015 Nawab Zada Asad Iqbal. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource, UIPopoverPresentationControllerDelegate {
    var happiness : Int =  90 { //0 = very sad, 100 = ecstatic
        didSet {
            print("Happiness = \(happiness)");
            happiness = min(max(happiness,0),100)
            history.append(happiness)
            updateUI()
        }
    }
    
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    var history : [Int] {
        get {
            return defaults.objectForKey(Constants.HistoryKey) as? [Int] ?? [];
        }
        set {
            defaults.setObject(newValue, forKey: Constants.HistoryKey)
        }
    }
    
    func appendRecord(d: Int) {
        history.append(d);
    }
    
    
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return (Double(happiness - 50) / 50);
    }
    
    struct Constants {
        static let HistoryKey = "History Key";
        static let HappyFactor : CGFloat = 4;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let vc = segue.destinationViewController as? HistoryViewController {
            if let ppc = vc.popoverPresentationController {
                ppc.delegate = self
            }
            
            vc.setHistory(self.history)
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None;
    }
    
    @IBAction func panGestureReceived(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Changed: fallthrough
        case .Ended:
            let happinessChange = -Int(gesture.translationInView(faceView).y / Constants.HappyFactor)
            if happinessChange != 0 {
                happiness += happinessChange
                gesture.setTranslation(CGPointZero, inView: faceView)
            }
            
        default: break;
        }
    }
    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.faceViewDataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))            
        }
    }
    
    
    func updateUI() {
        faceView?.setNeedsDisplay()
        title = "\(happiness)"
    }
    

}
