//
//  SettingsViewCell.swift
//  MyTask
//
//  Created by Danil on 19.09.2024.
//

import UIKit
import SnapKit

class SettingsViewCell: UITableViewCell {
    
    lazy var settingLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var settingsSwitch: UISwitch = {
        let switchView = UISwitch()
        return switchView
    }()
    
    lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arrow-left")
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .none
        contentView.backgroundColor = .clear
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(settingLabel)
    }
    
    func setupConstraints() {
        settingLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
    }
    
    func isSwitchShow(isShow: Bool) {
        if isShow == true {
            contentView.addSubview(settingsSwitch)
            settingsSwitch.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.trailing.equalToSuperview().offset(-16)
            }
        }
        if isShow == false {
            contentView.addSubview(arrowImageView)
            arrowImageView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.height.width.equalTo(30)
                make.trailing.equalToSuperview().offset(-16)
            }
        }
    }
}
