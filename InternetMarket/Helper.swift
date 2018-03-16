//
//  Helper.swift
//  InternetMarket
//
//  Created by Alexander Yakovenko on 3/15/18.
//  Copyright © 2018 Alexander Yakovenko. All rights reserved.
//

import Foundation
import UIKit

class Helper {
    static let shared = Helper()
    static var isEmptyArrayOfModel = true
    static var arrayThings: [Model] = []
    func imageToData(image: UIImage) -> Data? {
        return UIImagePNGRepresentation(image)
    }
    func dataToImage(data: Data) -> UIImage? {
        return UIImage(data: data)
    }
}
