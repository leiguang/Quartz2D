//
//  GradientsViewController.swift
//  Quartz2D
//
//  Created by 雷广 on 2018/3/15.
//  Copyright © 2018年 leiguang. All rights reserved.
//

import UIKit

// [Gradients](https://developer.apple.com/library/content/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_shadings/dq_shadings.html#//apple_ref/doc/uid/TP30001066-CH207-TPXREF101)

// 1. 对于linear gradient模式，在start和end连线上，与之垂直的线上的所有点颜色相同。
// An axial gradient (also called a linear gradient) varies along an axis between two defined end points. All points that lie on a line perpendicular to the axis have the same color value.

// 2. 对于radial gradient模式，start和end连线，圆心位于该线上的圆，同一圆周上的点颜色相同。
// A radial gradient is a fill that varies radially along an axis between two defined ends, which typically are both circles. Points share the same color value if they lie on the circumference of a circle whose center point falls on the axis. The radius of the circular sections of the gradient are defined by the radii of the end circles; the radius of each intermediate circle varies linearly from one end to the other.


// 有2个对象可以用来画梯度渐变：CGGradient和CGShading。
// CGGradient是CGShading的子集，被设计来更易于使用。每次创建CGShading对象时都需要提供计算梯度上每个点的颜色，当梯度上有多个点和颜色时，也需要另外设置。而CGGradient直接赋值就可以达到此效果。具体差别参见[Gradients -> A Comparison of CGShading and CGGradient Objects]


// 注意：渐变会画满整个当前画布，因此需要裁剪所画区域（save再restore图形状态）
// >> [Gradients -> Clip the Context]: When you paint a gradient, Quartz fills the current context.

class GradientsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let v = GradientsView(frame: view.bounds)
        v.backgroundColor = .white 
        view.addSubview(v)
    }
}

class GradientsView: UIView {
    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()!
        
        if true {
            ctx.saveGState()
            
            ctx.clip(to: CGRect(x: 100, y: 100, width: 100, height: 100))
            
            let start = CGPoint(x: 100, y: 100)
            let end = CGPoint(x: 200, y: 200)
            let colors = [UIColor.red.cgColor, UIColor.green.cgColor] as CFArray
            let locations: [CGFloat] = [0, 1]   // 数组locations和colors中的元素个数应该相同
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: locations)!
            ctx.drawLinearGradient(gradient, start: start, end: end, options: [])   // options有两个OptionSet选项drawsBeforeStartLocation、drawsAfterEndLocation。 分别将在start和end点 将（start、end点的颜色）继续向外延伸。
            
            ctx.restoreGState()
        }
        
        if true {
            
        }
    }
}
