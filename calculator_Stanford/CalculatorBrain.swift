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
    
    private var internalProgram = [AnyObject]()
    
    func setOperand(operand: Double) {
        updateDescription(input: String(operand))
        accumulator = operand
        internalProgram.append(operand as AnyObject)
    }
    
    var variableValues : Dictionary<String,Double> = ["x":0.0]
    
    func setOperand(variableName:String){
        
        updateDescription(input: variableName)
        accumulator = variableValues[variableName]!
        internalProgram.append(variableName as AnyObject)
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
        "x²":   Operation.UnaryOperation({pow($0, 2)})
    ]
    
    
    func performOperation(symbol:String){
        internalProgram.append(symbol as AnyObject)
        
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
                        description = " "
                        pendingOperation = nil
                        variableValues = ["x":0.0]
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
    }
    
    
    typealias PropertyList = AnyObject
    
    var program:PropertyList{
        get{
            return internalProgram as CalculatorBrain.PropertyList
        } set{
            performOperation(symbol: "C")
            if let arrayOfOps = newValue as? [AnyObject]{
                for op in arrayOfOps{
                    if let operand = op as? Double {
                        setOperand(operand: operand)
                    } else if let operation = op as? String {
                        performOperation(symbol: operation)
                    }
                }
            }
        }
    }
    
    
    
    var result: Double {
        get{
            return accumulator
        }
    }
    
    
}
