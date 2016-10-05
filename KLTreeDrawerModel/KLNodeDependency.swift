//
//  KLNodeDependency.swift
//  KLTreeDrawerModel
//
//  Created by keith.lee on 2016/10/3.
//  Copyright © 2016年 Keith. All rights reserved.
//

import UIKit

class KLNodeDependency: NSObject {
    static func configreDependencies<T>(of node:T) where T : KLTreeDrawerDelegate{
        if let n = node as? KLNode{
            let presneter = KLNodePresenter.init()
            n.presenter = presneter
            presneter.node = n
        }else if let n = node as? KLSubNode{
            let presenter = KLSubNodePresenter.init()
            n.presenter = presenter
            presenter.subNode = n
        }

    }
}
