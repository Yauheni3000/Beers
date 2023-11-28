//
//  DetailsViewController.swift
//  Beers
//
//  Created by Yauheni Yursha on 17/11/2023.
//

import UIKit

class DetailsViewController: UIViewController {

    var beer: Beer?

    @IBOutlet var beerImage: UIImageView!
    @IBOutlet var descritionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        installWelpaper()
        descritionLabel.text = beer?.description
        Networking.shared.fetchImageString(from: beer?.imageURL) { imageData in
            self.beerImage.image = UIImage(data: imageData)
        }
    }
    
    //добавление фоновой картинки вместо backgroundColor
    func installWelpaper() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "whitebeer")
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.alpha = 1
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
    }
}
