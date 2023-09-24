//
//  DetailViewController.swift
//  WBTest
//
//  Created by SHREDDING on 23.09.2023.
//

import UIKit

class DetailViewController: UIViewController {

    var presenter:DetailPresenterProtocol?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var viewsCountLabel: UILabel!
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!{
        didSet{
            
            self.imagesCollectionView.contentInsetAdjustmentBehavior = .never
            
            let nib = UINib(nibName: "ImageCollectionViewCell", bundle: nil)
            imagesCollectionView.register(nib, forCellWithReuseIdentifier: "ImageCollectionViewCell")
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(likeTapped))
        
        self.navigationItem.rightBarButtonItem?.tintColor = .systemRed
        titleLabel.text = self.presenter?.region.title ?? ""
        self.navigationItem.largeTitleDisplayMode = .never
        self.viewsCountLabel.text = "Количество просмотров: \(self.presenter?.region.viewsCount ?? 0)"
        
        
        
        if (self.presenter?.region.isLiked ?? false){
            self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
        }else{
            self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
        }
        
    }
    
    @objc func likeTapped(){
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        self.presenter?.region.isLiked = !self.presenter!.region.isLiked
        
        if self.presenter!.region.isLiked{
            self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
            Region.favouritesRegionsLocalStorage.append(self.presenter!.region)
        }else{
            self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
            let index = Region.favouritesRegionsLocalStorage.firstIndex(of: self.presenter!.region)!
            Region.favouritesRegionsLocalStorage.remove(at: index)
        }
                
    }
    
}

extension DetailViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter?.region.imagesURls.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        
        DispatchQueue.main.async {
            self.presenter?.loadPhoto(url: self.presenter?.region.imagesURls[indexPath.row] ?? "", completion: { image in
                DispatchQueue.main.async{
                    cell.image.image = image
                    cell.secondImage.image = image
                }
                
            })
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.imagesCollectionView.frame.size
    }
    
    
}


extension DetailViewController:DetailViewProtocol{
//    self.imagesCollectionView.reloadData()
}
