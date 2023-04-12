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
    
    @objc func checkboxTapped() {
        profileView.maleCheckbox.checkmark.toggle()
    }
    
    @objc func avatarTapped() {
        print("tap")
//        let vc = ChangePhotoViewController()
//        vc.modalPresentationStyle = .fullScreen
//        navigationController?.present(vc, animated: true)
    }
    
    @objc func doneButtonTapped() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        profileView.dateOfBirthInput.inputTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
}
