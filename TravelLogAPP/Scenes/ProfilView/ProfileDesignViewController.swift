//
//  ProfileDesignViewController.swift
//  TravelLogAPP
//
//  Created by t2023-m0076 on 2023/09/14.
//  Profile & Travel Log Page

import UIKit

class ProfileDesignViewController: UIViewController {
    private let profileDesignView = ProfileDesignView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
}

private extension ProfileDesignViewController {
    func setup() {
        view = profileDesignView
        profileDesignView.backButton.addTarget(self, action: #selector(setBackButton), for: .touchUpInside)
    }
    
    @objc func setBackButton() {
        self.dismiss(animated: true)
    }
}
