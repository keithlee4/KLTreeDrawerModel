//
//  KLNodeDependency.swift
//  KLTreeDrawerModel
//
//  Created by keith.lee on 2016/10/3.
//  Copyright © 2016年 Keith. All rights reserved.
//

import UIKit

class KLNodeDependency: NSObject {
    static func configreDependencies(of node:KLNode){
        let presneter = KLNodePresenter.init()
        node.presenter = presneter
        presneter.node = node
    }
}
