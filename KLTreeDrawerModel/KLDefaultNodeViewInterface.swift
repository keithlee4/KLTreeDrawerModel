
//
//  KLDefaultNodeViewInterface.swift
//  KLTreeDrawerModel
//
//  Created by keith.lee on 2016/10/7.
//  Copyright © 2016年 Keith. All rights reserved.
//

import Foundation


protocol KLDefaultNodeViewInterface {
    associatedtype NodeType
    
    //This var is the xib || storyboard name of this node view.
    static func xibName() -> String
    
    var node: NodeType! { get set }
    //This func is call to update all the layout from node's var change
    func updateLayout()

}
