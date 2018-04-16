//
//  UIImage+TZDownload.swift
//  SwiftRadio
//
//  Created by tom on 2018/4/16.
//  Copyright © 2018年 matthewfecher.com. All rights reserved.
//

import UIKit

extension UIImageView {

    func loadImage(url: URL) {
        let session = URLSession.shared

        let task = session.downloadTask(with: url, completionHandler: { (url, response, error) in
            guard error == nil else {
                return
            }

            if let path = url {
                let locationPath = path.path
                let documents = NSHomeDirectory() + "/Documents/1.png"
                let fileManeger = FileManager.default

                try? fileManeger.moveItem(atPath: locationPath, toPath: documents)
                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                    if let image = UIImage.init(contentsOfFile: documents) {
                        self.image = image
                    }
                })
            }
        })

        task.resume()

    }

}
