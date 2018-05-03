//
//  DrawShapeViewController.swift
//  Quartz2D
//
//  Created by 雷广 on 2018/3/4.
//  Copyright © 2018年 leiguang. All rights reserved.
//

import UIKit

/**
 ”非零环绕数规则(Nonzero-rule)“ 和 ”奇偶规则(Even–odd rule)“:
 在图形学中判断一个点是否在多边形内，若多边形不是自相交的，那么可以简单的判断这个点在多边形内部还是外部；若多边形是自相交的，那么就需要根据非零环绕数规则和奇-偶规则判断。
 1.Nonzero-rule: 首先使多边形的边变为矢量，即每条边都是有方向的，将环绕数初始化为零。若要判断 p点 是否在多边形内部，则从p点向任意方向作一条射线，找出该射线与多边形的所有交叉点，按如下规则统计：每个顺时针的交叉点(边从左到右穿过射线)减1，每个逆时针的交叉点(边从右到左穿过射线)加1。如果统计的环绕数结果为0，则p点在多边形外部；否则，p点在多边形内部。
 2.Even–odd rule: 若要判断 p点 是否在多边形内部，则从p点向任意方向作一条射线，统计该射线与多边形相交的边的数目，若数目为奇数，则p为内部点；若数目为偶数，则p为外部点。
 
 iOS中分别用 “winding”和“evenOdd” 来表示，默认是采用“winding”非零环绕数规则。
 在多边形内部的点需要绘制，在多边形外部的点不需要绘制。
 
 苹果文档[Quartz 2D Programming Gudie -> Paths -> Filling a Path](https://developer.apple.com/library/content/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_paths/dq_paths.html#//apple_ref/doc/uid/TP30001066-CH211-TPXREF106)
 Wikipedia: [Nonzero-rule](https://en.wikipedia.org/wiki/Nonzero-rule)
 Wikipedia: [Even–odd rule](https://en.wikipedia.org/wiki/Even–odd_rule)
 */


/**
 注意：画圆时方法的“clockwise”参数，由于iOS上的UIKit坐标系统中默认将y轴矩阵翻转了一次，所以在draw(...)的 ctx.addArc(...)方法中  指定参数clockwise: true 表示逆时针。(参见addArc(center:radius:startAngle:endAngle:clockwise:)方法的Api描述，或者 [Quartz 2D Programming Gudie -> Overview of Quartz 2D -> Quartz 2D Coordinate Systems](https://developer.apple.com/library/content/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_overview/dq_overview.html#//apple_ref/doc/uid/TP30001066-CH202-TPXREF101))
 */

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
        if true {
            // 圆1   ("圆1"和"圆2" 中 画圆的方向clockwise不同，导致效果不同)
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
                ctx.fillPath()
            }
            
            // 圆3
            if true {
                let center = CGPoint(x: 300, y: 300)
                let radius1: CGFloat = 50
                let radius2: CGFloat = 30

                // 1.无同心圆效果
                // 直接调用addArc(...)方法画两个大小圆，设置相同的clockwise参数，（此时调用strokePath() 也无法画出两个圆的效果），再用 ctx.fillPath(using: .evenOdd)模式也是无法达到同心圆效果的
//                ctx.addArc(center: center, radius: radius1, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
//                ctx.addArc(center: center, radius: radius2, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
//                ctx.fillPath()
                
                
                // 2.有同心圆效果(clockwise方向相反)
//                ctx.addArc(center: center, radius: radius1, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
//                ctx.addArc(center: center, radius: radius2, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
//                ctx.fillPath(using: .evenOdd)
                
                
                // 3.有同心圆效果
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
                ctx.drawPath(using: .eoFillStroke)  // 使用CGPathFillRule.evenOdd方式绘制+描边
            }
        }
        
        
        // MARK: - 画五角星
        if true {
            let psize: CGFloat = 100
            let r: CGFloat = 0.8 * psize / 2;
            let theta: CGFloat = 2 * CGFloat.pi * (2.0 / 5.0)   // 144 degrees
            let start = CGPoint(x: 0, y: r)

            let offsetX: CGFloat = 0  // 五角星相对于原点的x轴偏移量
            let offsetY: CGFloat = 350  // 五角星相对于原点的y轴偏移量

            ctx.saveGState()
            ctx.translateBy(x: psize / 2, y: psize / 2)
            
            // 由于UIKit坐标系(y轴朝下)和CG坐标系(y轴朝上) y轴相反，此五角星是以macos的坐标系统为基准画的，因此在绘制到context前通过矩阵垂直翻转坐标系，使五角星尖尖朝上
            ctx.translateBy(x: offsetX, y: offsetY)
            ctx.scaleBy(x: 1.0, y: -1.0)
            
            ctx.move(to: start)
            for i in 1..<5 {
                let x: CGFloat = r * sin(CGFloat(i) * theta)
                let y: CGFloat = r * cos(CGFloat(i) * theta)
                ctx.addLine(to: CGPoint(x: x, y: y))
            }

            ctx.setFillColor(UIColor.red.cgColor)
            ctx.closePath()
            ctx.fillPath()  //  若使用ctx.fillPath(using: .evenOdd) evenOdd模式，则可以看到五角星的中间未填充
            ctx.restoreGState()
        }
       
    }
}
