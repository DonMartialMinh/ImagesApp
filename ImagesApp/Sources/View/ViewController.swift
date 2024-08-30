//
//  ViewController.swift
//  ImagesApp
//
//  Created by don.vo on 8/30/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    private lazy var viewModel: ViewModelProtocol = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "images"
        configureCollectionView()
        addBarButton()
    }

    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2

        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true

        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
    }

    func addBarButton() {
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewImages)
        )
        let reloadButton = UIBarButtonItem(
            title: "Reload",
            style: .plain,
            target: self,
            action: #selector(reloadAllImages)
        )
        navigationItem.rightBarButtonItems = [addButton, reloadButton]
    }

    @objc func addNewImages() {
        viewModel.addImage()
        collectionView.reloadData()
    }

    @objc func reloadAllImages() {
        viewModel.reloadImages()
        collectionView.reloadData()
    }
}

// MARK: - CollectionView DataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.imageCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell else {
            return UICollectionViewCell()
        }

        viewModel.loadNewImage(index: indexPath.row) { image in
            DispatchQueue.main.async {
                cell.configure(with: image)
            }
        }

        return cell
    }
}

// MARK: - CollectionView DelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 7
        let numberOfRows: CGFloat = 10
        let horizontalSpacing: CGFloat = 2
        let verticalSpacing: CGFloat = 2

        let totalHorizontalSpacing = horizontalSpacing * (numberOfColumns - 1)
        let totalVerticalSpacing = verticalSpacing * (numberOfRows - 1)

        let width = (collectionView.bounds.width - totalHorizontalSpacing) / numberOfColumns
        let height = (collectionView.bounds.height - totalVerticalSpacing) / numberOfRows

        return CGSize(width: width, height: height)
    }
}

