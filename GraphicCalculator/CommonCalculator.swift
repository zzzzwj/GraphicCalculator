//
//  FirstViewController.swift
//  GraphicCalculator
//
//  Created by Apple on 2017/5/20.
//  Copyright © 2017年 NJU. All rights reserved.
//

import UIKit

class CommonCalculatorViewController: UIViewController {
    
    var negative:Bool=false
    var dig:Bool=false
    var newval:Bool=true
    var finish:Bool=true
    
    var NumStack:Stack=Stack()
    var OperStack:Stack=Stack()
    var CurrentOper:String?=nil
    var CurrentNum:Double=0
    
    
    @IBOutlet weak var ExpressionMonitor: UILabel!
    @IBOutlet weak var ResultMonitor: UILabel!
    
    @IBAction func PerformAction(_ sender: UIButton) {
        dig=false
        if finish{
            ExpressionMonitor.text!=""
            finish=false
        }
        CurrentNum=(ResultMonitor.text! as NSString).doubleValue
        if CurrentOper==nil{
            ExpressionMonitor.text!=ExpressionMonitor.text!+(CurrentNum as NSNumber).stringValue
        }
        else{
            ExpressionMonitor.text!=ExpressionMonitor.text!+CurrentOper!+(CurrentNum as NSNumber).stringValue
        }
        CurrentOper=sender.currentTitle
        if OperStack.isEmpty(){
            OperStack.push(object: CurrentOper! as AnyObject)
            NumStack.push(object: CurrentNum as AnyObject)
            newval=true
            return
        }
        NumStack.push(object: CurrentNum as AnyObject)
        if getOperatorPriority(CurrentOper!)<=getOperatorPriority(OperStack.peek()as! String){
            while !OperStack.isEmpty() && getOperatorPriority(CurrentOper!)<=getOperatorPriority(OperStack.peek() as! String){
                let oper=OperStack.pop() as! String
                let rightnum=NumStack.pop() as! Double
                let n=getOperatorNum(oper)
                switch n{
                case 1:NumStack.push(object: Operation(CurrentOper!,rightnum) as AnyObject)
                case 2:
                    let leftnum=NumStack.pop() as! Double
                    NumStack.push(object: Operation(oper,leftnum,rightnum) as AnyObject)
                case 3:
                    let leftnum=NumStack.pop() as! Double
                    NumStack.push(object: Operation(oper,leftnum,rightnum) as AnyObject)
                default:NumStack.push(object: 0 as AnyObject)
                }
            }
        }
        ResultMonitor.text!=(Calculate(OperStack.copy(), NumStack.copy()) as NSNumber).stringValue
        newval=true
        OperStack.push(object: CurrentOper! as AnyObject)
    }
    
    @IBAction func GetAnswer(_ sender: UIButton) {
        CurrentNum=(ResultMonitor.text! as NSString).doubleValue
        if CurrentOper==nil{
            ExpressionMonitor.text!=ExpressionMonitor.text!+(CurrentNum as NSNumber).stringValue+"="
        }
        else{
            ExpressionMonitor.text!=ExpressionMonitor.text!+CurrentOper!+(CurrentNum as NSNumber).stringValue+"="
        }
        CurrentOper=nil
        NumStack.push(object: CurrentNum as AnyObject)
        ResultMonitor.text!=(Calculate(OperStack, NumStack) as NSNumber).stringValue
        newval=true
        finish=true
    }
    
    @IBAction func TouchAC(_ sender: UIButton) {
        ExpressionMonitor.text!=""
        ResultMonitor.text!="0"
        dig=false
        negative=false
        newval=true
        CurrentOper=nil
        NumStack.clear()
        OperStack.clear()
    }
    
    @IBAction func AddDigit(_ sender: UIButton) {
        if finish{
            ExpressionMonitor.text!=""
            finish=false
        }
        let digit=sender.currentTitle
        let str=ResultMonitor.text
        switch digit! {
        case "±":
            if negative{
                var num=(str! as NSString).doubleValue
                num=num*(-1)
                ResultMonitor.text!=(num as NSNumber).stringValue
                negative=false
            }
            else{
                ResultMonitor.text!="-"+str!
                negative=true
            }
        case "%":
            let val=ResultMonitor.text! as NSString
            ResultMonitor.text!="\(val.doubleValue/100)"
        case ".":
            if newval{
                ResultMonitor.text!="0."
                newval=false
            }
            else if !dig{
                ResultMonitor.text!=ResultMonitor.text!+"."
                dig=true
            }
        case "0":
            let val=(ResultMonitor.text! as NSString).doubleValue
            if dig{
                ResultMonitor.text!=ResultMonitor.text!+"0"
            }
            else if val != 0{
                ResultMonitor.text!=ResultMonitor.text!+"0"
            }
        default:
            if newval{
                ResultMonitor.text!=digit!
                newval=false
            }
            else{
                ResultMonitor.text!=ResultMonitor.text!+digit!
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.hidesBottomBarWhenPushed=true
        //self.tabBarController?.tabBar.isHidden=true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func Calculate(_ operstack:Stack,_ numstack:Stack)->Double{
        while !operstack.isEmpty(){
            let oper=operstack.pop() as! String
            let n=getOperatorNum(oper)
            let rightnum=numstack.pop() as! Double
            switch n{
            case 1:numstack.push(object: Operation(oper,rightnum) as AnyObject)
            case 2:
                let leftnum=numstack.pop() as! Double
                numstack.push(object: Operation(oper,leftnum,rightnum) as AnyObject)
            case 3:
                let leftnum=numstack.pop() as! Double
                numstack.push(object: Operation(oper,leftnum,rightnum) as AnyObject)
            default:return 0
            }
        }
        return numstack.pop() as! Double
    }
    
}

