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
        
        
        // MARK: - 渐变线
        if true {
            // ctx.replacePathWithStrokedPath()：用描边的版本路径替换图形上下文中的路径。配合 ctx.clip()裁剪画布，可达到只在当前描边的路径中绘制的效果
            // 由于要使用 ctx.clip() 函数，在裁剪画布之后，后续的绘图操作都只能在裁剪后的画布范围内绘制。
            // 若要恢复(扩大)到之前的画布大小，必须在clip之前使用ctx.saveGState()保存一份当前的绘图状态，在clip裁剪并绘制完成之后，使用ctx.restoreGState()恢复原来的画布大小
            ctx.saveGState()
            
            let start = CGPoint(x: 50, y: 500)
            let end = CGPoint(x: 350, y: 500)
            let zero = CGPoint.zero
            ctx.addLines(between: [start, end])
            ctx.addRect(CGRect(x: 50, y: 500, width: 300, height: 100))
            ctx.closePath()
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
