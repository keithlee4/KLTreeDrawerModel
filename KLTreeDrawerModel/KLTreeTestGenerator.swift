
//
//  KLNodeTestGenerator.swift
//  KLTreeDrawerModel
//
//  Created by keith.lee on 2016/10/5.
//  Copyright © 2016年 Keith. All rights reserved.
//

import UIKit

class KLTreeTestGenerator: NSObject {
    enum NodeType : Int{
        case basic = 0
        case sub = 1
    }
    
    //ex level = 3, childounts = [2.4] , count shuold be level - 1
    static func genTree(for childCounts:[Int], withRoot root: KLTreeDrawerDelegate? = nil) -> KLTreeDrawerDelegate{
        var newRoot : KLTreeDrawerDelegate!
        if let r = root as? KLSubNode{
            newRoot = KLNode.init(with: KLNodeBasicInfo(accountName: r.accountName, value: r.value, imageName: r.imageName, mainColor: UIColor.lightGray), children: r.children)
        }else{
            newRoot = KLNode.random()
        }

        var currnetLevel = 0
        var targetParents = [KLTreeDrawerDelegate]()
        targetParents.append(newRoot)
        
        while currnetLevel < childCounts.count {
            let type : NodeType = currnetLevel == childCounts.count - 1 ? .sub : .basic
            
            let count = childCounts[currnetLevel]
            
            var nextParents = [KLTreeDrawerDelegate]()
            for p in targetParents {
//                let randCount = Int(arc4random()) % count + 1
//                let randTypeRaw = Int(arc4random()) % 2
//                let randType = NodeType(rawValue: randTypeRaw)!
                
                let children = genChidlren(with: count, type: type)
                p.children = children
                
                nextParents.append(contentsOf: children)
            }
            
            targetParents = nextParents
            currnetLevel += 1
            
        }
        
        return newRoot
    }
    
    static func genChidlren(with count:Int, type:NodeType) -> [KLTreeDrawerDelegate]{
        var children: [KLTreeDrawerDelegate] = []
        for _ in 0..<count {
            var child : KLTreeDrawerDelegate!
            
            switch type {
            case .basic:
                child = KLNode.random()
            case .sub:
                child = KLSubNode.random()
            }
            children.append(child)
        }
        
        return children
    }
    
    static func dfsChildrenExistence(of node:KLTreeDrawerDelegate) -> [KLTreeDrawerDelegate] {
        var nodesWithNoChildren = [KLTreeDrawerDelegate]()
        
        guard let children = node.children, children.count > 0 else {
            return [node]
        }
        
        for child in children {
           nodesWithNoChildren.append(contentsOf: dfsChildrenExistence(of: child))
        }
        
        return nodesWithNoChildren
    }
}
