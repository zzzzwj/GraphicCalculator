//
//  ThirdViewController.swift
//  GraphicCalculator
//
//  Created by Apple on 2017/5/20.
//  Copyright © 2017年 NJU. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var InputWindow: UICollectionView!
    @IBOutlet weak var OutputWindow: UITextView!
    
    @IBOutlet weak var AddRow: UIButton!
    @IBOutlet weak var AddColumn: UIButton!
    @IBOutlet weak var DelRow: UIButton!
    @IBOutlet weak var DelColumn: UIButton!
    
    var rownum:Int=0
    var columnnum:Int=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OutputWindow.layer.borderWidth=1
        OutputWindow.layer.borderColor=UIColor.black.cgColor
        
        InputWindow.register(TextCell.self, forCellWithReuseIdentifier: "cell")
        
        InputWindow.backgroundColor=UIColor.white
        InputWindow.setCollectionViewLayout(<#T##layout: UICollectionViewLayout##UICollectionViewLayout#>, animated: <#T##Bool#>)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*func numberofSectionsInCollectionView(collectionView: UICollectionView)->Int{
        return 1
    }*/
    
    /*func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section:Int)->Int {
        return 100
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class TextCell:UICollectionViewCell{
    var text:UITextView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        text=UITextView(frame:frame)
        self.addSubview(text!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var content:NSString{
        get{
            return text!.text! as NSString
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        text?.resignFirstResponder()
    }
}
