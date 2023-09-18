//
//  PictureCell.swift
//  TravelLogAPP
//
//  Created by t2023-m0076 on 2023/09/18.
//

import UIKit
import SnapKit

class PictureCell: UICollectionViewCell {
    static let identifier = "pictureCell"
    
    let picture: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "photo")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    public func configure(_ image: UIImage) {
        self.picture.image = image
        setupUI()
    }
    
}

extension PictureCell {
    func setupUI() {
        addSubview(picture)
        picture.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
