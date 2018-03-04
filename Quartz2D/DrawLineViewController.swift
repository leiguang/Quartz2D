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

private class DrawLineView: UIView {
    override func draw(_ rect: CGRect) {

        // MARK: - 连线成三角形
        let ctx = UIGraphicsGetCurrentContext()!    // 在view的draw(rect:)方法中 可以获取到当前图形上下文，直接显示解包使用
        
        let p0 = CGPoint(x: 200, y: 100)
        let p1 = CGPoint(x: 300, y: 300)
        let p2 = CGPoint(x: 100, y: 300)
        
        // fill content
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
        ctx.setLineJoin(.round)
        ctx.setStrokeColor(UIColor.red.cgColor)
        ctx.strokePath()
        
        
        // MARK: - 曲线
        let start = CGPoint(x: 50, y: 400)
        let control1 = CGPoint(x: 150, y: 300)
        let control2 = CGPoint(x: 250, y: 500)
        let end = CGPoint(x: 350, y: 400)
        ctx.move(to: start)
        ctx.addCurve(to: end, control1: control1, control2: control2)
        ctx.setLineCap(.round)
        ctx.setStrokeColor(UIColor.green.cgColor)
        ctx.strokePath()
        
        
        // MARK: - 渐变线
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = (1...255).map { UIColor(red: CGFloat($0)/255.0, green: CGFloat($0)/255.0, blue: CGFloat($0)/255.0, alpha: 1) }
////        ctx.draw
//        CGGradient
    }
}
