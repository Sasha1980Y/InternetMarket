//
//  ViewController.swift
//  InternetMarket
//
//  Created by Alexander Yakovenko on 3/12/18.
//  Copyright © 2018 Alexander Yakovenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //var arrayThings: [Model] = []
    //var isEmptyArrayOfModel = true
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Helper.isEmptyArrayOfModel == true {
            Helper.arrayThings = fillArray()
            Helper.isEmptyArrayOfModel = false
        } else {
            
        }
        
        /*
        let userDefault = UserDefaults.standard
        let obj = userDefault.object(forKey: "array")
        if (obj != nil) {
            if let data = userDefault.object(forKey: "array") as? Data {
                if let array = try? JSONDecoder().decode([Model].self, from: data) as [Model] {
                    arrayThings = array
                }
            }
        } else {
            arrayThings = fillArray()
            let encodedData = try? JSONEncoder().encode(arrayThings)
            userDefault.set(encodedData, forKey: "array")
        }
        */
 
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.collectionView.reloadData()
        
        // add swipe from left
        let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeToRight))
        self.view.addGestureRecognizer(gestureRecognizer)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.collectionView.reloadData()
    }
    
    @objc func swipeToRight() {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "AdminViewController") as! AdminViewController
        //self.navigationController?.present(secondViewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    // MARK: collection delegate
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Helper.arrayThings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ModelCollectionViewCell
        
        //let imageViewLeft = UIImageView(image: UIImage(cgImage: (otherImage?.cgImage!)!, scale: CGFloat(1.0), orientation: .left))
        
        cell.imageView.image =  Helper.arrayThings[indexPath.row].photo
        cell.thingLabel.text = "Модель " + Helper.arrayThings[indexPath.row].name
        cell.priceLabel.text = "Ціна " + String(Helper.arrayThings[indexPath.row].price)
        return cell
    }
    // MARK: FillArray
    func fillArray() -> [Model] {
        
        let model1 = Model(photo: #imageLiteral(resourceName: "k1"), name: "1", price: 1000)
        let model2 = Model(photo: #imageLiteral(resourceName: "k2"), name: "2", price: 1100)
        let model3 = Model(photo: #imageLiteral(resourceName: "k3"), name: "3", price: 1300)
        let model4 = Model(photo: #imageLiteral(resourceName: "k4"), name: "4", price: 1400)
        
        
        return [model1, model2, model3, model4]
    }
    
    
}

