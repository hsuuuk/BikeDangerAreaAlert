import UIKit
import SnapKit
import MessageUI

class SettingController: UIViewController {
        
    let sectionTitles = ["Feedback", "About The App",]
    let feedbackRow = ["평가하기", "메일 보내기"]
    let appDataRow = ["개인정보처리방침", "저작권(SIM HYUNSUK)", "앱버전(1.0)"]
    // 서비스 이용약관, 위치기반서비스 이용약관
    
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
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.textLabel?.text = appDataRow[indexPath.row]
            if indexPath.row == 0 {
                cell.accessoryType = .disclosureIndicator
            }
        }
        
        cell.backgroundColor = .systemGray6
        return cell
    }
}

extension SettingController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0, indexPath.row == 1 {
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients(["hsuuuk123@gmail.com"])
                present(mail, animated: true)
            } else {
                print("fail")
            }
        } else if indexPath.section == 1, indexPath.row == 1 {
            print("tap")
            let controller = PolicyController()
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

extension SettingController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

