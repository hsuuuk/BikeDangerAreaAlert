//
//  InfoController.swift
//  BikeDangerAreaAlert
//
//  Created by 심현석 on 2023/02/15.
//

import UIKit
import SnapKit

class InfoController: UIViewController {
    
    var addreddLabel: UILabel = {
        let lb = UILabel()
        lb.text = "주소"
        return lb
    }()
    
    var accidentlabel: UILabel = {
        let lb = UILabel()
        lb.text = "사고건수"
        return lb
    }()
    
    var injuryLabel: UILabel = {
        let lb = UILabel()
        lb.text = "사상자수"
        return lb
    }()
    
    var deathLabel: UILabel = {
        let lb = UILabel()
        lb.text = "사망자수"
        return lb
    }()
    
    var addressData: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        return lb
    }()
    
    var accidentCount: UILabel = {
        let lb = UILabel()
        return lb
    }()
    
    var injuryCount: UILabel = {
        let lb = UILabel()
        return lb
    }()
    
    var deathCount: UILabel = {
        let lb = UILabel()
        return lb
    }()
    
    lazy var nameStack: UIStackView = {
        let stv = UIStackView(arrangedSubviews: [addreddLabel, accidentlabel, injuryLabel, deathLabel])
        stv.axis = .vertical
        stv.spacing = 10
        stv.distribution = .fillEqually
        //stv.backgroundColor = .lightGray
        return stv
    }()
    
    lazy var textStack: UIStackView = {
        let stv = UIStackView(arrangedSubviews: [addressData, accidentCount, injuryCount, deathCount])
        stv.axis = .vertical
        stv.spacing = 10
        stv.distribution = .fillEqually
        //stv.backgroundColor = .systemFill
        return stv
    }()
    
    var data: Item? {
        didSet { setupData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(nameStack)
        nameStack.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.right.equalToSuperview().offset(-300)
            make.bottom.equalToSuperview().offset(-300)
        }
        
        view.addSubview(textStack)
        textStack.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.left.equalTo(nameStack.snp.right)
            make.bottom.equalToSuperview().offset(-300)
        }
        
        let navi = UINavigationController()
        navi.title = "1"
        navi.navigationItem.title = "11"
        navigationController?.navigationItem.title = "상세 설명"
    }
    
    func setupData() {
        guard let data = data else { return }
        addressData.text = data.address
        print(data.address)
        accidentCount.text = String(data.accidentCount)
        injuryCount.text = String(data.injuryCount)
        deathCount.text = String(data.deathCount)
    }
}

