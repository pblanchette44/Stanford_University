//
//  facialExpression.swift
//  Stanford_FaceIt
//
//  Created by Philippe Blanchette on 2017-02-12.
//  Copyright © 2017 Philippe Blanchette. All rights reserved.
//

import Foundation


struct facialExpression{
    
    
    enum Eyes: Int {
        case Open
        case Closed
        case Squinting
    }
    
    enum EyeBrows:Int{
        
        case Relaxed
        case Normal
        case Furrowed
        
        func moreRelaxedEyeBrow()-> EyeBrows{
            return EyeBrows(rawValue:rawValue-1) ?? .Relaxed
        }
        
        func moreFurrowedBrow() -> EyeBrows{
            return EyeBrows(rawValue:rawValue+1) ?? .Furrowed
        }
    }
    
    
    enum Mouth:Int{
        case Frown
        case Smirk
        case Neutral
        case Grin
        case Smile
        
        func sadderMouth() -> Mouth{
            return Mouth(rawValue:rawValue-1) ?? .Frown
        }
        
        func happierMouth() -> Mouth{
            return Mouth(rawValue:rawValue+1) ?? .Smile
        }
        
    }
    
    
    var eyes :Eyes
    var eyeBrows: EyeBrows
    var mouth :Mouth
}
