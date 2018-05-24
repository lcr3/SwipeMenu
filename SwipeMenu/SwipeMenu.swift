//
//  SwipeMenu.swift
//  SwipeMenu
//
//  Created by ryookano on 2018/05/18.
//  Copyright © 2018年 ryookano. All rights reserved.
//

import UIKit

protocol SwipeMenuDelegate: class {
    func scrollPageChenged(page: Int)
}

class SwipeMenu: UIView, UIScrollViewDelegate {

    var delegate: SwipeMenuDelegate?

    open var currentPage      = 0
    open var scrollView       = UIScrollView()
    open var titles: [String] = [] {
        didSet {
            self.setScrollView()
        }
    }

    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: Set
    func setScrollView() {
        scrollView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: frame.size.width,
                                  height: frame.size.height)
        scrollView.contentSize = CGSize(width: CGFloat(Int(frame.width) * titles.count),
                                        height: frame.size.height)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        addSubview(scrollView)

        //各ページの作成
        for (index, title) in titles.enumerated() {
            let label = createTitleLabel(index: index)

            label.text = title
            scrollView.addSubview(label)
        }
    }

    // MARK: SwipeMenu Delegate

    // ページを変えたい時
    func chengeCurrentPage(page: Int) {
        currentPage = page
        scrollView.contentOffset.x = CGFloat(Int(scrollView.frame.width) * currentPage)
    }

    // MARK: UIScrollView Delegate
    // ユーザがドラッグ後、慣性移動も含め、スクロールが停止した際に呼び出されるデリゲートメソッド
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = Int(scrollView.contentOffset.x / frame.size.width)
        delegate?.scrollPageChenged(page: currentPage)
    }

    // Labelを作成
    private func createTitleLabel(index: Int) -> UILabel {
        let label = UILabel(frame: CGRect(x: CGFloat(index) * frame.size.width,
                                          y: 0,
                                          width: frame.size.width,
                                          height: frame.height))
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }
}

