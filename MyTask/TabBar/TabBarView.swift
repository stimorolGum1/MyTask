//
//  TabBarView.swift
//  MyTask
//
//  Created by Danil on 12.08.2024.
//

import UIKit
import SnapKit

protocol FloatingTabBarDelegate: AnyObject {
    func tabBar(didSelectItemAt index: Int)
}

final class FloatingTabBar: UIView {

    weak var delegate: FloatingTabBarDelegate?

    private let items: [String]
    private var buttons: [UIButton] = []
    
    private lazy var centerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.systemBlue
        button.setTitle("+", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 35
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.layer.shadowRadius = 5
        button.addTarget(self, action: #selector(centerButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 0
        return stackView
    }()

    init(items: [String]) {
        self.items = items
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 10

        for (index, title) in items.enumerated() {
            let button = UIButton(type: .system)
            button.tag = index
            button.setImage(UIImage(named: title), for: .normal)
            button.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }

        addSubview(stackView)
        addSubview(centerButton)
    }

    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        centerButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
            make.height.width.equalTo(70)
        }
    }

    @objc private func tabButtonTapped(_ sender: UIButton) {
        delegate?.tabBar(didSelectItemAt: sender.tag)
    }
    
    @objc private func centerButtonTapped() {
        print("Center button tapped")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(100)
            make.height.equalTo(60)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
    }
}
