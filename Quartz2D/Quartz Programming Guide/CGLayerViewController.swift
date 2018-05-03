//
//  CGLayerViewController.swift
//  Quartz2D
//
//  Created by 雷广 on 2018/3/16.
//  Copyright © 2018年 leiguang. All rights reserved.
//

import UIKit

// [Core Graphics Layer Drawing](https://developer.apple.com/library/content/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_layers/dq_layers.html#//apple_ref/doc/uid/TP30001066-CH219-TPXREF101)

/**
 
 提示：如果要合成图形的某些部分，将效果应用于一组对象时，请使用Transparency Layers。当您想要离屏渲染（不知道这里offscreen是不是指的离屏渲染，待解决） 或需要重复绘制相同的东西(对于只使用一次的对象，直接绘制就好了，没必要用CGALayer) 时使用CGLayer对象。
 Tip:  Use transparency layers when you want to composite parts of a drawing to achieve such effects as shadowing a group of objects. (See Transparency Layers.) Use CGLayer objects when you want to draw offscreen or when you need to repeatedly draw the same thing.
 */


class CGLayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}

class CGLayerView: UIView {
    override func draw(_ rect: CGRect) {
        
    }
}
