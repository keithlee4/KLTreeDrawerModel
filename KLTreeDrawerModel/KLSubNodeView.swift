//
//  KLSubNodeView.swift
//  KLTreeDrawerModel
//
//  Created by keith.lee on 2016/10/5.
//  Copyright © 2016年 Keith. All rights reserved.
//

import UIKit

protocol KLBasicSubNodeInterface : KLBasicNodeInterface {
    
}

class KLSubNodeView: UIView, KLBasicSubNodeInterface {
    typealias NodeType = KLSubNode
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var node: NodeType!
    
    class func xibName() -> String {
        return "KLSubNodeView"
    }
    
    func updateLayout() {
        accountNameLabel.text = node.accountName
        valueLabel.text = NSString.init(format: "%.2f", node.value ?? kBasicNodeValueNilDefault) as String
        
        if let imgName = node.imageName{
            imageView.image = UIImage.init(named: imgName)
        }
        
        self.backgroundColor = node.mainColor

        
        self.subLabel.text = self.node.subNodeText
    }
    
    class func xibInstance<T>(with frame:CGRect, node:NodeType) -> T? where T : KLSubNodeView {
        guard let instance = Bundle.main.loadNibNamed(T.xibName(), owner: nil
            , options: nil
            )?.first as? T else{
                return nil
        }
        
        
        instance.frame = frame
        instance.node = node
        
        instance.updateLayout()
        
        return instance

    }
}
