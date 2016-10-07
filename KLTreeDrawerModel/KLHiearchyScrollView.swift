//
//  KLHiearchyScrollView.swift
//  KLTreeDrawerModel
//
//  Created by keith.lee on 2016/10/4.
//  Copyright © 2016年 Keith. All rights reserved.
//

import UIKit
protocol KLHierachyScrollViewInterface {
    var tapGes: UITapGestureRecognizer! { get set }
    var treeView: KLTreeView! { get set }
    
    func tapScreen(tapGes:UITapGestureRecognizer)
    
    func relayout(with root:KLTreeDrawerDelegate)
}

class KLHiearchyScrollView: UIScrollView, UIScrollViewDelegate, KLHierachyScrollViewInterface {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.zoomScale = kTreeScrollViewOriginalZoomScale
        self.backgroundColor = kTreeScrollViewBackgroundColor
    }
 
    
    var treeView: KLTreeView!
    var tapGes: UITapGestureRecognizer!
    
    init(frame: CGRect, root:KLTreeDrawerDelegate) {
        super.init(frame: frame)
        self.backgroundColor = kTreeScrollViewBackgroundColor
        self.minimumZoomScale = kTreeScrollViewMinZoomScale
        self.maximumZoomScale = kTreeScrollViewMaxZoomScale
        
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(tapScreen(tapGes:)))
        self.tapGes = tapGes
        
        self.addGestureRecognizer(self.tapGes)
        
        self.delegate = self
        
        self.treeView = KLTreeView.init(frame: frame, withRoot: root, in: self)
        self.treeView.backgroundColor = root.backgroundColor ?? UIColor.clear
        self.addSubview(self.treeView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.treeView
    }
    
    func tapScreen(tapGes: UITapGestureRecognizer) {
        self.zoomScale = kTreeScrollViewOriginalZoomScale
    }
    
    func relayout(with root: KLTreeDrawerDelegate) {
        self.treeView.removeFromSuperview()
        
        self.treeView = KLTreeView.init(frame: self.frame, withRoot: root, in:self)
        self.treeView.backgroundColor = root.backgroundColor ?? UIColor.clear
        
        self.addSubview(self.treeView)
    }
    
    
    
    

}
