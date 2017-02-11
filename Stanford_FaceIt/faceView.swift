//
//  faceView.swift
//  Stanford_FaceIt
//
//  Created by Philippe Blanchette on 2017-02-11.
//  Copyright © 2017 Philippe Blanchette. All rights reserved.
//

import UIKit

class faceView: UIView {

    
    var scale:CGFloat = 0.90
    
    var skullRadius:CGFloat{
        return min(bounds.size.width,bounds.size.height)/2
    }
    var skullCenter:CGPoint{
        return CGPoint(x:bounds.midX,y:bounds.midY)
    }
    
    
    private struct Ratios{
        
        static let SkullRadiusToEyeOffset: CGFloat = 3
        static let SkullRadiusToEyeRadius: CGFloat = 10
        static let SkullRadiusToMouthWidth: CGFloat = 1
        static let SkullRadiusToMouthHeight: CGFloat = 3
        static let SkullRadiusToMouthOffset: CGFloat = 3
    }
    
    private enum Eye {
        case Left
        case Right
    }
    
    private func pathForCircleCenteredAtPoint(midPoint:CGPoint,withRadius radius:CGFloat)->UIBezierPath
    {
    let path = UIBezierPath(
        arcCenter: midPoint,
        radius: radius,
        startAngle: 0.0,
        endAngle: CGFloat(2*M_PI),
        clockwise: false)
        
    path.lineWidth = 5.0
        
    return path
    }
    
    private func getEyeCenter(eye:Eye)->CGPoint{
    
    let eyeOffset = skullRadius/Ratios.SkullRadiusToEyeOffset
    var eyeCenter = skullCenter
    eyeCenter.y -= eyeOffset
        
    switch eye {
        case .Right: eyeCenter.x -= eyeOffset
        case .Left:eyeCenter.x += eyeOffset
    }
        
    return eyeCenter
    }
    
    private func pathForEye(eye:Eye)->UIBezierPath
    {
        let eyeRadius = skullRadius/Ratios.SkullRadiusToEyeRadius
        let eyeCenter = getEyeCenter(eye: eye)
        return pathForCircleCenteredAtPoint(midPoint: eyeCenter, withRadius: eyeRadius)
    }
    
    
    override func draw(_ rect: CGRect) {
        
        UIColor.blue.set()
        pathForCircleCenteredAtPoint(midPoint: skullCenter, withRadius: skullRadius).stroke()
        pathForEye(eye: .Left).stroke()
        pathForEye(eye: .Right).stroke()
        
    }
    

}
