//
//  KLNode.swift
//  KLTreeDrawerModel
//
//  Created by keith.lee on 2016/10/3.
//  Copyright © 2016年 Keith. All rights reserved.
//

import UIKit

//MARK: - This class should be implemented by real case, like layout, behaviors...etc. It serves as nodeView's controller.

//Struct - Use only in node initialization process, all propable infos should inherit this base struct
struct KLNodeBasicInfo {
    var accountName: String?
    var value: Double?
}

//MARK: - View
protocol KLNodeInterface {
    func updateAccount(with accountName:String)
    func updateValue(with value:Double)
    func updateImageName(with name:String)
    
    var imageName : String! { get set }
    var mainColor : UIColor! { get set }
}

class KLNode: NSObject, KLTreeDrawerDelegate, KLNodeInterface {
    //MARK: - Var 
    //MARK: Tree Drawer Delegate
    var nodeView: KLBasicNodeView!
    var weight: Int = 0
    var startX: Int = 0
    var backgroundColor: UIColor?
    var identifier: String!
    var children: [KLTreeDrawerDelegate]?
    //MARK: -
    
    //MARK: Node Interface Var
    var imageName: String!
    var mainColor: UIColor!
    //MARK: -
    
    //MARK: Spectific Var, all these var should be optional to support propable extensions in future.
    var accountName: String?
    var value: Double?
    //MARK: -
    
    
    var presenter: KLNodePresenter!
    
    func viewTapped(ges: UITapGestureRecognizer) {
        print("tapped~~~~~")
        self.presenter.nodeViewTapped()
    }
    
    init(with info:KLNodeBasicInfo, children:[KLTreeDrawerDelegate]? = nil){
        super.init()
    
        KLNodeDependency.configreDependencies(of: self)
        
        if let c = children{
            self.children = c
        }
        
        self.accountName = info.accountName
        self.value = info.value
        
    }
    
    
    //MARK: - Node Interface Func
    func updateValue(with value: Double) {
        self.value = value
    }
    
    func updateAccount(with accountName: String) {
        self.accountName = accountName
    }
    
    func updateImageName(with name: String) {
        self.imageName = name
    }
}

//MARK: - Test
extension KLNode{
    static func random(with children:[KLTreeDrawerDelegate]? = nil) -> KLNode{
        let accountName = "testRandom"
        let randomValue : Double = Double(arc4random() % 100)
        let testInfo = KLNodeBasicInfo(accountName: accountName, value: randomValue)
        let node =  KLNode(with: testInfo, children: children)
        node.nodeView = KLBasicNodeView.xibInstance(with: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)), node: node)
        return node
    }

}

//MARK: - Presenter
protocol KLNodeModuleInterface {
    func nodeViewTapped()
}


class KLNodePresenter: KLNodeModuleInterface{
    weak var node: KLNode!
    
    func nodeViewTapped() {
        
    }
}

//TODO: Add interactor logic
