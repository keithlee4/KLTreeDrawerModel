//
//  KLBasicNodeView.swift
//  KLTreeDrawerModel
//
//  Created by keith.lee on 2016/10/4.
//  Copyright © 2016年 Keith. All rights reserved.
//

import UIKit

let kBasicNodeValueNilDefault : Double = 0

protocol KLBasicNodeViewInterface : KLDefaultNodeViewInterface{

}

class KLBasicNodeView: UIView, KLBasicNodeViewInterface {
    typealias NodeType = KLNode
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    var node: NodeType!
    
    class func xibName() -> String {
        return "KLBasicNodeView"
    }
    
    
    class func xibInstance<T>(with frame:CGRect, node:KLNode) -> T? where T : KLBasicNodeView {
       guard let instance = Bundle.main.loadNibNamed(xibName(), owner: nil
            , options: nil
        )?.first as? T else{
            return nil
        }
        
        
        instance.frame = frame
        instance.node = node
        instance.updateLayout()
        instance.clipsToBounds = true
        instance.layer.cornerRadius = frame.size.width / 2.0
        
        return instance 
    }
    
    func updateLayout() {
        accountNameLabel.text = node.accountName
        valueLabel.text = NSString.init(format: "%.2f", node.value ?? kBasicNodeValueNilDefault) as String
        
        if let imgName = node.imageName{
            imageView.image = UIImage.init(named: imgName)
        }
        
        self.backgroundColor = node.mainColor
    }

}
