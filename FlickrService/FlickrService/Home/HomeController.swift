//
//  HomeController.swift
//  FlickrService
//
//  Created by Ekrem TAŞKIRAN on 15.11.2019.
//  Copyright © 2019 Ekrem TAŞKIRAN. All rights reserved.
//

import UIKit

class HomeController: BaseListController {
  
  private let cellId = "cellId"
  
  var photos: [Photo]? {
    didSet {
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: cellId)
    
    Service.shared.fetchDataFrom { (result, err) in
      result?.photos?.photo.forEach({ (photo) in
        print(photo.imageUrl)
      })
      
      if let photos = result?.photos?.photo {
          self.photos = photos
      }
    }
  }
}

extension HomeController: UICollectionViewDelegateFlowLayout {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photos?.count ?? 0
  }
  
 override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PhotoCell
  if let photos = photos {
    cell.photo = photos[indexPath.item]
  }
  return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width - 32, height: 400)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 32
  }
}
