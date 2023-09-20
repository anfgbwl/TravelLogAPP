//
//  ProfileViewModel.swift
//  TravelLogAPP
//
//  Created by t2023-m0076 on 2023/09/19.
//

import Foundation
import UIKit

class ProfileViewModel {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var user: User?
    
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
    
    func saveUserInfo() {
        do {
            try context.save()
        } catch {
            print("🚨 Error: Save User Info")
        }
    }
}
