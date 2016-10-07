//
//  KLSubNode.swift
//  KLTreeDrawerModel
//
//  Created by keith.lee on 2016/10/5.
//  Copyright © 2016年 Keith. All rights reserved.
//

import UIKit

//NOTE: This should be inherit both node interface and basic info struct.
protocol KLSubNodeBasicVariableInterface {
    var imageName : String? { get set }
    var mainColor : UIColor? { get set }
    var accountName: String? { get set }
    var value: Double? { get set }
    
    var subNodeDesc: String? { get set }
}

//NOTE: This define presenter-triggered actions.
protocol KLSubNodeActionInterface  {
    func updateAccount(with accountName:String)
    func updateValue(with value:Double)
    func updateImageName(with name:String)
}

protocol KLSubNodeBasicInterface : KLSubNodeActionInterface, KLSubNodeBasicVariableInterface {
    
}



class KLSubNode: NSObject, KLTreeDrawerDelegate, KLSubNodeBasicInterface {
    
    //MARK: - Var
    //MARK: Tree Drawer Delegate
    var nodeView: UIView!
    var weight: Int = 0
    var startX: Int = 0
    var backgroundColor: UIColor?
    var children: [KLTreeDrawerDelegate]?
    var treeView: KLTreeView!
    var level: Int = 0
    
    //MARK: -
    
    //MARK: Node Interface Var
    var imageName: String?
    var mainColor: UIColor?
    var accountName: String?
    var value: Double?
    var subNodeDesc : String?
    
    
    
    required init(with info:KLSubNodeBasicInfo, children:[KLTreeDrawerDelegate]? = nil){
        super.init()
        
        if let c = children{
            self.children = c
        }
        
        self.accountName = info.accountName
        self.value = info.value
        self.imageName = info.imageName
        self.mainColor = info.mainColor
        self.nodeView = KLSubNodeView.xibInstance(with: CGRect(origin: .zero, size: kNodeSize), node: self)
    }
    
    //NOTE: Gesture and Selector would be implemented when Tree View actually draw this node on the view,
    //      then tree view will set ges selector to this func.
    //      More info could be found in "func addTapGesture(to node:KLTreeDrawerDelegate)".
    func viewTapped() {
        print("sub tapped~~~~~")
        guard let tree = self.nodeView.superview as? KLTreeView else {
            print("Node is not in subview of a tree")
            return
        }
        
        guard let scrollView = tree.superview as? KLHiearchyScrollView else{
            print("Tree is not in subview of a scorllView")
            return
        }
        
        
        let newRoot = KLTreeTestGenerator.genTree(for: kTreeTestGenNodes, withRoot: self)
        scrollView.relayout(with: newRoot)
        
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

//MARK: - For Test
extension KLSubNode {
    class func random<T>(with children:[KLTreeDrawerDelegate]? = nil) -> T where T : KLSubNode{
        let randomValue : Double = Double(arc4random() % 100)
        let accountName = "Sub Node: \(randomValue)"
        let testInfo = KLSubNodeBasicInfo(accountName: accountName, value: randomValue, imageName: "Meme" + String(Int(randomValue) % 2 + 1), mainColor: UIColor.green, subNodeDesc: "subNode !!!!")
        let node =  T(with: testInfo, children: children)
        
        return node
    }
}
