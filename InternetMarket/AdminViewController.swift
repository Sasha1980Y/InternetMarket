//
//  AdminViewController.swift
//  InternetMarket
//
//  Created by Alexander Yakovenko on 3/15/18.
//  Copyright © 2018 Alexander Yakovenko. All rights reserved.
//

import UIKit

class AdminViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageTake: UIImageView!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    var imagePicker: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()
        modelTextField.delegate = self
        priceTextField.delegate = self
        modelTextField.returnKeyType = UIReturnKeyType.done
        priceTextField.returnKeyType = UIReturnKeyType.done
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    //MARK: - Take image
    @IBAction func takePhoto(_ sender: UIButton) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: - Saving Image here
    @IBAction func save(_ sender: AnyObject) {
        UIImageWriteToSavedPhotosAlbum(imageTake.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    //MARK: - Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    //MARK: - Done image capture here
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        
        imageTake.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    @IBAction func saveBarButtonItem(_ sender: Any) {
        
        
        let photo = imageTake.image //?? #imageLiteral(resourceName: "notImage")
        let modelName = modelTextField.text ?? "Not Name"
        var price: Int = 0
        if let priceInt = Int(priceTextField.text!) {
            price = priceInt
        }
        
        Router.shared.requestWith(endUrl: "", parameters: [:], model: Model(photo: photo, name: modelName, price: price))
        Helper.arrayThings.append(Model(photo: photo, name: modelName, price: price) )
        navigationController?.popViewController(animated: true)
        
        
        //performSegue(withIdentifier: "ViewController", sender: self)
    }
    
    
    // MARK: pass Model to array
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "ViewController") {
            
            // rotate image with extension
            //let photo = imageTake.image?.rotated(by: Measurement(value: 90.0, unit: .degrees) ) ?? #imageLiteral(resourceName: "notImage")
            let photo = imageTake.image //?? #imageLiteral(resourceName: "notImage")
            
            
            let modelName = modelTextField.text ?? "Not Name"
            var price: Int = 0
            if let priceInt = Int(priceTextField.text!) {
                price = priceInt
            }

            if segue.identifier == "ViewController"{
                // var vc = segue.destination as! ViewController
                // requestWith(endUrl: "", imageData: nil, parameters: [:], dataImage: data)
                //Router.shared.requestWith(endUrl: "", parameters: [:], model: Model(photo: photo, name: modelName, price: price ))
                
                Helper.arrayThings.append(Model(photo: photo, name: modelName, price: price) )
            }
            
        }
    }
    @IBAction func backButton(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
    
}

extension AdminViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// extension for rotate image
extension UIImage {
    struct RotationOptions: OptionSet {
        let rawValue: Int
        
        static let flipOnVerticalAxis = RotationOptions(rawValue: 1)
        static let flipOnHorizontalAxis = RotationOptions(rawValue: 2)
    }
    
    func rotated(by rotationAngle: Measurement<UnitAngle>, options: RotationOptions = []) -> UIImage? {
        guard let cgImage = self.cgImage else { return nil }
        
        let rotationInRadians = CGFloat(rotationAngle.converted(to: .radians).value)
        let transform = CGAffineTransform(rotationAngle: rotationInRadians)
        var rect = CGRect(origin: .zero, size: self.size).applying(transform)
        rect.origin = .zero
        
        let renderer = UIGraphicsImageRenderer(size: rect.size)
        return renderer.image { renderContext in
            renderContext.cgContext.translateBy(x: rect.midX, y: rect.midY)
            renderContext.cgContext.rotate(by: rotationInRadians)
            
            let x = options.contains(.flipOnVerticalAxis) ? -1.0 : 1.0
            let y = options.contains(.flipOnHorizontalAxis) ? 1.0 : -1.0
            renderContext.cgContext.scaleBy(x: CGFloat(x), y: CGFloat(y))
            
            let drawRect = CGRect(origin: CGPoint(x: -self.size.width/2, y: -self.size.height/2), size: self.size)
            renderContext.cgContext.draw(cgImage, in: drawRect)
        }
    }
}
