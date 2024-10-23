//
//  SettingsViewController.swift
//  MyTask
//
//  Created by Danil on 01.09.2024.
//

import UIKit
import SnapKit

protocol SettingsViewControllerProtocol: AnyObject { }

final class SettingsViewController: UIViewController {
    
    var presenter: SettingsPresenterProtocol!
    private let settingsCellId = "settingsCell"
    private let maxFontSize: CGFloat = 42
    private let minFontSize: CGFloat = 21
    
    private lazy var header: UILabel = {
        let label = UILabel()
        label.text = Localization.settingsHeader
        label.font = UIFont(name: "HelveticaNeue-Bold", size: maxFontSize)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var settingsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.register(SettingsViewCell.self, forCellReuseIdentifier: settingsCellId)
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubview(header)
        view.addSubview(settingsTableView)
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
    
    @objc private func didToggleSwitch(_ sender: UISwitch) {
        presenter.enablePush()
    }
}

extension SettingsViewController: SettingsViewControllerProtocol { }

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
        cell.display(settingsLabel: presenter.dataOfRowInSection(section: indexPath.section, row: indexPath.row).name,
                     isSwitchShow: presenter.dataOfRowInSection(section: indexPath.section, row: indexPath.row).switchIsEnabled)
        if presenter.dataOfRowInSection(section: indexPath.section, row: indexPath.row).switchIsEnabled {
            cell.settingsSwitch.addTarget(self, action: #selector(didToggleSwitch(_:)), for: .valueChanged)
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
                presenter.wipeStorage()
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
