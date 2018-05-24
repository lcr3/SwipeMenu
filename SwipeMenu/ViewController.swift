//
//  ViewController.swift
//  SwipeMenu
//
//  Created by ryookano on 2018/05/18.
//  Copyright © 2018年 ryookano. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SwipeMenuDelegate {


    @IBOutlet weak var swipeMenu: SwipeMenu!
    let titles      = ["りんご","ばなな","ぶどう","みかん"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.swipeMenu?.delegate = self
        self.swipeMenu.titles = titles
        self.view.addSubview(self.swipeMenu!)
    }

    func scrollPageChenged(page: Int) {
        print("ページ変更:", page)
    }

}
