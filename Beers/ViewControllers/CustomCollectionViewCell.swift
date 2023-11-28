//
//  CustomCollectionViewCell.swift
//  Beers
//
//  Created by Yauheni Yursha on 17/11/2023.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var firstLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!
    
    private var imageURL: URL? {
        didSet {
            imageView.image = nil
            updateImage()
        }
    }
    
    func configure(beer : Beer) {
        firstLabel.text = beer.name
        secondLabel.text = beer.tagline
        imageURL = URL(string: beer.imageURL)
    }
    
    private func updateImage() {
        guard let imageurl = imageURL else { return }
        getImage(from: imageurl) { result in
            switch result {
            case .success(let image):
                if imageurl == self.imageURL {
                    self.imageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
        // Проверяем есть ли картинка в  кэше если нет то загружаем с интернета.
    private func getImage(from url: URL, complition: @escaping(Result<UIImage, Error>) -> Void) {
        //get image from cache
        if let cachImage = ImageCache.shared.object(forKey: url.lastPathComponent as NSString) {
            print("Image from cache", url.lastPathComponent)
            complition(.success(cachImage))
            return
        }
        //download image from url
        Networking.shared.fetchImage(from: url) { result in
            switch result {
            case .success(let imageData):
                guard let image = UIImage(data: imageData) else { return }
                ImageCache.shared.setObject(image, forKey: url.lastPathComponent as NSString)
                print("Image from network", url.lastPathComponent)
                complition(.success(image))
            case .failure(let error):
                complition(.failure(error))
            }
        }
    }
    
}
