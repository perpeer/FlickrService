//
//  Service.swift
//  FlickrService
//
//  Created by Ekrem TAŞKIRAN on 15.11.2019.
//  Copyright © 2019 Ekrem TAŞKIRAN. All rights reserved.
//

import Foundation

class Service {
  static let shared = Service()

  func fetchDataFromWith(page: Int, completionHandler: @escaping (FlickrResults?, Error?) -> Void) {
    let url = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=\(Constants.api_key)&format=json&nojsoncallback=1&safe_search=1&per_page=\(Constants.per_page)&page=\(page)")
    print("Service:fetchDataFromWith - Page:\(page)")
    URLSession.shared.dataTask(with: url!) { (data, resp, err) in
      if let err = err {
        print("fetchDataFromUrl failed: ", err)
        return
      }
      if let data = data {
        do {
          let json = try JSONDecoder().decode(FlickrResults.self, from: data)
          if let stat = json.stat, stat == .Ok {
            completionHandler(json, nil)

//          json.photos?.photo.forEach({ (photo) in
//            print("\(photo.id), \(photo.isPublic), \(photo.isFriend), \(photo.isFamily)" )
//          })
          } else {
            completionHandler(nil, err)
          }
        } catch let err {
          print(err.localizedDescription)
          completionHandler(nil, err)
        }
      }
    }.resume()
  }
}
