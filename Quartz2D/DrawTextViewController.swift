//
//  DrawTextViewController.swift
//  Quartz2D
//
//  Created by 雷广 on 2018/3/4.
//  Copyright © 2018年 leiguang. All rights reserved.
//

import UIKit

class DrawTextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let v = DrawTextView(frame: view.bounds)
        v.backgroundColor = .white
        view.addSubview(v)
    }
}

private class DrawTextView: UIView {

    override func draw(_ rect: CGRect) {
    
        let text = "半城柳色半声笛" as NSString

        // 字体阴影
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.red
        shadow.shadowOffset = CGSize(width: 2, height: 2)
        shadow.shadowBlurRadius = 2 // 高斯模糊
        
        let attrs = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 36),
            NSAttributedStringKey.foregroundColor: UIColor.green,
            NSAttributedStringKey.shadow: shadow
        ]
//        let ctx = UIGraphicsGetCurrentContext()!
        text.draw(at: CGPoint(x: 50, y: 100), withAttributes: attrs)
    }
}
