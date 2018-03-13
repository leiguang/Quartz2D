//
//  DrawLineViewController.swift
//  Quartz2D
//
//  Created by 雷广 on 2018/3/4.
//  Copyright © 2018年 leiguang. All rights reserved.
//

import UIKit


// 线与线的连接点样式、线头的样式具体区别、虚线等，文档有图讲解[Quartz 2D Programming Guide -> Paths -> Line join styles](https://developer.apple.com/library/content/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_paths/dq_paths.html#//apple_ref/doc/uid/TP30001066-CH211-TPXREF101)



// 画线
class DrawLineViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let v = DrawLineView(frame: view.bounds)
        v.backgroundColor = .white
        view.addSubview(v)
    }
}

class DrawLineView: UIView {
    
    override func draw(_ rect: CGRect) {

        let ctx = UIGraphicsGetCurrentContext()!    // 在view的draw(rect:)方法中 可以获取到当前图形上下文，直接显示解包使用
        
        // MARK: - 连线成三角形
        if true {
            let p0 = CGPoint(x: 200, y: 100)
            let p1 = CGPoint(x: 300, y: 300)
            let p2 = CGPoint(x: 100, y: 300)
            
            // fill content
            ctx.beginPath()
            ctx.move(to: p0)
            ctx.addLine(to: p1)
            ctx.addLine(to: p2)
            ctx.closePath()
            ctx.setFillColor(UIColor.cyan.cgColor)
            ctx.fillPath()
            
            // stroke border
            ctx.move(to: p0)
            ctx.addLine(to: p1)
            ctx.addLine(to: p2)
            ctx.closePath()
            ctx.setLineWidth(10)
            ctx.setLineJoin(.round) // 线与线的电接点样式：圆角
            ctx.setStrokeColor(UIColor.red.cgColor)
            ctx.strokePath()
        }
        
        
        // MARK: - 曲线
        if true {
            let start = CGPoint(x: 50, y: 400)
            let control1 = CGPoint(x: 150, y: 300)
            let control2 = CGPoint(x: 250, y: 500)
            let end = CGPoint(x: 350, y: 400)
            ctx.beginPath()
            ctx.move(to: start)
            ctx.addCurve(to: end, control1: control1, control2: control2)
            ctx.setLineCap(.round)
            ctx.setStrokeColor(UIColor.green.cgColor)
            ctx.strokePath()
        }
        
        
        // MARK: - 虚线
        if true {
            // phase为0 的虚线
            let start1 = CGPoint(x: 50, y: 490)
            let end1 = CGPoint(x: 350, y: 490)
            let phase1: CGFloat = 0
            let lengths: [CGFloat] = [40, 30, 20, 10]   // 为 [实，虚，实，虚...] 线段的长度数组
            
            ctx.beginPath()
            ctx.addLines(between: [start1, end1])
            ctx.setLineCap(.butt)
            ctx.setLineWidth(10)
            ctx.setLineDash(phase: phase1, lengths: lengths)
            ctx.setStrokeColor(UIColor.brown.cgColor)
            ctx.strokePath()
            
            // phase为30 的虚线, 相当于将线段从右往左偏移30
            let start2 = CGPoint(x: 50, y: 510)
            let end2 = CGPoint(x: 350, y: 510)
            let phase2: CGFloat = 30
            ctx.addLines(between: [start2, end2])
            ctx.setLineDash(phase: phase2, lengths: lengths)
            ctx.strokePath()
            
            // 画一条实线作对比
            let start3 = CGPoint(x: 50, y: 530)
            let end3 = CGPoint(x: 350, y: 530)
            ctx.addLines(between: [start3, end3])
            ctx.setLineDash(phase: 0, lengths: [])  // 传递空数组，即设置为实线模式
            ctx.strokePath()
        }
        
        
        // MARK: - 渐变线
        if true {
            // ctx.replacePathWithStrokedPath()：用描边的版本路径替换图形上下文中的路径。配合 ctx.clip()裁剪画布，可达到只在当前描边的路径中绘制的效果
            // 由于要使用 ctx.clip() 函数，在裁剪画布之后，后续的绘图操作都只能在裁剪后的画布范围内绘制。
            // 若要恢复(扩大)到之前的画布大小，必须在clip之前使用ctx.saveGState()保存一份当前的绘图状态，在clip裁剪并绘制完成之后，使用ctx.restoreGState()恢复原来的画布大小
            // 参考：CGContenxt.replacePathWithStrokedPath() 的Api描述
            
            ctx.saveGState()
            
            let start = CGPoint(x: 50, y: 600)
            let end = CGPoint(x: 350, y: 600)
            ctx.beginPath()
            ctx.addLines(between: [start, end])
            ctx.setLineWidth(20)
            ctx.replacePathWithStrokedPath()
            ctx.clip()
            
            let colors = [UIColor.red.cgColor, UIColor.green.cgColor] as CFArray
            let locations: [CGFloat] = [0, 1]
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: locations)!
            ctx.drawLinearGradient(gradient, start: start, end: end, options: [])
            
            ctx.restoreGState() // 恢复保存的绘图状态(恢复画布大小，使后续可继续画图)
        }
        
        
    }
}
