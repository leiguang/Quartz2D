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
        
    }
}
