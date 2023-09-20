//
//  ProfileDesignViewController.swift
//  TravelLogAPP
//
//  Created by t2023-m0076 on 2023/09/14.
//  Profile & Travel Log Page

import UIKit

class ProfileDesignViewController: UIViewController {
    private let profileDesignView = ProfileDesignView()
//    private let viewModel = ProfileDesignViewModel()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    var viewReloadHandler: (() -> Void)?
    var user: User?
    var pictures: [UIImage] = [
        UIImage(named: "1")!,
        UIImage(named: "2")!,
        UIImage(named: "3")!,
        UIImage(named: "4")!,
        UIImage(named: "5")!,
        UIImage(named: "6")!,
        UIImage(named: "7")!,
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setUserInfo()
        NotificationCenter.default.addObserver(self, selector: #selector(updateUserInfo), name: NSNotification.Name("UpdateUserInfoNotification"), object: nil)
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
    
    func setUserInfo() {
        fetchUserInfo()
        profileDesignView.userId.text = user?.id
        if let userPictureData = user?.userPicture {
            profileDesignView.userPic.image = UIImage(data: userPictureData)
        }
        profileDesignView.postCount.text = String(pictures.count)
        profileDesignView.followerCount.text = String(Int(user?.followerCount ?? 0))
        profileDesignView.followingCount.text = String(Int(user?.followingCount ?? 0))
        profileDesignView.nickname.text = user?.nickname
        profileDesignView.bio.text = user?.bio
        profileDesignView.linkInBio.text = user?.linkInBio
    }

    @objc func setBackButton() {
        dismiss(animated: true)
    }

    @objc func profileDesignToProfileVC() {
        let ProfileVC = ProfileViewController()
        present(ProfileVC, animated: true, completion: nil)
    }
    
    @objc func updateUserInfo() {
        DispatchQueue.main.async {
            self.setUserInfo()
        }
    }
}

extension ProfileDesignViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PictureCell.identifier, for: indexPath) as? PictureCell else {
            fatalError("Error")
        }
        let img = pictures[indexPath.row]
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

extension ProfileDesignViewController {
    
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
}
