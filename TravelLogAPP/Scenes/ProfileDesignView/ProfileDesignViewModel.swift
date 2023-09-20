//
//  ProfileDesignViewModel.swift
//  TravelLogAPP
//
//  Created by t2023-m0076 on 2023/09/18.
//

import Foundation
import UIKit

class ProfileDesignViewModel {
    private let profileDesignView = ProfileDesignView()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var viewReloadHandler: (() -> Void)?
    var user: User?
    var pictures: [UIImage] = [
        UIImage(named: "1")!,
        UIImage(named: "2")!,
        UIImage(named: "3")!,
        UIImage(named: "4")!,
        UIImage(named: "5")!,
        UIImage(named: "6")!,
        UIImage(named: "7")!,
        UIImage(named: "1")!,
        UIImage(named: "2")!,
        UIImage(named: "3")!,
        UIImage(named: "4")!,
        UIImage(named: "5")!,
        UIImage(named: "6")!,
        UIImage(named: "7")!,
    ]

    func fetchUserInfo() {
        let request = User.fetchRequest()

        do {
            let users = try context.fetch(request)
            if let firstUser = users.first {
                user = firstUser
            }
            viewReloadHandler?()
        } catch {
            print("🚨 Error: Fetch User Info")
        }
    }
}
