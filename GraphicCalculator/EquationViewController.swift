//
//  EquationViewController.swift
//  GraphicCalculator
//
//  Created by Apple on 2017/5/21.
//  Copyright © 2017年 NJU. All rights reserved.
//

import UIKit
import GLKit

class openglView:GLKView, GLKViewDelegate{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.context=EAGLContext.init(api: EAGLRenderingAPI.openGLES2)
        glClearColor(0.0, 1.0, 0.0, 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
    }
    
    override func draw(_ rect: CGRect) {
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
    }
    
}

class EquationViewController: UIViewController {

    @IBOutlet weak var DrawWindow: openglView!
    @IBOutlet weak var InputEquation: UITextView!
    @IBOutlet weak var OutputRes: UITextView!
    @IBOutlet weak var Complete: UIButton!
    
    @IBAction func Solve(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //注册键盘通知
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        //设置TextView为圆角矩形
        InputEquation.layer.borderColor=UIColor(red:60/255,green:40/255,blue:129/255,alpha:1).cgColor
        InputEquation.layer.borderWidth=1
        //InputEquation.layer.cornerRadius=4
        
        OutputRes.layer.borderColor=UIColor(red:60/255,green:40/255,blue:129/255,alpha:1).cgColor
        OutputRes.layer.borderWidth=1
        //OutputRes.layer.cornerRadius=4
        
        //设置GLView的边框
        DrawWindow.layer.borderColor=UIColor.black.cgColor
        DrawWindow.layer.borderWidth=1
        
        EAGLContext.setCurrent(DrawWindow.context)
        glClearColor(1.0, 0.0, 0.0, 1.0)
        
        //glkView(DrawWindow, drawIn: DrawWindow.frame)
    }
    
    func DrawFunc(){
        //DrawWindow.draw(<#T##rect: CGRect##CGRect#>)
        //glLoadIdentity()
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT))
        glClearColor(0.0, 1.0, 1.0, 1.0)
        
        /*glColor4f(0.0, 0.0, 0.0, 1.0)
        let vertices:[GLfloat]=[-0.5,-0.5,0.5,0.5]
        glLineWidth(2.0)
        glVertexPointer(2, GLenum(GL_FLOAT), 0, vertices)
        glDrawArrays(GLenum(GL_LINES), 0, 2)*/
        
        glFlush()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func keyboardWillShow(_ notification:Notification){
        let kbInfo=notification.userInfo
        let kbRect=(kbInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let offset=(InputEquation.frame.origin.y+InputEquation.frame.size.height+10)-(self.view.frame.size.height-kbRect.origin.y)
        let duration=kbInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        UIView.animate(withDuration: duration){
            self.view.transform=CGAffineTransform(translationX:0,y:offset)
        }
    }
    
    func keyboardWillHide(_ notification:NSNotification){
        let kbinfo=notification.userInfo
        let duration=kbinfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        UIView.animate(withDuration: duration){
            self.view.transform=CGAffineTransform(translationX:0,y:0)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.InputEquation.resignFirstResponder()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
