//
//  SettingsViewController.swift
//  MyTask
//
//  Created by Danil on 01.09.2024.
//

import UIKit
import SnapKit

// MARK: - Protocol Definitions

protocol SettingsViewControllerProtocol: AnyObject {
    func showAlert(message: String, withCancel: Bool, completion: (() -> Void)?)
}

// MARK: - ViewController Implementation

final class SettingsViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: SettingsPresenterProtocol!
    private let settingsCellId = "settingsCell"
    private let maxFontSize: CGFloat = 42
    private let minFontSize: CGFloat = 21
    
    // MARK: - UI Elements
    
    private lazy var header: UILabel = {
        let label = UILabel()
        label.text = Localization.settingsHeader
        label.font = UIFont(name: "HelveticaNeue-Bold", size: maxFontSize)
        label.textColor = .white
        return label
    }()
    
    private lazy var settingsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableView.register(SettingsViewCell.self, forCellReuseIdentifier: settingsCellId)
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Methods
    
    private func setupViews() {
        view.backgroundColor = .black
        [header, settingsTableView].forEach { view.addSubview($0) }
    }
    
    private func setupConstraints() {
        header.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(20)
            make.height.equalTo(50)
        }
        settingsTableView.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(10)
            make.leading.equalTo(15)
            make.trailing.equalTo(-15)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
    }
    
    @objc private func didTogglePushNotificationSwitch(_ sender: UISwitch) {
        presenter.controlPush(enable: sender.isOn) {
            sender.isOn = false
        }
    }
}

// MARK: - Protocol Conformance

extension SettingsViewController: SettingsViewControllerProtocol {
    func showAlert(message: String, withCancel: Bool, completion: (() -> Void)?) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        if withCancel {
            alert.addAction(UIAlertAction(title: Localization.cancel, style: .cancel, handler: nil))
        }
        
        present(alert, animated: true, completion: nil)
    }

}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberAtRowInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.dataOfSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = UIColor.gray
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: settingsCellId, for: indexPath) as! SettingsViewCell
        let items = presenter.dataOfRowInSection(section: indexPath.section, row: indexPath.row)
        cell.display(settingsLabel: items.name, isSwitchShow: items.switchIsEnabled)
        if items.switchIsEnabled {
            cell.settingsSwitch.isOn = items.isSwitchEnableFor ?? false
            cell.settingsSwitch.removeTarget(nil, action: nil, for: .allEvents)
            cell.settingsSwitch.addTarget(self, action: #selector(didTogglePushNotificationSwitch(_:)), for: .valueChanged)
            cell.settingsSwitch.tag = indexPath.row
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let items = presenter.dataOfRowInSection(section: indexPath.section, row: indexPath.row)
        if !items.switchIsEnabled {
            switch items.name {
            case Localization.wipeStorage:
                showAlert(message: Localization.wipe, withCancel: true) { [weak self] in
                    self?.presenter.wipeStorage()
                }
            case Localization.aboutApp:
                presenter.openAboutScreen()
            default:
                break
            }
        }
    }
}

extension SettingsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let headerHeight: CGFloat = 100
        let fontSize = max(maxFontSize - (offsetY / headerHeight) * (maxFontSize - minFontSize), minFontSize)
        header.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
}
