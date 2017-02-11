//
//  faceView.swift
//  Stanford_FaceIt
//
//  Created by Philippe Blanchette on 2017-02-11.
//  Copyright © 2017 Philippe Blanchette. All rights reserved.
//

import UIKit

class faceView: UIView {

    override func draw(_ rect: CGRect) {
        
        var skullRadius = min(bounds.size.width,bounds.size.height)/2
        var skullCenter = CGPoint(x:bounds.midX,y:bounds.midY)
        
        let skull = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0.0, endAngle: CGFloat(2*M_PI), clockwise: false)
    
        skull.lineWidth = 5.0
        UIColor.blue.set()
        
        skull.stroke()
        
    }
    

}
