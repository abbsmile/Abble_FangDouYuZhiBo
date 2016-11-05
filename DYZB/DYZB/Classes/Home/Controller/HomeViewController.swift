//
//  HomeViewController.swift
//  DYZB
//
//  Created by 阿鲍 on 16/11/4.
//  Copyright © 2016年 abble. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    
    // MARK:- 懒加载属性
    fileprivate lazy var pageTitleView : PageTitleView = {[weak self] in
        
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH , width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"];
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        
        return titleView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

// MARK:- 设置UI界面
extension HomeViewController {
    
    fileprivate func setupUI() {

        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar()
        view.addSubview(pageTitleView)
    }
    
    
    fileprivate func setupNavigationBar() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
}




















