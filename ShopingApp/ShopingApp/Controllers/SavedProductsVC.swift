//
//  SavedProductsVC.swift
//  ShopingApp
//
//  Created by Abduraxmon on 25/03/23.
//

import UIKit

class SavedProductsVC: UIViewController {
    
    @IBOutlet weak var blurView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if ProductData.products.isEmpty {
            blurView.isHidden = false
        } else {
            blurView.isHidden = true
        }
        collectionView.reloadData()
    }
    
    func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "LatestCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
    
}

extension SavedProductsVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ProductData.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LatestCell
        
        cell.priceLbl.font = cell.priceLbl.font?.withSize(20)
        cell.nameLbl.font = cell.nameLbl.font.withSize(30)
        cell.categoryBtn.isHidden = true
        cell.addBtn.isHidden = true
        
        
        let product = ProductData.products[indexPath.row]
        cell.nameLbl.text = product.name
        cell.priceLbl.text = product.price
        cell.productImage.image = product.photo
        return cell
    }
    
}

extension SavedProductsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 50, height: view.frame.width - 50 )
    }
}
