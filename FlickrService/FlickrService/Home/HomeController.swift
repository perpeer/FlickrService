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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: cellId)
  }
}


extension HomeController: UICollectionViewDelegateFlowLayout {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
 override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PhotoCell
  
  
  return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width - 32, height: 400)
  }
}
