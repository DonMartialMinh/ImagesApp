//
//  ViewModel.swift
//  ImagesApp
//
//  Created by don.vo on 8/30/24.
//

import UIKit

protocol ViewModelProtocol {

    var imageCount: Int { get }

    func loadNewImage(index: Int, completion: @escaping ((UIImage) -> Void))
    func addImage()
    func reloadImages()
}

final class ViewModel: ViewModelProtocol {

    private let imageService: ImageServiceProtocol

    var imageCount: Int = 0

    init(imageService: ImageServiceProtocol = ImageService()) {
        self.imageService = imageService
    }

    func loadNewImage(index: Int, completion: @escaping ((UIImage) -> Void)) {
        imageService.getImage(
            index: index,
            urlString: "https://loremflickr.com/200/200/",
            completion: completion
        )
    }

    func addImage() {
        imageCount += 1
    }

    func reloadImages() {
        imageService.clearCachedImages()
        imageCount = 140
    }
}
