//
//  ViewController.swift
//  Stanford_FaceIt
//
//  Created by Philippe Blanchette on 2017-02-11.
//  Copyright © 2017 Philippe Blanchette. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {

    var expression: facialExpression = facialExpression(
        eyes: .Open,
        eyeBrows: .Normal,
        mouth: .Smirk
    ) {didSet{updateUI()}}
    
    
    @IBOutlet var faceView: faceView! {
        didSet{
            updateUI()
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView,action: #selector(faceView.changeScale(recognizer:))))
        }
    }
    
    
    //Mouth dictionnary
    private var mouthCurvatures = [
    facialExpression.Mouth.Frown: -1.0,
    .Grin:0.5,
    .Smile:1.0,
    .Smirk:-0.5,
    .Neutral:0.0]
    
    
    private func updateUI(){
        switch expression.eyes{
            case .Open:
                faceView.eyesOpen = true
            case .Closed:
                faceView.eyesOpen = false
            case .Squinting:
                faceView.eyesOpen = false
        }
        faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
    }
    
    
    
    
}

