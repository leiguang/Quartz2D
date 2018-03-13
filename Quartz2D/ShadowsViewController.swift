//
//  ShadowsViewController.swift
//  Quartz2D
//
//  Created by 雷广 on 2018/3/4.
//  Copyright © 2018年 leiguang. All rights reserved.
//

import UIKit

// [Quartz 2D Programming Guide -> Shadows](https://developer.apple.com/library/content/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_shadows/dq_shadows.html#//apple_ref/doc/uid/TP30001066-CH208-TPXREF101)


class ShadowsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let v = ShadowsView(frame: view.bounds)
        v.backgroundColor = .white
        view.addSubview(v)
    }
}

class ShadowsView: UIView {

    override func draw(_ rect: CGRect) {
    
        // MARK: - 画文字阴影
        if true {
            let text: NSString = "半城柳色半声笛"
            
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
            
            text.draw(at: CGPoint(x: 50, y: 100), withAttributes: attrs)
        }
        
        
        // MARK: - 画矩形阴影
        if true {
            let ctx = UIGraphicsGetCurrentContext()!
            
            let shadowOffset = CGSize(width: -15, height: 20)
            let blur: CGFloat = 5   // indicates a soft shadow edge
            let rect1 = CGRect(x: 50, y: 200, width: 100, height: 60)
            let rect2 = CGRect(x: 200, y: 200, width: 100, height: 60)
            
            ctx.saveGState()
            
            // rect1
            ctx.setShadow(offset: shadowOffset, blur: blur) // 默认的 The shadow will appear gray, having an RGBA value of {0, 0, 0, 1/3}
            ctx.setFillColor(red: 0, green: 1, blue: 0, alpha: 1)
            ctx.fill(rect1)
            
            // rect2
            let colors: [CGFloat] = [1, 0, 0, 0.6]
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let color = CGColor(colorSpace: colorSpace, components: colors)
            ctx.setShadow(offset: shadowOffset, blur: blur, color: color)
            ctx.setFillColor(red: 0, green: 0, blue: 1, alpha: 1)
            ctx.fill(rect2)
            
            ctx.restoreGState()
        }
    }
}
