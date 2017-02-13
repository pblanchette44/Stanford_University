//
//  emotionsViewController.swift
//  Stanford_FaceIt
//
//  Created by Philippe Blanchette on 2017-02-12.
//  Copyright © 2017 Philippe Blanchette. All rights reserved.
//

import UIKit

class emotionsViewController: UIViewController {

    private let emotionalFaces: Dictionary<String,facialExpression> = [
    "angry":facialExpression(eyes:.Closed, eyeBrows:.Furrowed,mouth: .Frown),
    "happy":facialExpression(eyes:.Open, eyeBrows:.Furrowed,mouth: .Smile),
    "worried":facialExpression(eyes:.Closed, eyeBrows:.Furrowed,mouth: .Smirk),
    "mischievous":facialExpression(eyes:.Closed, eyeBrows:.Furrowed,mouth: .Grin)
    ]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   
        var destinationvc = segue.destination
        
        if let navcon = destinationvc as? UINavigationController{
            destinationvc = navcon.visibleViewController ?? destinationvc
        }
        if let facevc = destinationvc as? FaceViewController{
            if let identifier = segue.identifier{
                if let expression = emotionalFaces[identifier]{
                    facevc.expression = expression
                    if let sendingButton = sender as? UIButton{
                        facevc.navigationItem.title = sendingButton.currentTitle
                    }
                }
            }
            }
        }
}
   


