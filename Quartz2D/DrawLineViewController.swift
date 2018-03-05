//
//  DrawLineViewController.swift
//  Quartz2D
//
//  Created by 雷广 on 2018/3/4.
//  Copyright © 2018年 leiguang. All rights reserved.
//

import UIKit

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
            
            ctx.move(to: p0)
            ctx.addLine(to: p1)
            ctx.addLine(to: p2)
            ctx.closePath()
            ctx.setFillColor(UIColor.cyan.cgColor)
            ctx.setLineWidth(10)
            ctx.setLineJoin(.round)
            ctx.setStrokeColor(UIColor.red.cgColor)
            ctx.drawPath(using: .fillStroke)    // 绘制路径并填充
        }
        

        // MARK: - 曲线
        if true {
            let start = CGPoint(x: 50, y: 400)
            let control1 = CGPoint(x: 150, y: 300)
            let control2 = CGPoint(x: 250, y: 500)
            let end = CGPoint(x: 350, y: 400)
            
            ctx.move(to: start)
            ctx.addCurve(to: end, control1: control1, control2: control2)
            ctx.setLineCap(.round)
            ctx.setStrokeColor(UIColor.green.cgColor)
            ctx.strokePath()
        }
        
        
        // MARK: - 虚线
        if true {
            let start = CGPoint(x: 50, y: 500)
            let end = CGPoint(x: 350, y: 500)
            let phase: CGFloat = 0  // 相当于开始划线的内容偏移量，还是从起点开始画，但是画的内容从原来的 xx pt处开始
            let lengths: [CGFloat] = [40, 20]   // [实线, 虚线，实线, 虚线...] 的长度数组
            
            ctx.addLines(between: [start, end])
            ctx.setLineDash(phase: phase, lengths: lengths)
            ctx.setLineCap(.butt)
            ctx.setStrokeColor(UIColor.brown.cgColor)
            ctx.strokePath()
            
            // 在其下方画一条相同长度的实线用作对比
            ctx.addLines(between: [CGPoint(x: 50, y: 520), CGPoint(x: 350, y: 520)])
            ctx.setLineDash(phase: 0, lengths: [])  // 传空数组 清楚虚线模式（即画实线）
            ctx.strokePath()
        }
        
        ctx.translateBy(x: 0, y: 100)
        
        
        // MARK: - 渐变线
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = (1...255).map { UIColor(red: CGFloat($0)/255.0, green: CGFloat($0)/255.0, blue: CGFloat($0)/255.0, alpha: 1) }
////        ctx.draw
        if true {
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let colors = [UIColor.red.cgColor, UIColor.green.cgColor]
            var locations: [CGFloat] = [0, 1]
            let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: &locations)!
            let start = CGPoint(x: 50, y: 600)
            let end = CGPoint(x: 350, y: 600)
//            ctx.drawLinearGradient(gradient, start: start, end: end, options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
    
            let startCenter = CGPoint(x: 80, y: 650)
            let startRadius: CGFloat = 50
            let endCenter = CGPoint(x: 300, y: 650)
            let endRadius: CGFloat = 30
            ctx.drawRadialGradient(gradient, startCenter: startCenter, startRadius: startRadius, endCenter: endCenter, endRadius: endRadius, options: [])
        }
    }
}
