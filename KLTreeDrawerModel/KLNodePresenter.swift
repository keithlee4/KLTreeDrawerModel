//
//  KLNodePresenter.swift
//  KLTreeDrawerModel
//
//  Created by keith.lee on 2016/10/5.
//  Copyright © 2016年 Keith. All rights reserved.
//

import Foundation


//MARK: - Presenter
protocol KLNodeModuleInterface {
    func nodeViewTapped()
}


class KLNodePresenter: KLNodeModuleInterface{
    weak var node: KLNode!
    
    func nodeViewTapped() {
        
    }
}
