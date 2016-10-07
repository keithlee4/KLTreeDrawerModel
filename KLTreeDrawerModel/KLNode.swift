//
//  KLNode.swift
//  KLTreeDrawerModel
//
//  Created by keith.lee on 2016/10/3.
//  Copyright © 2016年 Keith. All rights reserved.
//

import UIKit

//MARK: - This class should be implemented by real case, like layout, behaviors...etc. It serves as nodeView's controller.
//MARK: - View

//Note: Any change of varaiable in this protocol, should also be also add to KLNodeBasicInfo struct of it's corresponding

//NOTE: This should be inherit both node interface and basic info struct.
protocol KLNodeBasicVariableInterface {
    var imageName : String? { get set }
    var mainColor : UIColor? { get set }
    var accountName: String? { get set }
    var value: Double? { get set }
}

//NOTE: This define presenter-triggered actions.
protocol KLNodeActionInterface  {
    func updateAccount(with accountName:String)
    func updateValue(with value:Double)
    func updateImageName(with name:String)
}


protocol KLNodeBasicInterface : KLNodeBasicVariableInterface, KLNodeActionInterface {
    
}


class KLNode: NSObject, KLTreeDrawerDelegate, KLNodeBasicInterface {
//    typealias NodeViewType : KLBasicNodeView = KLBasicNodeView
    
    //MARK: - Var 
    //MARK: Tree Drawer Delegate
    var nodeView: UIView!
    var weight: Int = 0
    var startX: Int = 0
    var backgroundColor: UIColor?
    var children: [KLTreeDrawerDelegate]?
    var level: Int = 0
    
    //MARK: -
    
    //MARK: Node Interface Var
    var imageName: String?
    var mainColor: UIColor?
    //MARK: -
    
    //MARK: Spectific Var, all these var should be optional to support propable extensions in future.
    var accountName: String?
    var value: Double?
    

    
    required init(with info:KLNodeBasicInfo, children:[KLTreeDrawerDelegate]? = nil){
        super.init()

        
        if let c = children{
            self.children = c
        }
        
        self.accountName = info.accountName
        self.value = info.value
        self.imageName = info.imageName
        self.mainColor = info.mainColor
        self.nodeView = KLBasicNodeView.xibInstance(with: CGRect(origin: .zero, size: kNodeSize), node: self)
    }
    
    //NOTE: Gesture and Selector would be implemented when Tree View actually draw this node on the view, 
    //      then tree view will set ges selector to this func. 
    //      More info could be found in "func addTapGesture(to node:KLTreeDrawerDelegate)".
    func viewTapped() {
        print("tapped~~~~~")
        
        guard let topVC = UIApplication.topViewController() else{
            return
        }
        
        topVC.showSimplePopUp(with: "Node Tapped", contents: "This node startX : \(startX)", cancelTitle: "Cancel", cancelHandler: nil)
        
        if let v = value, let nView = nodeView as? KLBasicNodeView {
            let newValue = v + 10
            value = newValue
            nView.updateLayout()
        }
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
    class func random<T>(with children:[KLTreeDrawerDelegate]? = nil) -> T where T : KLNode{
        let randomValue : Double = Double(arc4random() % 100)
        let accountName = "Basic Node: \(randomValue)"
        let testInfo = KLNodeBasicInfo(accountName: accountName, value: randomValue, imageName: "Meme" + String(Int(randomValue) % 2 + 1), mainColor: UIColor.darkGray)
        let node =  T(with: testInfo, children: children)
        
        return node
    }

}


