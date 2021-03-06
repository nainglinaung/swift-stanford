//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Naing Lin Aung on 2/10/15.
//  Copyright (c) 2015 Naing Lin Aung. All rights reserved.
//

import Foundation
import Darwin


class CalculatorBrain{
    
    private enum Op{
        case Operend(Double)
        case UnaryOperation(String,Double ->Double)
        case BinaryOperation(String,(Double,Double) -> Double)
        
        var description: String {
            get{
                switch self {
                case .Operend(let operend):
                    return "\(operend)"
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                }
            }
        }
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
        knownOps["sin"] = Op.UnaryOperation("sin",sin)
        knownOps["cos"] = Op.UnaryOperation("cos",cos)
        knownOps["π"] =  Op.UnaryOperation("π"){ $0 * M_PI}
        
        //let brain = CalculatorBrain()
    }
    
  
    
    var program: AnyObject {
        // guaranteed to be a Property List
        get {
            return opStack.map {$0.description }
        }
        set {
            if let opSymbols =  newValue  as? Array<String> {
                var newOpStack = [Op]();
                for opSymbol in opSymbols {
                    if let op = knownOps[opSymbol] {
                        newOpStack.append(op)
                    } else if let operend = NSNumberFormatter().numberFromString(opSymbol)?.doubleValue {
                        newOpStack.append(.Operend(operend))
                    }
                    opStack = newOpStack
                }
            }
        }
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