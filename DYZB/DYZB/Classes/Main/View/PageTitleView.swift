//
//  PageTitleView.swift
//  DYZB
//
//  Created by 阿鲍 on 16/11/4.
//  Copyright © 2016年 abble. All rights reserved.
//

import UIKit

// MARK:- 定义协议
protocol PageTitleViewDelegate : class {
    func pageTitleView(_ titleView : PageTitleView, selectedIndex index : Int)
}

// MARK:- 定义常量
private let kScrollLineH : CGFloat = 2
// private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)

// MARK:- 定义PageTitleView类
class PageTitleView: UIView {
    
    // MARK:- 定义属性
    fileprivate var titles : [String]
    fileprivate var currentIndex : Int = 0
    weak var delegate : PageTitleViewDelegate?
    
    // MARK:- 懒加载
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    // MARK:- 自定义构造函数
    init(frame: CGRect, titles : [String]) {
        
        self.titles = titles
        super.init(frame : frame)
        
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 设置UI界面
extension PageTitleView {
    fileprivate func setupUI() {
        
        addSubview(scrollView)
        scrollView.frame = bounds
        
        setupTitleLabels()
        setupBottomLineAndScrollLine()
    }
    
    fileprivate func setupTitleLabels() {
        
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0;
        
        for (index, title) in titles.enumerated() {
            
            let label = UILabel()
            
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            // label.textColor = UIColor(red: kNormalColor.0, green: kNormalColor.1, blue: kNormalColor.2, alpha: 0.5)
            label.textColor = UIColor.gray
            label.textAlignment = .center
            
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(_:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    fileprivate func setupBottomLineAndScrollLine() {
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        guard let firstlabel = titleLabels.first else {
            return
        }
        firstlabel.textColor = UIColor.orange
        
        scrollLine.frame = CGRect(x: firstlabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstlabel.frame.width, height: kScrollLineH)
        scrollView.addSubview(scrollLine)
    }
    
}

// MARK:- 监听Label的点击
extension PageTitleView {
    @objc fileprivate func titleLabelClick(_ tapGes : UITapGestureRecognizer) {
        
        guard let currentLabel = tapGes.view as? UILabel else { return }
        if currentLabel.tag == currentIndex { return }
        let oldLabel = titleLabels[currentIndex]
        
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.gray
        
        currentIndex = currentLabel.tag
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15, animations: {
            self.scrollLine.frame.origin.x = scrollLineX
        })
        
        // 点击时通知代理，调用HomeViewController中的代理方法
        delegate?.pageTitleView(self, selectedIndex: currentIndex)
    }
}














