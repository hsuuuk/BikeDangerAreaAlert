//
//  PolicyController.swift
//  BikeDangerAreaAlert
//
//  Created by 심현석 on 2023/02/20.
//

import UIKit
import SnapKit
import WebKit

class PolicyController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "개인정보처리방침"
        navigationController?.navigationItem.title = ""
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        
        setupWebView()
    }
    
    func setupWebView() {
        let webView = WKWebView()
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        webView.navigationDelegate = self
        
        if let htmlPath = Bundle.main.path(forResource: "개인정보처리방침", ofType: "html") {
            let url = URL(fileURLWithPath: htmlPath)
            let request = URLRequest(url: url)
            webView.load(request)
        } else {
            print("fail")
        }
    }
}


