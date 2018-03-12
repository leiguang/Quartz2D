//
//  DrawShapeViewController.swift
//  Quartz2D
//
//  Created by 雷广 on 2018/3/4.
//  Copyright © 2018年 leiguang. All rights reserved.
//

import UIKit

class DrawShapeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let v = DrawShapeView(frame: view.bounds)
        v.backgroundColor = .white
        view.addSubview(v)
    }
}

class DrawShapeView: UIView {
    
    override func draw(_ rect: CGRect) {
        
        let ctx = UIGraphicsGetCurrentContext()!
        
        // MARK: - 画矩形 (画圆角矩形可使用CGPathAddRoundedRect 或UIBezierPath中的方法)
        if true {
            let rect = CGRect(x: 100, y: 100, width: 200, height: 100)

            ctx.addRect(rect)
            ctx.setStrokeColor(UIColor.red.cgColor)
            ctx.strokePath()
        }


        // MARK: - 两条直线间画圆弧
        if true {
            // 画 ”直线start-tangent1“ 与 ”直线tangent1-tangent2“ 之间的圆弧
            // （注意：如果“start”不是 “直线start-tangent1” 与 “圆弧” 的交点，则会自动补上"start"到"交点"的连线，如此例）
            let start = CGPoint(x: 100, y: 200) // 起始点
            let tangent1 = CGPoint(x: 100, y: 100)
            let tangent2 = CGPoint(x: 200, y: 100)
            let radius: CGFloat = 50

            ctx.move(to: start)
            ctx.addArc(tangent1End: tangent1, tangent2End: tangent2, radius: radius)
            ctx.setStrokeColor(UIColor.black.cgColor)
            ctx.strokePath()
        }
        
        
        // MARK: - 画同心圆
        // "圆1"和"圆2" 中 画圆的方向clockwise不同，一个逆时针绘制，一个顺时针绘制，使用的是默认CGPathFillRule.winding（从不同方向绘制，正负方向相加为0的区域 则抵消，相当于该区域不绘制）
        // 参考[Quartz 2D Programming Gudie -> Paths -> Filling a Path](https://developer.apple.com/library/content/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_paths/dq_paths.html#//apple_ref/doc/uid/TP30001066-CH211-TPXREF106)
        // 注意：画圆时方法的“clockwise”参数，由于iOS上的UIKit坐标系统中默认将y轴矩阵翻转了一次，所以在draw(...)的 ctx.addArc(...)方法中  指定参数clockwise: true 表示逆时针。(参见addArc(center:radius:startAngle:endAngle:clockwise:)方法的Api描述，或者 [Quartz 2D Programming Gudie -> Overview of Quartz 2D -> Quartz 2D Coordinate Systems](https://developer.apple.com/library/content/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_overview/dq_overview.html#//apple_ref/doc/uid/TP30001066-CH202-TPXREF101))
        if true {
            // 圆1
            if true {
                let center = CGPoint(x: 100, y: 300)
                let radius1: CGFloat = 50
                let radius2: CGFloat = 30
                
                ctx.addArc(center: center, radius: radius1, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
                ctx.addArc(center: center, radius: radius2, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
                ctx.setFillColor(UIColor.green.cgColor)
                ctx.fillPath()  // 默认使用CGPathFillRule.winding方式绘制，相当于代码 ctx.fillPath(using: .winding)
            }
            
            // 圆2
            if true {
                let center = CGPoint(x: 200, y: 300)
                let radius1: CGFloat = 50
                let radius2: CGFloat = 30
                
                ctx.addArc(center: center, radius: radius1, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
                ctx.addArc(center: center, radius: radius2, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
                ctx.setFillColor(UIColor.green.cgColor)
                ctx.fillPath()  // 默认使用CGPathFillRule.winding方式绘制，相当于代码 ctx.fillPath(using: .winding)
//                ctx.strokePath()
            }
            
            // 圆3
            if true {
                let center = CGPoint(x: 300, y: 300)
                let radius1: CGFloat = 50
                let radius2: CGFloat = 30
                let radius3: CGFloat = 10
                

                // 1.无同心圆效果
                // 直接调用addArc(...)方法画两个大小圆，设置相同的clockwise参数，（此时调用strokePath() 也无法画出两个圆的效果），再用 ctx.fillPath(using: .evenOdd)模式是无法达到同心圆效果的
//                ctx.addArc(center: center, radius: radius1, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
//                ctx.addArc(center: center, radius: radius2, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)

                
                // 2.有同心圆效果
                // 调用addArc(...)方法画4个半圆，设置相同的clockwise参数，（此时调用strokePath() 可以画出两个圆的效果），再用 ctx.fillPath(using: .evenOdd)模式可以达到同心圆效果，的个人猜测与addArc(...)方法画圆时的画线连接点内部实现有关。
                ctx.move(to: CGPoint(x: 350, y: 300))
                ctx.addArc(center: center, radius: radius1, startAngle: 0, endAngle: CGFloat.pi, clockwise: true)
                ctx.move(to: CGPoint(x: 250, y: 300))
                ctx.addArc(center: center, radius: radius1, startAngle: CGFloat.pi, endAngle: 2 * CGFloat.pi, clockwise: true)
                ctx.move(to: CGPoint(x: 330, y: 300))
                ctx.addArc(center: center, radius: radius2, startAngle: 0, endAngle: CGFloat.pi, clockwise: true)
                ctx.move(to: CGPoint(x: 270, y: 300))
                ctx.addArc(center: center, radius: radius2, startAngle: CGFloat.pi, endAngle: 2 * CGFloat.pi, clockwise: true)
                
                ctx.setFillColor(UIColor.green.cgColor)
                ctx.drawPath(using: .eoFillStroke)  // 使用CGPathFillRule.evenOdd方式绘制+描边, 此时若使用ctx.fillPath()无法实现同心圆效果
            }
        }
        
        
        // MARK: - 画五角星
        if true {
            let psize: CGFloat = 100
            let r: CGFloat = 0.8 * psize / 2;
            let theta: CGFloat = 2 * CGFloat.pi * (2.0 / 5.0)   // 144 degrees
            let start = CGPoint(x: 0, y: r)

            let offsetX: CGFloat = 100  // 五角星相对于原点的x轴偏移量
            let offsetY: CGFloat = 350  // 五角星相对于原点的y轴偏移量

            ctx.saveGState()
            ctx.translateBy(x: offsetX + psize / 2, y: offsetY + psize / 2)
            ctx.scaleBy(x: 1.0, y: -1.0)    // 由于UIKit坐标系(y轴朝下)和CG坐标系(y轴朝上) y轴相反，此五角星是以macos的坐标系统为基准画的，因此在绘制到context前通过矩阵垂直翻转坐标系，使五角星尖尖朝上
            ctx.move(to: start)
            for i in 1..<5 {
                let x: CGFloat = r * sin(CGFloat(i) * theta)
                let y: CGFloat = r * cos(CGFloat(i) * theta)
                ctx.addLine(to: CGPoint(x: x, y: y))
            }

            ctx.setFillColor(UIColor.red.cgColor)
            ctx.closePath()
            ctx.fillPath()  //  ctx.fillPath(using: .evenOdd) 使用evenOdd模式，则可以看到五角星的中间未填充
            ctx.restoreGState()
        }
       
    }
}
