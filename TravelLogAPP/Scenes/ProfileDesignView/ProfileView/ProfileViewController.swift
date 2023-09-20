//
//  ProfileViewController.swift
//  TravelLogAPP
//
//  Created by t2023-m0076 on 2023/09/19.
//

import PhotosUI
import UIKit

class ProfileViewController: UIViewController {
    private let profileView = ProfileView()
//    private let viewModel = ProfileViewModel()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setUserInfo()
    }
}

private extension ProfileViewController {
    func setup() {
        view = profileView
        profileView.cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        profileView.saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        profileView.edit.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(editProfilePicture)))
    }

    func setUserInfo() {
        fetchUserInfo()
        if let userPictureData = user?.userPicture {
            profileView.profilePic.image = UIImage(data: userPictureData)
        }
        profileView.inputUserName.text = user?.userName
        profileView.inputId.text = user?.id
        profileView.inputNickname.text = user?.nickname
        profileView.inputUserAge.text = String(Int(user?.userAge ?? 0))
        profileView.inputBio.text = user?.bio
        profileView.inputLinkInBio.text = user?.linkInBio
    }

    @objc func didTapCancelButton() {
        dismiss(animated: true)
    }

    @objc func didTapSaveButton() {
        updateUserInfo()
        NotificationCenter.default.post(name: NSNotification.Name("UpdateUserInfoNotification"), object: user)
        print("Post UpdateUserInfoNotification")
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }

    @objc func editProfilePicture() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
}

extension ProfileViewController {
    func fetchUserInfo() {
        let request = User.fetchRequest()

        do {
            let users = try context.fetch(request)
            if let firstUser = users.first {
                user = firstUser
            }
        } catch {
            print("🚨 Error: Fetch User Info")
        }
    }

    func updateUserInfo() {
        if let pic = profileView.profilePic.image {
            if let imageData = pic.jpegData(compressionQuality: 1.0) {
                user?.userPicture = imageData
            }
        }
        user?.userName = profileView.inputUserName.text
        user?.id = profileView.inputId.text
        user?.nickname = profileView.inputNickname.text
        if let ageText = profileView.inputUserAge.text, let age = Int(ageText) {
            user?.userAge = Int64(age)
        }
        user?.bio = profileView.inputBio.text
        user?.linkInBio = profileView.inputLinkInBio.text

        do {
            try context.save()
        } catch {
            print("🚨 Error: Save User Info")
        }
    }
}

extension ProfileViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)

        guard let selectedImage = results.first?.itemProvider else {
            return
        }

        selectedImage.loadObject(ofClass: UIImage.self) { [weak self] image, error in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
            } else if let image = image as? UIImage {
                DispatchQueue.main.async {
                    self?.profileView.profilePic.image = image
                }
            }
        }
    }
}
