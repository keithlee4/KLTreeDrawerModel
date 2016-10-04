//
//  KLTreeDrawer.swift
//  KLTreeDrawerModel
//
//  Created by 李 國揚 on 2016/9/30.
//  Copyright © 2016年 Keith. All rights reserved.
//

import UIKit

let kTreeNodeGapWidth   : CGFloat = 20
let kTreeNodeGapHeight  : CGFloat = 50
let kTreeNodeViewShiftX : CGFloat = 30
let kTreeNodeViewShiftY : CGFloat = 0

let kTreeLineThickness : CGFloat = 3.0
let kLineColorHex = 0x939598

class KLTreeView:UIView {

    var root: KLTreeDrawerDelegate!
    
    
    private var numOfNodes: Int = 0
    
    private var gap: CGSize{
        get{
            return CGSize(width: kTreeNodeGapWidth, height: kTreeNodeGapHeight)
        }
    }
    
    private var viewShift: CGPoint {
        get{
            return CGPoint(x: kTreeNodeViewShiftX, y: kTreeNodeViewShiftY)
        }
    }
    
    //MARK: Initialization
    init(frame:CGRect, withRoot root: KLTreeDrawerDelegate){
        super.init(frame:frame)
        
        let numOfNodes = getNumbersOfNodes(in: root)
        self.numOfNodes = numOfNodes
        
        let _ = updateWeights(For: root)
        let treeSize = calculateSize(of: root)
        self.frame = CGRect(origin: CGPoint.zero, size: treeSize)
        
        self.backgroundColor = UIColor.white
        self.root = root
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Tree Drawing
    //The main function to draw lines between nodes, all line point appending logics should be implemented in here.
    func drawArc(from node:KLTreeDrawerDelegate, withLevel row:Int){
        let color = UIColor.colorWith(hex: kLineColorHex)
        let startX : CGFloat = CGFloat(node.startX) + viewShift.x
        
        //Upper line
        //Down from the node
        if row != 0 {
            let start1_X = startX + node.nodeView.bounds.size.width / 2
            //TODO: Need to check this startY calculation logic later
            let start1_Y = CGFloat(row) * (gap.height + node.nodeView.bounds.size.height) + 1.0 * node.nodeView.bounds.size.height + 0.5 * gap.height + viewShift.y
            let start1 : CGPoint = CGPoint(x: start1_X, y: start1_Y)
            
            
            let end1_X = startX + node.nodeView.bounds.size.width / 2
            let end1_Y = CGFloat(row) * (gap.height + node.nodeView.bounds.size.height) + 1.0 * node.nodeView.bounds.size.height + 1.0 * gap.height + viewShift.y
            let end1 : CGPoint = CGPoint(x: end1_X, y: end1_Y)
            
            let line1 : UIBezierPath = UIBezierPath.init()
            line1.move(to: start1)
            line1.addLine(to: end1)
            
            line1.lineWidth = kTreeLineThickness
            
            color.setStroke()
            line1.stroke()
        }
        
        //Lower lines
        //T Shape lines
        if let children = node.children, children.count > 0 {
            //vertical line
            //the vertical lines in the T shape lines
            let start2_X = startX + node.nodeView.bounds.size.width / 2
            let start2_Y = CGFloat(row + 1) * (gap.height + node.nodeView.bounds.size.height) + (1.0 * node.nodeView.bounds.size.height) + viewShift.y
            
            let start2 = CGPoint(x: start2_X, y: start2_Y)
            
            let end2_X =  startX + node.nodeView.bounds.size.width / 2
            let end2_Y = CGFloat(row + 1) * (gap.height + node.nodeView.bounds.size.height) + (1.0 * node.nodeView.bounds.size.height) + (0.5 * gap.height) + viewShift.y
            
            let end2 = CGPoint(x: end2_X, y: end2_Y)
            
            let line2 : UIBezierPath = UIBezierPath.init()
            line2.move(to: start2)
            line2.addLine(to: end2)
            line2.lineWidth = kTreeLineThickness
            
            color.setStroke()
            line2.stroke()
            
            let firstChildX : CGFloat = CGFloat(children.first!.startX) + viewShift.x + node.nodeView.bounds.size.width / 2
            let lastChildX : CGFloat = CGFloat(children.last!.startX) + viewShift.x + node.nodeView.bounds.size.width / 2
            
            // horizontal line
            //the horizontal line in the T shape lines
            let start3_Y = CGFloat(row + 1) * (gap.height + node.nodeView.bounds.size.height) + (1.0 * node.nodeView.bounds.size.height) + (0.5 * gap.height) + viewShift.y
            let end3_Y = CGFloat(row + 1) * (gap.height + node.nodeView.bounds.size.height) + (1.0 * node.nodeView.bounds.size.height) + (0.5 * gap.height) + viewShift.y
            
            let start3 = CGPoint(x: firstChildX, y: start3_Y)
            let end3 = CGPoint(x: lastChildX, y: end3_Y)
            
            let line3 : UIBezierPath = UIBezierPath.init()
            line3.move(to: start3)
            line3.addLine(to: end3)
            
            line3.lineWidth = kTreeLineThickness
            
            color.setStroke()
            line3.stroke()
        }
        
        
    }
    
    //Add the given view at the pre_calculated position
    func drawViewWith(startNode node:KLTreeDrawerDelegate, rowWidth:Int, rowNumber row:Int){
        let startX : CGFloat = CGFloat(node.startX) + viewShift.x
        let startY : CGFloat = CGFloat(row + 1) * (gap.height + node.nodeView.bounds.size.height) + viewShift.y
        
        let nodeFrame = CGRect(origin: CGPoint(x: startX, y: startY), size: node.nodeView.bounds.size)
        node.nodeView.frame = nodeFrame
        
        self.addSubview(node.nodeView)
        addTapGesture(to: node)
        
    }
    
    //Add tap gesture to the view in the node
    //TODO: - Gesture Handler should be implemented in delegate
    func addTapGesture(to node:KLTreeDrawerDelegate){
        let tapGes = UITapGestureRecognizer.init(target: node, action: nil)
        node.nodeView.addGestureRecognizer(tapGes)
    }
    
    override func draw(_ rect: CGRect) {
        var rows = [Int]()
        dfSearch(For: self.root, withRowNumber: 0, withRows: &rows)
        postOrderTraverse(node: self.root, inRow: 0)
    }
    
    //MARK: - Tree Traversal
    
    //First Path:
    //A first dfs path to calculate the starting positions of external leaves.
    func dfSearch(For node:KLTreeDrawerDelegate, withRowNumber row:Int, withRows rowsStart:inout [Int]){
        //visit and draw node
        let rowWidth: CGFloat = CGFloat(node.weight) * (node.nodeView.bounds.size.width + gap.width)
        if node.children == nil || node.children?.count == 0 {
            drawViewWith(startNode: node, rowWidth: Int(rowWidth), rowNumber: row)
        }
        guard let children = node.children else{
            return
        }
        for child in children {
            if row + 1 > rowsStart.count {
                //means the rowStart of this row is not stored yet, the func assume that row can only be larger than rowsStart.count by 1
                rowsStart.append(node.startX)
            }
            
            //Make sure the child.startX would be the largest value of startX at node.startX
            if node.startX > rowsStart[row] {
                rowsStart[row] = node.startX
            }
            
            child.startX = rowsStart[row]
            let childRowWidth = CGFloat(child.weight) * (child.nodeView.bounds.size.width + gap.width)
            
            //update row satrt point
            let rowStartX = rowsStart[row] + Int(childRowWidth)
            rowsStart[row] = rowStartX
            
            //traverse other nodes
            dfSearch(For: child, withRowNumber: row + 1, withRows: &rowsStart)
        }
        
    }
    
    //Second Path:
    //A second dfs path to center internal nodes (parent) between it's children.
    func postOrderTraverse(node: KLTreeDrawerDelegate?, inRow row:Int){
        if let n = node {
            if let children = n.children, children.count > 0 {
                for child in children {
                    postOrderTraverse(node: child, inRow: row + 1)
                }
            
                if n.children?.count != 0 {
                    let firstNodeX : Int = children.first!.startX
                    let lastNodeX : Int = children.last!.startX
                    
                    node!.startX = firstNodeX + (lastNodeX - firstNodeX)/2
                    
                    let rowWidth: CGFloat = CGFloat(n.weight) * (n.nodeView.bounds.size.width + gap.width)
                    drawViewWith(startNode: n, rowWidth: Int(rowWidth), rowNumber: row)
                }
            }
            
            drawArc(from: n, withLevel: row)
        }
    }
    
    //Using dfs to get total children numbers of specific node.
    func getNumbersOfNodes(in treeRoot:KLTreeDrawerDelegate) -> Int{
        var count : Int = 1
        guard let children = treeRoot.children else{
            return count
        }
        for child in children {
            count += getNumbersOfNodes(in:child)
        }
        
        return count
    }
    
    //Using dfs to set diff weight for each node, weight is the number of child nodes of specific node.
    func updateWeights(For tree: KLTreeDrawerDelegate) -> Int{
        guard let children = tree.children, children.count > 0 else{
            //Means reaching the leaf.
            tree.weight = 1
            return 1
        }
        
        for i in 0..<children.count {
            let child = children[i]
            tree.weight += updateWeights(For: child)
        }
        
        return tree.weight
    }
    
    

    //The layout asssume that all nodes should layout like this:
    //------------Node----------
    //----Node------------Node----
    //Node----Node----Node----Node
    //
    //Means space of each node of this tree on X-Axis will not overlaid to each other.
    func calculateSize(of tree:KLTreeDrawerDelegate) -> CGSize{
        let levelsNum = getHeight(of: tree)
        let width = (CGFloat(tree.weight) * tree.nodeView.bounds.width) + (CGFloat(tree.weight + 1) * gap.width) + viewShift.x
        let height = (CGFloat(levelsNum + 1) * (gap.height + tree.nodeView.bounds.size.height)) + viewShift.y
        
        return CGSize(width: width, height: height)
    }
    
    //Using dfs to calculate all the subtrees height of specific node, then return the maximum.
    func getHeight(of tree:KLTreeDrawerDelegate) -> Int{
        guard let children = tree.children, children.count > 0 else {
            return 1
        }
        
        var treeHeights : Array<Int> = []
        for child in children {
            let heightOfChild = getHeight(of: child)
            treeHeights.append(heightOfChild)
        }
        
        var maxHeight : Int = 0
        for height in treeHeights {
            if height > maxHeight {
                maxHeight = height
            }
        }
        
        return maxHeight
    }
    
    
    
}
