//
//  BeersCollectionViewController.swift
//  Beers
//
//  Created by Yauheni Yursha on 17/11/2023.
//

import UIKit

private let reuseIdentifier = "Cell"

class BeersCollectionViewController: UICollectionViewController {
    
    private var beers: [Beer] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        fetchData(url: Link.beerUrl.rawValue)
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //guard let indexPath = collectionView.indexPathsForSelectedItems else { return }
        guard let detailsVC = segue.destination as? DetailsViewController else { return }
        detailsVC.beer = sender as? Beer
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        beers.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        /*
        let beer = beers[indexPath.row]
        Networking.shared.fetchImageString(from: beer.imageURL) { imageData in
            cell.imageView.image = UIImage(data: imageData)
        }
        cell.firstLabel.text = beer.name
        cell.secondLabel.text = beer.tagline
         */
        cell.configure(beer: beers[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let oneBeer = beers[indexPath.item]
        performSegue(withIdentifier: "detailsVC", sender: oneBeer)
    }
    
    private func fetchData(url: String) {
        Networking.shared.fetchData(from: url) { beer in
            self.beers = beer
            self.collectionView.reloadData()
        }
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension BeersCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}
