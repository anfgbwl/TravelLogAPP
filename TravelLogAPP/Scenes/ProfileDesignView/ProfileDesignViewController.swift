//
//  ProfileDesignViewController.swift
//  TravelLogAPP
//
//  Created by t2023-m0076 on 2023/09/14.
//  Profile & Travel Log Page

import UIKit

class ProfileDesignViewController: UIViewController {
    private let profileDesignView = ProfileDesignView()
    private let viewModel = ProfileDesignViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
}

private extension ProfileDesignViewController {
    func setup() {
        view = profileDesignView
        profileDesignView.collectionView.delegate = self
        profileDesignView.collectionView.dataSource = self
        profileDesignView.backButton.addTarget(self, action: #selector(setBackButton), for: .touchUpInside)
        profileDesignView.profile.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileDesignToProfileVC)))
    }

    @objc func setBackButton() {
        dismiss(animated: true)
    }

    @objc func profileDesignToProfileVC() {
        let ProfileVC = ProfileViewController()
        present(ProfileVC, animated: true, completion: nil)
    }
}

extension ProfileDesignViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.pictures.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PictureCell.identifier, for: indexPath) as? PictureCell else {
            fatalError("Error")
        }
        let img = viewModel.pictures[indexPath.row]
        cell.configure(img)
        return cell
    }
}

extension ProfileDesignViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (view.frame.width / 3) - 1.34
        return CGSize(width: size, height: size)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}
