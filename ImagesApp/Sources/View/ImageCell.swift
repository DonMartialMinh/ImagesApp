//
//  ImageCell.swift
//  ImagesApp
//
//  Created by don.vo on 8/30/24.
//

import UIKit

class ImageCell: UICollectionViewCell {

    let activityIndicator = UIActivityIndicatorView(style: .medium)
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    func setupViews() {
        addSubview(imageView)
        addSubview(activityIndicator)

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true      
        imageView.layer.cornerRadius = 7
        imageView.layer.masksToBounds = true

        activityIndicator.startAnimating()
    }

    func configure(with image: UIImage) {
        self.imageView.image = image
        activityIndicator.stopAnimating()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
        activityIndicator.frame = bounds
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        activityIndicator.startAnimating()
    }
}
