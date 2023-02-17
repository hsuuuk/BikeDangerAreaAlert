import UIKit
import SnapKit

class SettingController: UIViewController {
        
    let sectionTitles = ["Feedback", "About The App",]
    let feedbackRow = ["평가", "연락처"]
    let appDataRow = ["서비스 이용약관", "개인정보 처리방침", "위치기반서비스 이용약관", "저작권", "앱버젼"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        
        navigationItem.title = "더보기"
        //navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}

extension SettingController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
        header?.textLabel?.text = sectionTitles[section]
        header?.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        header?.textLabel?.textColor = UIColor.black
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return feedbackRow.count
        } else {
            return appDataRow.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = feedbackRow[indexPath.row]
        } else {
            cell.textLabel?.text = appDataRow[indexPath.row]
        }
        
        cell.backgroundColor = .systemGray6
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension SettingController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}



