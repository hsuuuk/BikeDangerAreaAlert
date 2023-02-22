//
//  InfoController.swift
//  BikeDangerAreaAlert
//
//  Created by 심현석 on 2023/02/15.
//

import UIKit
import SnapKit

class InfoController: UIViewController {
    
    var collectionView: UICollectionView!
    
    var data: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(InfoCell.self, forCellWithReuseIdentifier: "cell")
        
        navigationItem.title = "사고 설명"
    }
}

extension InfoController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InfoCell
        
        if let data = data {
            if indexPath.row == 0 {
                cell.titleLabel.text = "사고 주소"
                cell.dataLabel.text = data.address
                cell.dataLabel.font = UIFont.systemFont(ofSize: 20)
            } else if indexPath.row == 1 {
                cell.titleLabel.text = "사고수"
                cell.dataLabel.text = String(data.accidentCount)
            } else if indexPath.row == 2 {
                cell.titleLabel.text = "부상자수"
                cell.dataLabel.text = String(data.injuryCount)
            } else {
                cell.titleLabel.text = "사망자수"
                cell.dataLabel.text = String(data.deathCount)
            }
        }
        
        return cell
    }
}

extension InfoController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: 355, height: 100)
        } else {
            return CGSize(width: 112, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
}

extension InfoController: UICollectionViewDelegate {
}



