//
//  ProfileViewController.swift
//  TravelLogAPP
//
//  Created by t2023-m0076 on 2023/09/19.
//

import UIKit

class ProfileViewController: UIViewController {
    private let profileView = ProfileView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
}

extension ProfileViewController {
    func setup() {
        view = profileView
    }
}
