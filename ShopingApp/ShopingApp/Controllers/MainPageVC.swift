//
//  MainPageVC.swift
//  ShopingApp
//
//  Created by Abduraxmon on 19/03/23.
//

import UIKit

class MainPageVC: UIViewController {
    
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var latestCollView: UICollectionView!
    @IBOutlet weak var flashSaleCollView: UICollectionView!
    
    var dataTask:URLSessionDataTask?
    var latestProducts = [Latest]()
    var flashSaleProductd = [FlashSale]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeRequest(with: "https://run.mocky.io/v3/a9ceeb6e-416d-4352-bde6-2203416576ac")
        makeRequest(with: "https://run.mocky.io/v3/cc0071a1-f06e-48fa-9e90-b1c2a61eaca7")
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .systemGray
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 10)
        button.frame = CGRect(x: CGFloat(searchTF.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        //button.addTarget(self, action: #selector(self.refresh), for: .touchUpInside)
        searchTF.rightView = button
        searchTF.rightViewMode = .always
        setUpCollectionView()
    }
    
    func setUpCollectionView() {
        latestCollView.dataSource = self
        latestCollView.delegate = self
        flashSaleCollView.dataSource = self
        flashSaleCollView.delegate = self
        latestCollView.register(UINib(nibName: "LatestCell", bundle: nil), forCellWithReuseIdentifier: "cell1")
        flashSaleCollView.register(UINib(nibName: "FlashSaleCell", bundle: nil), forCellWithReuseIdentifier: "cell2")
    }
    
    func parse(data: Data, type: Int) -> [Any] {
        
        do {
            let decoder = JSONDecoder()
            if type == 1 {
                let result = try decoder.decode(LatestModel.self, from: data)
                return result.latest
            } else {
                let result = try decoder.decode(FlashSaleModel.self, from: data)
                return result.flashSale
            }
        } catch {
            return []
        }
        
    }
    
    func makeRequest(with str: String) {
        
        let url = URLRequest(url: URL(string: str)!)
        let sesion = URLSession.shared
        
        dataTask = sesion.dataTask(with: url, completionHandler: { data, response, error in
            if error != nil {
                return
            } else if let httpResponce = response as? HTTPURLResponse, httpResponce.statusCode == 200 {
                if let data = data {
                    if str == "https://run.mocky.io/v3/cc0071a1-f06e-48fa-9e90-b1c2a61eaca7" {
                        self.latestProducts = self.parse(data: data, type: 1) as! [Latest]
                    } else {
                        self.flashSaleProductd = self.parse(data: data, type: 2) as! [FlashSale]
                    }
                    DispatchQueue.main.async {
                        self.latestCollView.reloadData()
                        self.flashSaleCollView.reloadData()
                    }
                    return
                }
            } else {
                print("error ocureed")
            }
            
            DispatchQueue.main.async {
                self.latestCollView.reloadData()
                self.flashSaleCollView.reloadData()
            }
            
        })
        
        dataTask?.resume()
    }
}

extension MainPageVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == latestCollView {
           return latestProducts.count
        } else {
            return flashSaleProductd.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell1 = latestCollView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! LatestCell
        let cell2 = flashSaleCollView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! FlashSaleCell
        
        if collectionView == self.latestCollView {
            cell1.nameLbl.text = latestProducts[indexPath.row].name
            cell1.categoryBtn.setTitle(latestProducts[indexPath.row].category, for: .normal)
            cell1.priceLbl.text = "$ \(latestProducts[indexPath.row].price)"
            cell1.productImage.loadFrom(URLAddress: latestProducts[indexPath.row].imageURL)
            return cell1
        } else {
            cell2.categoryBtn.setTitle(flashSaleProductd[indexPath.row].category, for: .normal)
            cell2.priceLbl.text = "$ \(flashSaleProductd[indexPath.row].price)"
            cell2.nameLbl.text = flashSaleProductd[indexPath.row].name
            cell2.discountLbl.setTitle("\(flashSaleProductd[indexPath.row].discount)% off", for: .normal)
            cell2.productImage.loadFrom(URLAddress: flashSaleProductd[indexPath.row].imageURL)
            return cell2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ProductDetailVC(nibName: "ProductDetailVC", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
        
        if collectionView == self.latestCollView {
            vc.productName.text = latestProducts[indexPath.row].name
            vc.ProductPrice.text = "$ \(latestProducts[indexPath.row].price)"
            vc.mainPhoto.loadFrom(URLAddress: latestProducts[indexPath.row].imageURL)
            vc.firstImage.loadFrom(URLAddress: latestProducts[indexPath.row].imageURL)
            vc.secondImage.loadFrom(URLAddress: latestProducts[indexPath.row].imageURL)
            vc.thirdImage.loadFrom(URLAddress: latestProducts[indexPath.row].imageURL)
        } else {
            vc.productName.text = flashSaleProductd[indexPath.row].name
            vc.ProductPrice.text = "$ \(flashSaleProductd[indexPath.row].price)"
            vc.mainPhoto.loadFrom(URLAddress: flashSaleProductd[indexPath.row].imageURL)
            vc.firstImage.loadFrom(URLAddress: flashSaleProductd[indexPath.row].imageURL)
            vc.secondImage.loadFrom(URLAddress: flashSaleProductd[indexPath.row].imageURL)
            vc.thirdImage.loadFrom(URLAddress: flashSaleProductd[indexPath.row].imageURL)
        }
    }
    
}

extension MainPageVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.latestCollView {
            return CGSize(width: 114, height: 149)
        } else {
            return CGSize(width: 174, height: 221)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 20
    }
}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        
        
        if let url = URL(string: URLAddress) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
              // Error handling...
              guard let imageData = data else { return }

              DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
              }
            }.resume()
          }
    }
}

