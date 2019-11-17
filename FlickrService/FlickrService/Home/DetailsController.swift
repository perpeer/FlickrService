//
//  DetailsController.swift
//  FlickrService
//
//  Created by Ekrem TAŞKIRAN on 17.11.2019.
//  Copyright © 2019 Ekrem TAŞKIRAN. All rights reserved.
//

import UIKit
import SDWebImage

class DetailsController: UIViewController {
  
  var photo: Photo? {
    didSet {
      imageView.sd_setImage(with: photo?.imageUrl)
    }
  }
  
  let imageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    return iv
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupLayout()
  }
  
  fileprivate func setupLayout() {
    view.backgroundColor = .white
    view.addSubview(imageView)
    imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(handleNavBackButton))
  }
  
  @objc fileprivate func handleNavBackButton() {
    dismiss(animated: true, completion: nil)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
//    navigationController?.setNavigationBarHidden(true, animated: animated)
  }
}
