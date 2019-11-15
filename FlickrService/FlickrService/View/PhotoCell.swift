//
//  PhotoCell.swift
//  FlickrService
//
//  Created by Ekrem TAŞKIRAN on 15.11.2019.
//  Copyright © 2019 Ekrem TAŞKIRAN. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoCell: BaseCell {
  
  var photo: Photo? {
    didSet {
      self.imageView.sd_setImage(with: self.photo?.imageUrl)
    }
  }
  
  let imageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.layer.cornerRadius = 16
    return iv
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(imageView)
    imageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
