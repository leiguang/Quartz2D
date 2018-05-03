//
//  TransparencyLayersViewController.swift
//  Quartz2D
//
//  Created by 雷广 on 2018/3/15.
//  Copyright © 2018年 leiguang. All rights reserved.
//

import UIKit

// [Transparency Layers](https://developer.apple.com/library/content/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_trans_layers/dq_trans_layers.html#//apple_ref/doc/uid/TP30001066-CH210-TPXREF101)

// 透明图层由2个或多个对象组成，以生成符合图形。生成的复合体被视为单个对象。当想要将效果应用于一组对象时，透明图层非常有用。效果参见[Transparency Layers -> Figure 9-1 和 Figure 9-2]
// A transparency layer consists of two or more objects that are combined to yield a composite graphic. The resulting composite is treated as a single object. Transparency layers are useful when you want to apply an effect to a group of objects.


class TransparencyLayersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let v = TransparencyLayersView(frame: view.bounds)
        v.backgroundColor = .white
        view.addSubview(v)
    }
}

class TransparencyLayersView: UIView {
    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()!
        
        let offset = CGSize(width: -10, height: -20)
        let blur: CGFloat = 10
        let color1 = UIColor.red.cgColor
        let color2 = UIColor.green.cgColor
        let color3 = UIColor.blue.cgColor
        
        // MARK: 无透明图层, 每个矩形各自都有阴影效果
        if true {
            let rect1 = CGRect(x: 100, y: 150, width: 100, height: 100)
            let rect2 = CGRect(x: 150, y: 200, width: 100, height: 100)
            let rect3 = CGRect(x: 200, y: 250, width: 100, height: 100)
            
            ctx.setShadow(offset: offset, blur: blur)
            
            ctx.setFillColor(color1)
            ctx.fill(rect1)
            ctx.setFillColor(color2)
            ctx.fill(rect2)
            ctx.setFillColor(color3)
            ctx.fill(rect3)
        }
        
        
        // MARK: 使用透明图层，矩形组成的整体有阴影效果
        if true {
            let rect1 = CGRect(x: 100, y: 400, width: 100, height: 100)
            let rect2 = CGRect(x: 150, y: 450, width: 100, height: 100)
            let rect3 = CGRect(x: 200, y: 500, width: 100, height: 100)
            
            ctx.setShadow(offset: offset, blur: blur)
            
            ctx.beginTransparencyLayer(auxiliaryInfo: nil)  // 默认应用于整个画布范围，直到调用endTransparencyLayer。 也可以使用方法beginTransparencyLayer(in rect: CGRect, auxiliaryInfo auxInfo: CFDictionary?)来限制范围
            
            ctx.setFillColor(color1)
            ctx.fill(rect1)
            ctx.setFillColor(color2)
            ctx.fill(rect2)
            ctx.setFillColor(color3)
            ctx.fill(rect3)
            
            ctx.endTransparencyLayer()
        }
        
    }
}
