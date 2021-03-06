//
//  ViewController.swift
//  KLTreeDrawerModel
//
//  Created by 李 國揚 on 2016/9/30.
//  Copyright © 2016年 Keith. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let root = setup()
        let scrollView = KLHiearchyScrollView.init(frame: self.view.bounds, root: root)
        self.view.addSubview(scrollView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func setup() -> KLTreeDrawerDelegate {
        let root = KLTreeTestGenerator.genTree(for:kTreeTestGenNodes)
        
        /*let root = KLNode.random()
        
        let level1 : Int = 10
        let level2 : Int = 2
//        var level3 : Int = 4
        
        var children = [KLSubNode]()
        for _ in 0..<level1{
            children.append(KLSubNode.random())
        }
        
        root.children = children
        
        children.removeAll()
        for _ in 0..<level2{
            children.append(KLSubNode.random())
        }
        
        for child1 in root.children! {
            child1.children = [KLSubNode.random(), KLSubNode.random()]
        }*/
        
        return root
    }
    
    
}

