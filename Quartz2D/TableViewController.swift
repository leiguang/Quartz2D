//
//  TableViewController.swift
//  Quartz2D
//
//  Created by 雷广 on 2018/3/4.
//  Copyright © 2018年 leiguang. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let titles = [
        ["title": "画线", "className": "DrawLineViewController"],
        ["title": "画图形", "className": "DrawShapeViewController"],
        ["title": "画阴影", "className": "ShadowsViewController"],
        ["title": "图形变换", "className": "TransformsViewController"],
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Quartz 2D"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = titles[indexPath.row]["title"]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 在Swift中，由字符串转为类型的时候，如果类型是自定义的，需要在类型字符串前边加上你的项目的名字！
        let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
        let vcClass = NSClassFromString(appName + "." + titles[indexPath.row]["className"]!) as! UIViewController.Type
        navigationController?.pushViewController(vcClass.init(), animated: true)
    }

}
