//
//  EditProfileViewController.swift
//  MovieApp
//
//  Created by Иван Осипов on 12.04.2023.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    let profileView = EditProfileView()
    
    let datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupChangePhoto()
        setupCheckbox()
        setupAvatar()
        createDatePicker()
    }
}

private extension EditProfileViewController {
    func setupView() {
        view = profileView
        tabBarController?.tabBar.isHidden = true
        navigationItem.title = "Profile"
    }
    
    func setupChangePhoto() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        gesture.delegate = self
        profileView.changePhotoView.addGestureRecognizer(gesture)
    }
    
    func setupCheckbox() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(checkboxTapped))
        profileView.maleCheckbox.addGestureRecognizer(gesture)
    }
    
    func setupAvatar() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
        profileView.avatarView.addGestureRecognizer(gesture)
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
}

extension EditProfileViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == profileView.changePhotoView.self
    }
}
