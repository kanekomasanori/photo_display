//
//  PhotoCollectionViewCell.swift
//  PhotoDisplay
//
//  Created by Masanori.KANEKO on 2015/08/04.
//  Copyright (c) 2015年 Masanori.KANEKO. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet var photoImageView:UIImageView!
    var photoImageData: NSData! {
        didSet {
            photoImageView.image = UIImage(data: self.photoImageData)
        }
    }
}
