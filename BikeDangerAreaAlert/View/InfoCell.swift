//
//  InfoCell.swift
//  BikeDangerAreaAlert
//
//  Created by 심현석 on 2023/02/22.
//

import UIKit
import SnapKit

class InfoCell: UICollectionViewCell {
    
    var titleLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.boldSystemFont(ofSize: 17)
        lb.textColor = UIColor.systemGray
        return lb
    }() 
    
    var dataLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.lineBreakMode = .byWordWrapping
        lb.font = UIFont.boldSystemFont(ofSize: 35)
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemGray6
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(10)
            make.height.equalTo(17)
        }
        
        addSubview(dataLabel)
        dataLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
}
