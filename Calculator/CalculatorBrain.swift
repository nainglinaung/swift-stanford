//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Naing Lin Aung on 2/10/15.
//  Copyright (c) 2015 Naing Lin Aung. All rights reserved.
//

import Foundation


class CalculatorBrain{
    
    private enum Op{
        case Operend(Double)
        case UnaryOperation(String,Double ->Double)
        case BinaryOperation(String,(Double,Double) -> Double)
    }
    
    private var opStack = [Op]();
    
    private var knownOps = [String:Op]()
    // dictionary
    
    init(){
        
        knownOps["+"] = Op.BinaryOperation("+",+)
        knownOps["−"] = Op.BinaryOperation("−") {$1 - $0}
        knownOps["×"] = Op.BinaryOperation("×",*)
        knownOps["÷"] = Op.BinaryOperation("÷") {$1 / $0}
        knownOps["√"] = Op.UnaryOperation("√",sqrt)
        
        
        //let brain = CalculatorBrain()
    }
    
    private func evaulate(ops:[Op]) ->(result:Double?, remainingOps:[Op])
    {
        if !ops.isEmpty {
            var remainingOps = ops;
            let op = remainingOps.removeLast();
            switch op{
            case .Operend(let operend):
                return (operend,remainingOps)
            case .UnaryOperation(_,let operation):
                let operendEvaluation = evaulate(remainingOps)
                if let operend = operendEvaluation.result {
                    return (operation(operend),operendEvaluation.remainingOps)
    
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaulate(remainingOps)
                if let operend1 = op1Evaluation.result {
                    let op2Evaluation = evaulate(op1Evaluation.remainingOps)
                    if let operend2 = op2Evaluation.result {
                        return (operation(operend1,operend2),op2Evaluation.remainingOps)
                    }
                }
            }
        }
            return (nil,ops)
    }
    
    
    func evaulate() -> Double? {
        let (result,remainder) = evaulate(opStack);
        return result
    }

    func pushOperend(operend: Double) -> Double? {
        opStack.append(Op.Operend(operend))
        return evaulate()
    }
    
    func performOperation(symbol: String) -> Double? {
        if let operation = knownOps[symbol] {
            opStack.append(operation);
        }
        return evaulate()
    }

}