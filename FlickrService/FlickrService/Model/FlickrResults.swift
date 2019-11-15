//
//  FlickrResults.swift
//  FlickrService
//
//  Created by Ekrem TAŞKIRAN on 15.11.2019.
//  Copyright © 2019 Ekrem TAŞKIRAN. All rights reserved.
//

import Foundation

struct FlickrResults: Codable {
  let stat: Stat?
  let photos: Photos?
  let code: Int?
  let message: String?
}

enum Stat: String, Codable {
  case Ok = "ok"
  case Fail = "fail"
  case Other = "other"
  
  init(from decoder: Decoder) throws {
    let label = try decoder.singleValueContainer().decode(String.self)
    switch label {
    case "ok": self = .Ok
    case "fail": self = .Fail
    default: self = .Other
    }
  }
}

struct Photos: Codable {
  let page: Int
  let pages: Int
  let perpage: Int
  let total: Int
  let photo: [Photo]
}

struct Photo: Codable {
  let id: String
  let owner: String
  let secret: String
  let server: String
  let farm: Int
  let title: String
  let isPublic: Bool?
  let isFriend: Bool?
  let isFamily: Bool?
  
  var imageUrl: URL {
    return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg")!
  }
  
  enum CodingKeys: String, CodingKey {
    case id, owner, secret, server, farm, title
    case isPublic = "ispublic"
    case isFriend = "isfriend"
    case isFamily = "isfamily"
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(String.self, forKey: .id)
    self.owner = try container.decode(String.self, forKey: .owner)
    self.secret = try container.decode(String.self, forKey: .secret)
    self.server = try container.decode(String.self, forKey: .server)
    self.farm = try container.decode(Int.self, forKey: .farm)
    self.title = try container.decode(String.self, forKey: .title)

    if let isPublicValue = try? container.decode(Int.self, forKey: .isPublic), isPublicValue == 1 {
      self.isPublic = true
    } else {
      self.isPublic = false
    }
    
    if let isFriendValue = try? container.decode(Int.self, forKey: .isFriend), isFriendValue == 1 {
      self.isFriend = true
    } else {
      self.isFriend = false
    }
    
    if let isFamilyValue = try? container.decode(Int.self, forKey: .isFamily), isFamilyValue == 1 {
      self.isFamily = true
    } else {
      self.isFamily = false
    }
  }
}

