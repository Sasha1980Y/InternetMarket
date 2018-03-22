//
//  Router.swift
//  InternetMarket
//
//  Created by Alexander Yakovenko on 3/22/18.
//  Copyright © 2018 Alexander Yakovenko. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct JSON: Decodable {
    
    var data: [Models]
    
    struct Models: Decodable {
        var name: String?
        var price: String?
        var imageURL: String?
    }
    
    
    
}

class Router {
    
    static let shared = Router()
    
    
    
    
    func downloadModel() {
        let stringUrl = "https://easy-shop-app.herokuapp.com/api/product"// + "&maxResults=25"
        
        guard let url = URL(string: stringUrl) else {
            print("url problem")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, resp, error) in
            
            
            
            
            print("download books")
            guard let data = data else {
                return
            }
            guard error == nil else {
                return
            }
            
            
            
            do {
                
                let json = try JSONDecoder().decode(JSON.self, from: data)
                print("ok")
                let models = json.data
                
                Helper.arrayThings = []
                
                for model in models {
                    //Helper.arrayThings.append(Model(photo: , name: model.name, price: model.price) )
                    
                    print(model.name)
                }
                
                
                DispatchQueue.main.async {
                    
                    //json.data.
                    //if let countItem = json.name {
                        
                        //self.books = countItem
                        
                    //}
                    
                    DispatchQueue.main.async(execute: { () -> Void in
                        //self.tableView.reloadData()
                    })
                    
                }
                print("Books VC")
                
            } catch let error {
                print(error)
            }
            }.resume()
    }
    
    
    // POST request
    func requestWith(endUrl: String, parameters: [String : Any], model: Model, onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
        
            let url = "https://easy-shop-app.herokuapp.com/api/product/add" /* your API url */
            
            let headers: HTTPHeaders = [
                /* "Authorization": "your_access_token",  in case you need authorization header */
                "Content-type": "multipart/form-data"
            ]
            
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in parameters {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                
                // append image
                if let image2 = model.photo {
                    if let dataImage2 = UIImageJPEGRepresentation(image2, 1.0) {
                        multipartFormData.append(dataImage2, withName: "image", fileName: "image.png", mimeType: "image/png")
                    }
                }
                
                // name string to data
                let testString = model.name
                let somedata = testString.data(using: String.Encoding.utf8)
                //var backToString = String(data: somedata!, encoding: String.Encoding.utf8) as String!
                multipartFormData.append(somedata!, withName: "name") //somedata!
                
                //price to string to data
                let myInt = model.price
                let dataInt = String(myInt)
                let somedata1 = dataInt.data(using: String.Encoding.utf8)
                multipartFormData.append(somedata1!, withName: "price")
                
            }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers) { (result) in
                switch result{
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        print("Succesfully uploaded")
                        if let err = response.error{
                            onError?(err)
                            return
                        }
                        onCompletion?(nil)
                    }
                case .failure(let error):
                    print("Error in upload: \(error.localizedDescription)")
                    onError?(error)
                }
            }
        
    }
    
}
