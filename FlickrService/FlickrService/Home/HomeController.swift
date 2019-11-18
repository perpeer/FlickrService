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
  private var fetchingMore = false
  private var nextPage = 1
  
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
  }
  
  fileprivate func dataFetchWith(page: Int) {
    Service.shared.fetchDataFromWith(page: page) { (result, err) in
      if let result = result {
        if let photos = result.photos?.photo {
          if self.photos == nil {
            self.photos = photos
          } else {
            self.photos?.append(contentsOf: photos)
          }
        }
        if let page = result.photos?.page {
          self.nextPage = page + 1
        }
      }
      self.fetchingMore = false
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
  
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offsetY = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    
    if offsetY > contentHeight - scrollView.frame.height {
      if !fetchingMore {
        dataFetchWith(page: nextPage)
        fetchingMore = true
      }
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let photo = photos?[indexPath.item] else { return }
    let detailsController = DetailsController()
    detailsController.photo = photo
    let navController = UINavigationController(rootViewController: detailsController)
    navController.modalPresentationStyle = .fullScreen
    present(navController, animated: true, completion: nil)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width - 32, height: 400)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 32
  }
}
