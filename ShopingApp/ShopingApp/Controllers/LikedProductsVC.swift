//
//  LikedProductsVC.swift
//  ShopingApp
//
//  Created by Abduraxmon on 22/03/23.
//

import UIKit

class LikedProductsVC: UIViewController {
    
    @IBOutlet weak var warningView:
    UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        
    }
    
    func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "FlashSaleCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        if LikedProductData.products.isEmpty {
            warningView.isHidden = false
        } else {
            warningView.isHidden = true
        }
        
    }
}

extension LikedProductsVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LikedProductData.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FlashSaleCell
        cell.likeBtn.isHidden = true
        let likedProduct = LikedProductData.products[indexPath.row]
        cell.categoryBtn.transform = CGAffineTransform(scaleX: 2, y: 2)
        cell.discountLbl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        cell.statusImage.isHidden = true
        cell.priceLbl.font = cell.priceLbl.font?.withSize(20)
        cell.nameLbl.font = cell.nameLbl.font.withSize(30)
        cell.nameLbl.frame.size.width = 10
        
        cell.nameLbl.text = likedProduct.name
        cell.productImage.image = likedProduct.photo
        cell.priceLbl.text = likedProduct.price
        
        return cell
    }
    
}
extension LikedProductsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 50, height: view.frame.width - 50 )
    }
}
