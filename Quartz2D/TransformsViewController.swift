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
        
        
    }
}
