//
//  Extensions.swift
//  SaleApp
//
//  Created by logan on 2018/4/9.
//  Copyright © 2018 Chuanqi. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()


extension UIImageView{
    func downLoadAndCacheImageFromURL(urlString: String){
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString){
            self.image = cachedImage
            return
        }
        
        
        if let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print("Failed to download image with error: ", error?.localizedDescription ?? "")
                }
                if let imageData = data{
                    DispatchQueue.main.async {
                        if let downloadedImage = UIImage(data: imageData) {
                            imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                            self.image = downloadedImage
                        }
                    }
                }
            }.resume()
        }
    }
}
