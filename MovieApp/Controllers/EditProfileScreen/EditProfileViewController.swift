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
        setupTextField()
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
        let maleCheckboxGesture = UITapGestureRecognizer(target: self, action: #selector(maleCheckboxTapped))
        let femaleCheckboxGesture = UITapGestureRecognizer(target: self, action: #selector(femaleCheckboxTapped))
        let avatarGesture = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
        
        changePhotoGesture.delegate = self
        
        profileView.changePhotoView.addGestureRecognizer(changePhotoGesture)
        profileView.maleCheckbox.addGestureRecognizer(maleCheckboxGesture)
        profileView.femaleCheckbox.addGestureRecognizer(femaleCheckboxGesture)
        profileView.avatarView.addGestureRecognizer(avatarGesture)
    }
    
    func setupImagePicker() {
        imagePicker.delegate = self
    }
    
    func setupTextField() {
        profileView.firstNameInput.inputTextField.delegate = self
        profileView.lastNameInput.inputTextField.delegate = self
        profileView.emailInput.inputTextField.delegate = self
        profileView.dateOfBirthInput.inputTextField.delegate = self
    }
    
    func setupChangePhotoButtons() {
        let takePhotoButton = profileView.changePhotoView.takePhotoButton
        let choosePhotoButton = profileView.changePhotoView.choosePhotoButton
        let deletePhotoButton = profileView.changePhotoView.deletePhotoButton
        
        takePhotoButton.addTarget(self, action: #selector(takePhotoPressed), for: .touchUpInside)
        choosePhotoButton.addTarget(self, action: #selector(choosePhotoPressed), for: .touchUpInside)
        deletePhotoButton.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
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
    
    @objc func maleCheckboxTapped() {
        profileView.maleCheckbox.checkmark.imageView.isHidden = false
        profileView.femaleCheckbox.checkmark.imageView.isHidden = true
    }
    
    @objc func femaleCheckboxTapped() {
        profileView.maleCheckbox.checkmark.imageView.isHidden = true
        profileView.femaleCheckbox.checkmark.imageView.isHidden = false
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
    
    @objc func deleteButtonPressed() {
        profileView.avatarView.imageView.image = UIImage(named: "profileIcon")
    }
    
    @objc func choosePhotoPressed() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
}

// MARK: - UIGestureRecognizerDelegate

extension EditProfileViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == profileView.changePhotoView.self
    }
}

// MARK: - UIImagePickerControllerDelegate

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        profileView.avatarView.imageView.image = image.circle()
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

extension EditProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
