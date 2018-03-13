//
//  TransformsViewController.swift
//  Quartz2D
//
//  Created by 雷广 on 2018/3/12.
//  Copyright © 2018年 leiguang. All rights reserved.
//

import UIKit

class TransformsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let v = TransformsView(frame: view.bounds)
        v.backgroundColor = .white
        view.addSubview(v)
    }
}


class TransformsView: UIView {

    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()!
        
        
        let image = UIImage(named: "dalao")!
        let cgImage = image.cgImage!
        
        print("\(image.size)")
        print("\(cgImage.width), \(cgImage.height)")
        
        
        // 1.在绘制到context前通过矩阵垂直翻转坐标系
        let rect1 = CGRect(x: 0, y: 0, width: cgImage.width, height: cgImage.height)
        ctx.saveGState()
        ctx.translateBy(x: 0, y: 100 + image.size.height)
        ctx.scaleBy(x: 1, y: -1)
        ctx.draw(cgImage, in: rect1)
        ctx.restoreGState()

        // 2.使用UIImage的drawInRect函数，该函数内部能自动处理图片的正确方向
        let rect2 = CGRect(x: 0, y: 450, width: image.size.width, height: image.size.height)
//        ctx.translateBy(x: 0, y: 200)
//        ctx.scaleBy(x: 0.5, y: 0.5)
//        ctx.rotate(by: CGFloat.pi / 2)    // 转不见了。。。对矩阵的变换还不熟悉
        image.draw(in: rect2)
        
        
        let start = CGPoint(x: 0, y: 400)
        let end = CGPoint(x: 300, y: 400)
        ctx.addLines(between: [start, end])
        ctx.setLineWidth(10)
        ctx.setStrokeColor(UIColor.red.cgColor)
        ctx.strokePath()
    }
}
