//
//  ShadowsViewController.swift
//  Quartz2D
//
//  Created by 雷广 on 2018/3/15.
//  Copyright © 2018年 leiguang. All rights reserved.
//

import UIKit


// [Shadows](https://developer.apple.com/library/content/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_shadows/dq_shadows.html#//apple_ref/doc/uid/TP30001066-CH208-TPXREF101)

/**
 Shadows在Quartz中是图形状态的一部分，在阴影设置之后，所画的任何对象都会有一个阴影效果。解决办法：
 1.在设置阴影之前可以先保存上下文状态，阴影完成后再恢复。
 2.通过设置shadow color为NULL来关闭阴影: ctx.setShadow(offset: offset, blur: blur, color: nil)
 
 If you save the graphics state before you call CGContextSetShadow or CGContextSetShadowWithColor, you can turn off shadowing by restoring the graphics state. You also disable shadows by setting the shadow color to NULL.
*/

// (阴影的坐标系统跟随当前上下文的坐标系统方向，可设置偏移量、模糊值、颜色。默认阴影颜色为1/3透明度的黑色)


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
            
            ctx.saveGState()
            
            // 矩形1
            let offset = CGSize(width: -15, height: -20)
            let blur: CGFloat = 5   // Blur 效果对比可参见[Shadows -> Figure 7-2]
            let fillColor = UIColor.green.cgColor
            let rect = CGRect(x: 100, y: 220, width: 100, height: 60)
            
            ctx.setShadow(offset: offset, blur: blur)
            ctx.setFillColor(fillColor)
            ctx.fill(rect)
            
            
            // 矩形2
            let offset2 = CGSize(width: -15, height: -20)
            let blur2: CGFloat = 5
            let shadowColor2 = UIColor(red: 1, green: 0, blue: 0, alpha: 0.6).cgColor
            let fillColor2 = UIColor.blue.cgColor
            let rect2 = CGRect(x: 200, y: 330, width: 100, height: 60)
            
            ctx.setShadow(offset: offset2, blur: blur2, color: shadowColor2)
            ctx.setFillColor(fillColor2)
            ctx.fill(rect2)
            
            
            ctx.restoreGState()
        }
    }
}

