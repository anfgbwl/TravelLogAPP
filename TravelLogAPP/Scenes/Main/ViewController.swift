//
//  ViewController.swift
//  TravelLogAPP
//
//  Created by t2023-m0076 on 2023/09/14.
//  Main Page

import SnapKit
import UIKit

class ViewController: UIViewController {
    private let mainView = MainView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view = mainView
        setupButton()
    }

    deinit {
        print("MainVC deinitialized")
    }
}

private extension ViewController {
    func setupButton() {
        mainView.bucketListButton.addTarget(self, action: #selector(mainToBucketVC), for: .touchUpInside)
        mainView.completedButton.addTarget(self, action: #selector(mainToCompleteVC), for: .touchUpInside)
        mainView.profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(mainToProfileVC)))
    }
}

private extension ViewController {
    @objc func mainToBucketVC() {
        let BucketVC = BucketListViewController()
        navigationController?.pushViewController(BucketVC, animated: true)
    }

    @objc func mainToCompleteVC() {
        let CompleteVC = CompleteViewController()
        navigationController?.pushViewController(CompleteVC, animated: true)
    }

    @objc func mainToProfileVC(_ sender: UITapGestureRecognizer) {
        let ProfileVC = ProfileDesignViewController()
        ProfileVC.modalPresentationStyle = .fullScreen
        present(ProfileVC, animated: true, completion: nil)
    }
}
