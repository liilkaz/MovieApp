//
//  EditProfileViewController.swift
//  MovieApp
//
//  Created by Иван Осипов on 12.04.2023.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    let profileView = EditProfileView()
    let imagePicker = UIImagePickerController()
    let datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupImagePicker()
        setupGestures()
        setupChangePhotoButtons()
        createDatePicker()
    }
}

private extension EditProfileViewController {
    
    func setupView() {
        view = profileView
        tabBarController?.tabBar.isHidden = true
        navigationItem.title = "Profile"
    }
    
    func setupGestures() {
        let changePhotoGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        let checkboxGesture = UITapGestureRecognizer(target: self, action: #selector(checkboxTapped))
        let avatarGesture = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
        
        changePhotoGesture.delegate = self
        
        profileView.changePhotoView.addGestureRecognizer(changePhotoGesture)
        profileView.maleCheckbox.addGestureRecognizer(checkboxGesture)
        profileView.avatarView.addGestureRecognizer(avatarGesture)
    }
    
    func setupImagePicker() {
        imagePicker.delegate = self
    }
    
    func setupChangePhotoButtons() {
        let takePhotoButton = profileView.changePhotoView.takePhotoButton
        let choosePhotoButton = profileView.changePhotoView.choosePhotoButton
//        let deletePhotoButton = profileView.changePhotoView.deletePhotoButton
        
        takePhotoButton.addTarget(self, action: #selector(takePhotoPressed), for: .touchUpInside)
        choosePhotoButton.addTarget(self, action: #selector(choosePhotoPressed), for: .touchUpInside)
        
    }
    
    func createToolbar() -> UIToolbar {
        let toolBar = UIToolbar()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolBar.sizeToFit()
        toolBar.setItems([doneBtn], animated: true)
        return toolBar
    }
    
    func createDatePicker() {
        datePicker.datePickerMode = .date
        
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        }
        
        profileView.dateOfBirthInput.inputTextField.inputView = datePicker
        profileView.dateOfBirthInput.inputTextField.inputAccessoryView = createToolbar()
    }
    
    // MARK: - private @objc methods
    @objc func dismissView() {
        profileView.changePhotoView.isHidden = true
    }
    
    @objc func checkboxTapped() {
        profileView.maleCheckbox.checkmark.toggle()
    }
    
    @objc func avatarTapped() {
        profileView.changePhotoView.isHidden = false
    }
    
    @objc func doneButtonTapped() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        profileView.dateOfBirthInput.inputTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func takePhotoPressed() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true)
        } else {
            print("Camera not available")
        }
    }
    
    @objc func choosePhotoPressed() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
}

extension EditProfileViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == profileView.changePhotoView.self
    }
}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        profileView.avatarView.imageView.image = image
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
