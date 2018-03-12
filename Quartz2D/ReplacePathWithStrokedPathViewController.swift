//
//  ReplacePathWithStrokedPathViewController.swift
//  Quartz2D
//
//  Created by 雷广 on 2018/3/8.
//  Copyright © 2018年 leiguang. All rights reserved.
//

import UIKit

class ReplacePathWithStrokedPathViewController: UIViewController {

    var myView: ReplacePathWithStrokedPathView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myView = ReplacePathWithStrokedPathView(frame: view.bounds)
        myView.backgroundColor = .white
        view.addSubview(myView)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
    }

    @objc func add() {
        myView.x += 50
        myView.setNeedsDisplay()
    }
}


class ReplacePathWithStrokedPathView: UIView {

    var x: Double = 0
    
    override func draw(_ rect: CGRect) {
        
        let y: Double = 200
        
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.beginPath()
        ctx?.move(to: CGPoint(x: x, y: y))
        ctx?.addLine(to: CGPoint(x: x+50, y: y))
        ctx?.setLineWidth(10)
        ctx?.setStrokeColor(UIColor.green.cgColor)
        ctx?.strokePath()
    }
}
