//
//  ImageCacher.swift
//  ImagesApp
//
//  Created by don.vo on 8/30/24.
//

import UIKit

protocol ImageCacherProtocol {

    func getImage(index: Int) -> UIImage?
    func setImage(index: Int, image: UIImage)
    func clearCachedImages()
}

final class ImageCacher: ImageCacherProtocol {

    let cached: CacheHelper<Int, UIImage>

    init(cost: Int = 50_000_000) {
        cached = CacheHelper<Int, UIImage>(cost: cost)
    }

    func getImage(index: Int) -> UIImage? {
        guard let image = cached[index] else {
            return nil
        }
        return image
    }

    func setImage(index: Int, image: UIImage) {
        cached[index] = image
    }

    func clearCachedImages() {
        cached.removeAll()
    }
}
