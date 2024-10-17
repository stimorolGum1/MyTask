//
//  UIImageExtensions.swift
//  MyTask
//
//  Created by Danil on 17.10.2024.
//

import UIKit

extension UIImage {
    func resizeImage() -> UIImage? {
        let size = CGSize(width: 30, height: 30)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
