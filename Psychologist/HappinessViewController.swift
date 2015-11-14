//
//  HappinessViewController.swift
//  Happiness
//
//  Created by Nawab Zada Asad Iqbal on 11/5/15.
//  Copyright © 2015 Nawab Zada Asad Iqbal. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource {
    var happiness : Int =  90 { //0 = very sad, 100 = ecstatic
        didSet {
            print("Happiness = \(happiness)");
            happiness = min(max(happiness,0),100)
            updateUI()
        }
    }
    
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return (Double(happiness - 50) / 50);
    }
    
    struct Constants {
        static let HappyFactor : CGFloat = 4;
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
