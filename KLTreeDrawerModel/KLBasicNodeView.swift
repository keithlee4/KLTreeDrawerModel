//
//  KLBasicNodeView.swift
//  KLTreeDrawerModel
//
//  Created by keith.lee on 2016/10/4.
//  Copyright © 2016年 Keith. All rights reserved.
//

import UIKit

let kBasicNodeValueNilDefault : Double = 0

protocol KLBasicNodeInterface {
    //This var is the xib || storyboard name of this node view.
    static var xibName : String { get }
    
    var node: KLNode! { get set }
    
    //This func is call to update all the layout from node's var change
    func updateLayout()
}

class KLBasicNodeView: UIView, KLBasicNodeInterface {

    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    var node: KLNode!
    
    static var xibName: String {
        return "KLBasicNodeView"
    }
    
    static func xibInstance(with frame:CGRect, node:KLNode) -> KLBasicNodeView? {
       guard let instance : KLBasicNodeView = Bundle.main.loadNibNamed(xibName, owner: nil
            , options: nil
        )?.first as? KLBasicNodeView else{
            return nil
        }
        
        instance.frame = frame
        instance.node = node
        
        instance.updateLayout()
        
        return instance
    }
    
    func updateLayout() {
        accountNameLabel.text = node.accountName
        valueLabel.text = NSString.init(format: "%.2f", node.value ?? kBasicNodeValueNilDefault) as String
    }

}
