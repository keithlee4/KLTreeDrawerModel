//
//  KLSubNodePresenter.swift
//  KLTreeDrawerModel
//
//  Created by keith.lee on 2016/10/5.
//  Copyright © 2016年 Keith. All rights reserved.
//

import UIKit

protocol KLSubNodeModuleInterface : KLNodeModuleInterface {

}

class KLSubNodePresenter: KLSubNodeModuleInterface {
    weak var subNode : KLSubNode!
    
    func nodeViewTapped() {
        
    }
}
