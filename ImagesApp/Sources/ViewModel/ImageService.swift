//
//  ImageService.swift
//  ImagesApp
//
//  Created by don.vo on 8/30/24.
//

import UIKit

protocol ImageServiceProtocol {
    func getImage(
        index: Int,
        urlString: String,
        completion: @escaping ((UIImage) -> Void)
    )
    func clearCachedImages()
}

final class ImageService: ImageServiceProtocol {
    private let imageCacher: ImageCacherProtocol
    private let network: NetworkProtocol

    init(
        imageCacher: ImageCacherProtocol = ImageCacher(),
        network: NetworkProtocol = Network.shared()
    ) {
        self.imageCacher = imageCacher
        self.network = network
    }

    func getImage(
        index: Int,
        urlString: String,
        completion: @escaping ((UIImage) -> Void)
    ) {

        if let cachedImage = imageCacher.getImage(index: index)  {
            return completion(cachedImage)
        }

        network.request(with: urlString) { [weak self] result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    completion(UIImage())
                    return
                }
                completion(image)
                self?.imageCacher.setImage(index: index, image: image)
            case .failure(_):
                completion(UIImage())
            }
        }
    }

    func clearCachedImages() {
        imageCacher.clearCachedImages()
    }
}
