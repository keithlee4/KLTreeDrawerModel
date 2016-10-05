//
//  KLNodeTestGenerator.swift
//  KLTreeDrawerModel
//
//  Created by keith.lee on 2016/10/5.
//  Copyright © 2016年 Keith. All rights reserved.
//

import UIKit

class KLTreeTestGenerator: NSObject {
    enum NodeType{
        case basic
        case sub
    }
    
    //ex level = 3, childounts = [2.4] , count shuold be level - 1
    static func genTree(for childCounts:[Int]) -> KLTreeDrawerDelegate{
        let root = KLNode.random()
        
        var currnetLevel = 0
        var targetParents = [KLTreeDrawerDelegate]()
        targetParents.append(root)
        
        while currnetLevel < childCounts.count {
            let type : NodeType = currnetLevel == childCounts.count - 1 ? .basic : .sub
            
            let count = childCounts[currnetLevel]
            
            var nextParents = [KLTreeDrawerDelegate]()
            for p in targetParents {
                let children = genChidlren(with: count, type: type)
                p.children = children
                
                nextParents.append(contentsOf: children)
            }
            
            targetParents = nextParents
            currnetLevel += 1
            
        }
        
        return root
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
