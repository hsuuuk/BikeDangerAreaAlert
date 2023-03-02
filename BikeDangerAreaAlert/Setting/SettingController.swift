import UIKit
import SnapKit
import MessageUI

class SettingController: UIViewController {
    
    var tableView: UITableView!
    
    let sectionTitles = ["Feedback", "About The App",]
    //let feedbackRow = ["평가하기", "메일 보내기"]
    let feedbackRow = ["메일 보내기"]
    let appDataRow = ["개인정보처리방침", "저작권(SIM HYUNSUK)", "앱버전(1.0)"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "더보기"
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        tableView = UITableView(frame: .zero, style: .insetGrouped)
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
        if indexPath.section == 0, indexPath.row == 0 {
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients(["hsuuuk123@gmail.com"])
                present(mail, animated: true)
            } else {
                print("fail")
            }
        } else if indexPath.section == 1, indexPath.row == 0 {
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


//if let reviewURL = URL(string: "itms-apps://itunes.apple.com/app/itunes-u/id\(YourAppID)?ls=1&mt=8&action=write-review"), UIApplication.shared.canOpenURL(reviewURL) { // 유효한 URL인지 검사합니다.
//    if #available(iOS 10.0, *) { //iOS 10.0부터 URL를 오픈하는 방법이 변경 되었습니다.
//        UIApplication.shared.open(reviewURL, options: [:], completionHandler: nil)
//    } else {
//        UIApplication.shared.openURL(reviewURL)
//    }
//}

