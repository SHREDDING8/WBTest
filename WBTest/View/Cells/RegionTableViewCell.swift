//
//  RegionTableViewCell.swift
//  WBTest
//
//  Created by SHREDDING on 23.09.2023.
//

import UIKit

class RegionTableViewCell: UITableViewCell {
    
    var region:Region!
    
    var doAfterClickLike: ((Bool)->Void)?
    
    @IBOutlet weak var regionImage: UIImageView!{
        didSet{
            self.regionImage.layer.cornerRadius = 5
        }
    }
    
    @IBOutlet weak var regionTitle: UILabel!
    
    @IBOutlet weak var likeImage: UIImageView!{
        didSet{
            let gesture = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
            likeImage.isUserInteractionEnabled = true
            likeImage.addGestureRecognizer(gesture)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func prepareForReuse() {
        regionImage.image = nil
    }
    
    func configure(region:Region){
        self.region = region
        self.regionTitle.text = region.title
        
        if region.isLiked{
            self.likeImage.image = UIImage(systemName: "heart.fill")
        }else{
            self.likeImage.image = UIImage(systemName: "heart")
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func likeTapped(){
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        
        self.region.isLiked = !self.region.isLiked
        
        if self.region.isLiked{
            self.likeImage.image = UIImage(systemName: "heart.fill")
            Region.favouritesRegionsLocalStorage.append(region)
        }else{
            self.likeImage.image = UIImage(systemName: "heart")
            let index = Region.favouritesRegionsLocalStorage.firstIndex(of: region)!
            Region.favouritesRegionsLocalStorage.remove(at: index)
        }
        
        doAfterClickLike?(self.region.isLiked)
        
    }
}
