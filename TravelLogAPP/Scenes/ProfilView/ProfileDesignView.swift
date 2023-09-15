//
//  ProfileDesignView.swift
//  TravelLogAPP
//
//  Created by t2023-m0076 on 2023/09/15.
//

import SnapKit
import UIKit

class ProfileDesignView: UIView {
    let backButton: UIButton = {
        let backButton = UIButton()
        backButton.setImage(UIImage(systemName: "x.circle.fill"), for: .normal)
        backButton.tintColor = .systemGray2
        return backButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .white
        
        addSubview(backButton)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(80)
            make.leading.equalTo(30)
        }
    }
}
