//
//  ProfileViewModel.swift
//  TravelLogAPP
//
//  Created by t2023-m0076 on 2023/09/19.
//

import Foundation
import UIKit

class ProfileViewModel {
    private var profileView = ProfileView()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var user: User?
//    var viewReloadHandler: (() -> Void)?

    func fetchUserInfo() {
        let request = User.fetchRequest()

        do {
            let users = try context.fetch(request)
            if let firstUser = users.first {
                user = firstUser
//                profileView.setUserInfo(firstUser)
            } else {
                // 사용자가 없는 경우, 새로운 사용자 객체를 생성합니다.
                user = User(context: context)
                // 프로필 뷰의 텍스트 필드를 초기화합니다.
//                profileView.setUserInfo(user!)
            }
                
//            viewReloadHandler?()
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
//            viewReloadHandler?()
        } catch {
            print("🚨 Error: Save User Info")
        }
    }
}
