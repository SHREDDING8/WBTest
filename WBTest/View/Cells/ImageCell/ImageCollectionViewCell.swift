//
//  ImageCollectionViewCell.swift
//  WBTest
//
//  Created by SHREDDING on 23.09.2023.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var secondImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    override func prepareForReuse() {
        self.image.image = nil
        secondImage.image = nil
    }
}
