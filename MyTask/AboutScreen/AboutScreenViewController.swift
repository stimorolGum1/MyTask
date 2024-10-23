//
//  AboutScreenViewController.swift
//  MyTask
//
//  Created by Danil on 21.10.2024.
//

import UIKit
import SnapKit

protocol AboutScreenViewControllerProtocol: AnyObject { }

final class AboutScreenViewController: UIViewController {
    
    var presenter: AboutScreenPresenterProtocol?
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.backgroundColor = .gray
        button.tintColor = .black
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(closeAboutScreenButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var titleAppLabel: UILabel = {
        let label = UILabel()
        label.text = Localization.titleAppLabel
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 42)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionAppLabel: UILabel = {
        let label = UILabel()
        label.text = Localization.descriptionAppLabel
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.text = Localization.authorLabel
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubview(closeButton)
        view.addSubview(titleAppLabel)
        view.addSubview(descriptionAppLabel)
        view.addSubview(authorLabel)
    }
    
    private func setupConstraints() {
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.trailing.equalTo(-20)
            make.height.width.equalTo(30)
        }
        
        titleAppLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.centerX.equalToSuperview()
        }
        
        descriptionAppLabel.snp.makeConstraints { make in
            make.top.equalTo(titleAppLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.leading.equalTo(10)
            make.trailing.equalTo(-10)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionAppLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.leading.equalTo(10)
            make.trailing.equalTo(-10)
        }
        
    }
    
    @objc private func closeAboutScreenButtonTapped() {
        presenter?.closeTaskView()
    }
}

extension AboutScreenViewController: AboutScreenViewControllerProtocol { }
