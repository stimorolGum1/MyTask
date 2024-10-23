//
//  EmptyTaskView.swift
//  MyTask
//
//  Created by Danil on 28.08.2024.
//

import UIKit
import SnapKit

final class EmptyTaskView: UIView {
    
    private lazy var emptyTaskImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "empty")
        return imageView
    }()
    
    private lazy var emptyTaskLabel: UILabel = {
        let label = UILabel()
        label.text = Localization.emptyTaskViewLabel
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(emptyTaskImageView)
        addSubview(emptyTaskLabel)
    }
    
    private func setupConstraints() {
        emptyTaskImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(100)
        }
        emptyTaskLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyTaskImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(80)
            make.leading.trailing.equalTo(0)
        }
    }
}
