//
//  PageContentView.swift
//  DYZB
//
//  Created by 阿鲍 on 16/11/6.
//  Copyright © 2016年 abble. All rights reserved.
//

import UIKit

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    
    // MARK:- 定义属性
    fileprivate var childVcs : [UIViewController]
    fileprivate weak var parentViewController : UIViewController?
    
    // MARK:- 懒加载
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: (self?.bounds)!, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.scrollsToTop = false
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    
    // MARK:- 构造函数
    init(frame: CGRect, childVcs: [UIViewController], parentViewController : UIViewController? ) {
        
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageContentView {
    fileprivate func setupUI() {
        
        for childVc in childVcs {
            parentViewController?.addChildViewController(childVc)
        }
        
        addSubview(collectionView)
    }
}

extension PageContentView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        /*
         因为cell是循环利用的，所以在这里要把先前加上的移除掉，免得重复添加
         */
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[(indexPath as NSIndexPath).item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}



















