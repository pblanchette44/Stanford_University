//
//  graphView.swift
//  calculator_Stanford
//
//  Created by Philippe Blanchette on 2017-02-14.
//  Copyright © 2017 Philippe Blanchette. All rights reserved.
//

import UIKit

class graphView: UIView {

    @IBInspectable
    var graphUnit = 20
    
    private struct ratios{
        static var barSize = 3
        
    }
    

    private func graphBar() -> UIBezierPath{
        
        let path = UIBezierPath()
        
        path.move(to: center)
        
        var direction = Int(Int(center.x)/graphUnit)
        
        for index in 0 ... graphUnit {
            path.move(to: CGPoint(x:Int(direction*index),y:Int(center.y)))
            path.addLine(to:
                CGPoint(x:Int(path.currentPoint.x)+ratios.barSize,
                        y:Int(center.y)
                )
            )
        }
        
        path.move(to: CGPoint(x:frame.maxX,y:center.y))
        
        for index in 0 ... graphUnit {
            path.move(to: CGPoint(x:Int(frame.maxX)-Int(direction*index),y:Int(center.y)))
            path.addLine(to:
                CGPoint(x:Int(path.currentPoint.x)-ratios.barSize,
                        y:Int(center.y)
                )
            )
        }

        path.move(to: center)
        direction = Int(Int(center.y)/graphUnit)
        
        for index in 0 ... graphUnit {
            path.move(to: CGPoint(x:Int(center.x),y:Int(direction*index)))
            path.addLine(to:
                CGPoint(x:Int(center.x),
                        y:Int(path.currentPoint.y)+ratios.barSize
                )
            )
        }
        
        path.move(to: center)
        
        for index in 0 ... graphUnit {
            path.move(to: CGPoint(x:Int(center.x),y:Int(frame.maxY)-Int(direction*index)))
            path.addLine(to:
                CGPoint(x:Int(center.x),
                        y:Int(path.currentPoint.y)-ratios.barSize
                )
            )
        }

        
        return path
    }
    
    
    override func draw(_ rect: CGRect) {
   
        graphBar().stroke()
    }
   

}
