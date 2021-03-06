//
//  CalculatorBrain.swift
//  calculator_Stanford
//
//  Created by Philippe Blanchette on 2017-02-09.
//  Copyright © 2017 Philippe Blanchette. All rights reserved.
//

import Foundation

//func multiply
class CalculatorBrain {
    
    private var accumulator = 0.0
    var description :String?
    var isPartialResult: Bool = false
    
    func setOperand(operand: Double) {
        updateDescription(input: String(operand))
        accumulator = operand
    }
    
    private var operations:Dictionary<String,Operation> = [
        "π":    Operation.Constant(M_PI),
        "√":    Operation.UnaryOperation(sqrt),
        "e":    Operation.Constant(M_E),
        "cos":  Operation.UnaryOperation(cos),
        "*":    Operation.BinaryOperation({$0*$1}),
        "+":    Operation.BinaryOperation({$0 + $1}),
        "-":    Operation.BinaryOperation({$0 - $1}),
        "/":    Operation.BinaryOperation({$0 / $1}),
        "=":    Operation.Equals,
        "C":    Operation.Reset,
        "+/-":  Operation.UnaryOperation({$0 * -1}),
        "%":    Operation.UnaryOperation({$0 / 100}),
        "10ⁿ":  Operation.UnaryOperation({pow(10, $0)}),
        "x²":   Operation.UnaryOperation({pow($0, 2)})
    ]
    
    
    func performOperation(symbol:String){
        
        if let operation = operations[symbol] {
            
            if symbol != "=" {
                updateDescription(input: symbol)
            }
            
            switch operation{
            case    .Constant(let value):
                        accumulator = value
            case    .UnaryOperation(let function):
                        accumulator = function(accumulator)
            case    .BinaryOperation(let function):
                        executePendingBinaryOperation()
                        pendingOperation = PendingBinaryOperationInfo(
                                                    binaryFunction:function,
                                                    firstOperand:accumulator)
            case    .Equals:
                        executePendingBinaryOperation()
            case    .Reset:
                        accumulator = 0.0
                        description = ""
                        pendingOperation = nil
                
            }
        }
    }
    
    
    private func executePendingBinaryOperation(){
        if pendingOperation != nil{
            accumulator = pendingOperation!.binaryFunction(pendingOperation!.firstOperand,accumulator)
            pendingOperation = nil
        }
    }
    

    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double)->Double)
        case BinaryOperation((Double,Double)->Double)
        case Equals
        case Reset
    }
    
    private var pendingOperation :PendingBinaryOperationInfo?
        
        struct PendingBinaryOperationInfo{
            var binaryFunction: (Double,Double)->Double
            var firstOperand: Double
        }
        
    private func updateDescription(input:String){
        
        if description != nil {
            description = description! + input
        } else {
            description = input
        }
        print(description!)
    }
    
    
    
    var result: Double {
        get{
            return accumulator
        }
    }
    
    
}
