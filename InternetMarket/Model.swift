//
//  Model.swift
//  InternetMarket
//
//  Created by Alexander Yakovenko on 3/12/18.
//  Copyright © 2018 Alexander Yakovenko. All rights reserved.
//

import Foundation
import UIKit

struct Model {  // Codable
    var photo: UIImage?
    var name: String
    var price: Int
    
    /* for convert to data
    var description: [String: Any] {
        get {
            return ["photo": name, "name": name, "price": price] as [String : Any]
        }
    }
    */
    /*
    enum ModelKeys: String, CodingKey
    {
        case name, price, photoData
    }
    init(photo: Data, name: String, price: Int) {
        self.photo = photo
        self.name = name
        self.price = price
    }
    init(from decoder: Decoder) throws {
        let container =  try decoder.container (keyedBy: ModelKeys.self)
        name = try container.decode (String.self, forKey: .name)
        price = try container.decode (Int.self, forKey: .price)
        photo = try container.decode (Data.self, forKey: .photoData)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container (keyedBy: ModelKeys.self)
        try container.encode (name, forKey: .name)
        try container.encode (price, forKey: .price)
        try container.encode (photo, forKey: .photoData)
    }
 */
}




