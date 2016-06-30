//
//  CalculatorBrain.swift
//  calculator
//
//  Created by Lance Fan on 16/6/30.
//  Copyright © 2016年 Lance Fan. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    private enum Op: CustomStringConvertible
    {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String,(Double,Double) -> Double)
        
        var description: String{
            get{
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol,_):
                    return symbol
                case .BinaryOperation(let symbol,_):
                    return symbol
                }
            }
        }
    }
    
    private var opStack = [Op]()
    
    private var knownOps = [String:Op]()
    
    init(){
        
        func learnOp (op:Op){
            knownOps[op.description] = op
        }
        learnOp(Op.BinaryOperation("×",*))
        learnOp(Op.BinaryOperation("÷"){$1 / $0})
        learnOp(Op.BinaryOperation("+",+))
        learnOp(Op.BinaryOperation("−"){$1 - $0})
        learnOp(Op.UnaryOperation("√",sqrt))
    }
    
    private func evaluate(ops: [Op]) -> (result: Double?,remainOps:[Op]){
        if !ops.isEmpty {
            var remainOps = ops
            let op = remainOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand,remainOps)
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainOps)
                if let operand = operandEvaluation.result{
                    return (operation(operand),operandEvaluation.remainOps)
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainOps)
                if let operand1 = op1Evaluation.result{
                    let op2Evaluation = evaluate(op1Evaluation.remainOps)
                    if let operand2 = op2Evaluation.result{
                        return (operation(operand1,operand2),op2Evaluation.remainOps)
                    }
                }
            }
        }
        return (nil,ops)
    }
    
    func evaluate() -> Double?{
        let (result,reminder) = evaluate(opStack)
        print("\(opStack) = \(result) with \(reminder) left over")
        return result
    }
    
    func pushOperand(operand: Double) -> Double?{
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation (symbol:String) -> Double?{
        if let operation = knownOps[symbol]{
            opStack.append(operation)
        }
        return evaluate()
    }
}
