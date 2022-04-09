//
//  NewPlaceViewController.swift
//  MyPlaces
//
//  Created by MacBook on 03.04.2022.
//

import UIKit
import Cosmos


class NewPlaceViewController: UITableViewController, UITextFieldDelegate {
    
    var currentPlace: Place?
    var imageIsChanged = false
    var currentRating = 0.0

    @IBOutlet var placeImage: UIImageView!
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var placeName: UITextField!
    @IBOutlet var placeLocation: UITextField!
    @IBOutlet var placeType: UITextField!
    @IBOutlet var cosmosView: CosmosView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        saveButton.isEnabled = false
        
        placeName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        setupEditScreen()
        
        cosmosView.settings.fillMode = .half
        cosmosView.didTouchCosmos = { rating in
            self.currentRating = rating
        }
    }
    
    // MARK: Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            let cameraIcon = UIImage(named: "camera")
            let photoIcon = UIImage(named: "photo")
            
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(sourse: .camera)
            }
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(sourse: .photoLibrary)
            }
            photo.setValue(photoIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            
            present(actionSheet, animated: true)
        } else {
            view.endEditing(true)
        }
            
    }
    
    func savePlace() {
     
        var image: UIImage?
        
        if imageIsChanged {
            image = placeImage.image
        } else {
            image = UIImage(named: "imagePlaceholder")
        }
        
        let imageData = image?.pngData()
        let newPlace = Place(name: placeName.text!, location: placeLocation.text, type: placeType.text, imageData: imageData, rating: currentRating)
        
        if currentPlace != nil {
            try! realm.write {
                currentPlace?.name = newPlace.name
                currentPlace?.location = newPlace.location
                currentPlace?.type = newPlace.type
                currentPlace?.imageData = newPlace.imageData
                currentPlace?.rating = newPlace.rating
            }
        } else {
            StorageManager.saveObject(newPlace)
        }
    }
    
    private func setupEditScreen() {
        if currentPlace != nil {
            
            setupNavigationBar()
            imageIsChanged = true
            
            guard let data = currentPlace?.imageData, let image = UIImage(data: data) else { return }
            
            placeImage.image = image
            placeImage.contentMode = .scaleAspectFill
            placeName.text = currentPlace?.name
            placeLocation.text = currentPlace?.location
            placeType.text = currentPlace?.type
            cosmosView.rating = currentPlace!.rating
        }
    }
    
    private func setupNavigationBar() {
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        navigationItem.leftBarButtonItem = nil
        title = currentPlace?.name
        saveButton.isEnabled = true
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
}
// MARK: Text field delegate
 
extension NewPlaceViewController: UITextViewDelegate {
    
    // Close keyboard tapping "Done"
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
        @objc private func textFieldChanged() {
            if placeName.text?.isEmpty == false {
                saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
   }
}
// MARK: Work with image

extension NewPlaceViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker(sourse: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(sourse){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = sourse
            present(imagePicker, animated: true)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImage.image = info[.editedImage] as? UIImage
        placeImage.contentMode = .scaleAspectFill
        placeImage.clipsToBounds = true
        
        imageIsChanged = true
        
        dismiss(animated: true)
    }
    
}
