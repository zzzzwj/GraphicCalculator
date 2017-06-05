//
//  Stack.swift
//  GraphicCalculator
//
//  Created by Apple on 2017/6/4.
//  Copyright © 2017年 NJU. All rights reserved.
//

import Foundation

class Stack{
    var stack:[AnyObject]
    
    init(){
        stack=[AnyObject]()
    }
    
    func push(object:AnyObject){
        stack.append(object)
    }
    
    func pop()->AnyObject?{
        if !isEmpty(){
            return stack.removeLast()
        }
        else{
            return nil;
        }
    }
    
    func isEmpty()->Bool{
        return stack.isEmpty
    }
    
    func peek()->AnyObject?{
        return stack.last
    }
    
    func size()->Int{
        return stack.count
    }
    
    func copy()->Stack{
        let tempStack:Stack=Stack()
        tempStack.stack=stack
        return tempStack
    }
    
    func clear(){
        stack.removeAll(keepingCapacity: false)
    }
}

func Operation(_ oper:String,_ arg1:Double,_ arg2:Double=0,_arg3:Double=0)->Double{
    switch oper{
    case "+":return arg1+arg2
    case "﹣":return arg1-arg2
    case "×":return arg1*arg2
    case "÷":return arg1/arg2
    case "^":return pow(arg1, arg2)
    case "!":return Double(factorial(Int(arg1)))
    case "sin":return sin(arg1)
    case "cos":return cos(arg1)
    case "tan":return tan(arg1)
    case "sin⁻¹":return asin(arg1)
    case "cos⁻¹":return acos(arg1)
    case "tan⁻¹":return atan(arg1)
    default:return 0
    }
}


func getOperatorPriority(_ oper:String)->Int{
    switch oper{
    case "+":return 1
    case "﹣":return 1
    case "×":return 2
    case "÷":return 2
    case "^":return 3
    case "!":return 4
    case "sin":return 4
    case "cos":return 4
    case "tan":return 4
    case "sin⁻¹":return 4
    case "cos⁻¹":return 4
    case "tan⁻¹":return 4
    default:return 0
    }
}

func getOperatorNum(_ oper:String)->Int{
    switch oper{
    case "+":return 2
    case "﹣":return 2
    case "×":return 2
    case "÷":return 2
    case "!":return 1
    case "^":return 2
    case "sin":return 1
    case "cos":return 1
    case "tan":return 1
    case "sin⁻¹":return 1
    case "cos⁻¹":return 1
    case "tan⁻¹":return 1
    default:return 0
    }
}

func factorial(_ arg1:Int)->Int{
    if arg1<0{
        return 0
    }
    else{
        var itr=arg1
        var sum:Int=1
        while itr>0{
            sum=sum*itr
            itr=itr-1
        }
        return sum
    }
}
