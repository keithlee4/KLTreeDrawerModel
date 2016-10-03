//
//  KLTreeDrawerDelegate.swift
//  KLTreeDrawerModel
//
//  Created by 李 國揚 on 2016/9/30.
//  Copyright © 2016年 Keith. All rights reserved.
//

import UIKit
protocol KLTreeDrawerDelegate : NSObjectProtocol {
    var nodeView : UIView! { get set }
    
    //number of leaf children
    var weight: Int { get set }
    
    //start x position of node
    var startX: Int { get set }
    
    //background of the container view of nodes
    var backgroundColor: UIColor? { get set }
    
    var identifier: String! { get set }
    
    var children: [KLTreeDrawerDelegate]? { get set }
    
    func viewTapped(ges: UITapGestureRecognizer)
}
