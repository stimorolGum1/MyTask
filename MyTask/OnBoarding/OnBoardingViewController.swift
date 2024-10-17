//
//  OnBoardingVC.swift
//  MyTask
//
//  Created by Danil on 02.08.2024.
//

import UIKit
import SnapKit

protocol OnBoardingViewControllerProtocol: AnyObject {
    func display(page: OnBoardingPage)
}

final class OnBoardingViewController: UIViewController {
    var presenter: OnBoardingPresenterProtocol!
    
    private lazy var onBoardingImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private lazy var onBoardingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 32)
        label.textColor = .black
        return label
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.5333333333, green: 0.4588235294, blue: 1, alpha: 1)
        pageControl.isUserInteractionEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle(Localization.nextButton, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5333333333, green: 0.4588235294, blue: 1, alpha: 1)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        setupViews()
        setupConstraints()
        presenter.showOnBoarding()
    }
    
    private func setupViews() {
        view.addSubview(onBoardingImage)
        view.addSubview(onBoardingLabel)
        view.addSubview(pageControl)
        view.addSubview(nextButton)
    }
    
    private func setupConstraints() {
        onBoardingImage.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.height.width.equalTo(300)
            make.centerX.equalToSuperview()
        }
        onBoardingLabel.snp.makeConstraints { make in
            make.top.equalTo(onBoardingImage.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-40)
            make.height.equalTo(50)
            make.width.equalTo(150)
            make.centerX.equalToSuperview()
        }
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func nextPage() {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.onBoardingImage.alpha = 0
            self?.onBoardingLabel.alpha = 0
        }, completion: { [weak self] _ in
            self?.presenter.getNextPage()
            UIView.animate(withDuration: 0.3, animations: {
                self?.onBoardingImage.alpha = 1
                self?.onBoardingLabel.alpha = 1
            })
        })
    }
}

extension OnBoardingViewController: OnBoardingViewControllerProtocol {
    func display(page: OnBoardingPage) {
        onBoardingImage.image = page.imageName
        onBoardingLabel.text = page.text
        pageControl.currentPage = presenter.getCurrentPageIndex()
    }
}
