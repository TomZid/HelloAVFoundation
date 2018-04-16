//
//  TZDataManager.swift
//  SwiftRadio
//
//  Created by tom on 2018/4/16.
//  Copyright © 2018年 matthewfecher.com. All rights reserved.
//

import UIKit

struct TZDataManager {

    static func getDataFromJson(handler: (Data?) -> ()) {
        guard let path = Bundle.main.path(forResource: "stations", ofType: "json") else {
            return
        }
        let data = try? Data.init(contentsOf: URL.init(fileURLWithPath: path))
        handler(data)
    }

}
