 //
//  ComposeViewController.swift
//  Collection
//
//  Created by Serik Seidigalimov on 23.11.2017.
//  Copyright © 2017 Serik Seidigalimov. All rights reserved.
//
import Foundation
import UIKit
import SnapKit
import FirebaseDatabase
import Firebase
import FirebaseStorage

class ComposeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    var composeView : ComposeView { return self.view as! ComposeView }
    var homeView = HomeView()
    
    var ref: DatabaseReference!
    var imagePicker = UIImagePickerController()
    var imgUrl = String()
    
    override func loadView() {
        self.view = ComposeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ref = Database.database().reference()
        
        view.backgroundColor = .white
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(HomeViewController.myRightSideBarButtonItemTapped(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButton        // Do any additional setup after loading the view.
        
        composeView.imgBtn.addTarget(self, action: #selector(handleAttach), for: .touchUpInside)
        
        setupView()
        
        //setupTableView()
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        composeView.titleLabel.text = "Write Bar's name"
        composeView.descLabel.text = "Write Bar's description"
        composeView.avpLabel.text = "Write Bar's average check for one person"
        composeView.titleText.layer.borderColor = UIColor.black.cgColor
        composeView.titleText.layer.borderWidth = 1
        composeView.titleText.autocorrectionType = .no
        composeView.descText.layer.borderColor = UIColor.black.cgColor
        composeView.descText.layer.borderWidth = 1
        composeView.descText.autocorrectionType = .no
        composeView.avpText.layer.borderColor = UIColor.black.cgColor
        composeView.avpText.layer.borderWidth = 1
        composeView.avpText.keyboardType = UIKeyboardType.numberPad
        composeView.avpText.autocorrectionType = .no

        composeView.imgBtn.backgroundColor = .black
        
    }
    
    @IBAction func myRightSideBarButtonItemTapped(_ sender: Any)
    {
        if composeView.titleText.text != "" && composeView.descText.text != "" && composeView.avpText.text != "" && imgUrl != ""{
            ref.child("Bar").child(composeView.titleText.text!).setValue(["BarName": composeView.titleText.text as String!, "Description": composeView.descText.text as String!, "AveragePrice": composeView.avpText.text as String!, "imageUrl": imgUrl as String!, "Rating": 0 as Int!])
            
            composeView.titleText.text = ""
            composeView.descText.text = ""
            composeView.avpText.text = ""
            
            
            let vc = HomeViewController()
            vc.postPostUrl.removeAll()
            vc.postData.removeAll()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
    func addToDatabase(values: [String: Any]){
        
    }
    
    @objc func handleAttach(){
        self.composeView.imgBtn.isUserInteractionEnabled = true
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera :(", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery()
    {
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            composeView.imgView.image = selectedImage
            uploadImage(image: selectedImage)
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func uploadImage(image: UIImage){
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let imageName = NSUUID().uuidString
        
        let imagesReference = storageRef.child("\(imageName).png")
        
        if let imageData = UIImageJPEGRepresentation(image, 0.8) {
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            let uploadTask = imagesReference.putData(imageData, metadata: metadata, completion: { (metadata, error) in
                if error != nil {
                    print(error)
                    return
                }
                self.imgUrl = (metadata?.downloadURL()?.absoluteString)!
            })
        } else {
            print("error")
        }
        
       
//
    }
}


