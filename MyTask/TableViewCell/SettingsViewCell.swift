//
//  SettingsViewCell.swift
//  MyTask
//
//  Created by Danil on 19.09.2024.
//

import UIKit
import SnapKit

// MARK: - SettingsViewCell

final class SettingsViewCell: UITableViewCell {

    // MARK: - UI Elements

    private lazy var settingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()

    lazy var settingsSwitch: UISwitch = {
        let switchView = UISwitch()
        return switchView
    }()

    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arrow-left")
        return imageView
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    private func setupViews() {
        contentView.addSubview(settingLabel)
    }

    private func setupConstraints() {
        settingLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
    }

    func isSwitchShow(isShow: Bool) {
        if isShow {
            contentView.addSubview(settingsSwitch)
            settingsSwitch.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.trailing.equalToSuperview().offset(-16)
            }
        } else {
            contentView.addSubview(arrowImageView)
            arrowImageView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.height.width.equalTo(30)
                make.trailing.equalToSuperview().offset(-16)
            }
        }
    }

    func display(settingsLabel: String, isSwitchShow: Bool) {
        self.settingLabel.text = settingsLabel
        self.isSwitchShow(isShow: isSwitchShow)
    }
}

