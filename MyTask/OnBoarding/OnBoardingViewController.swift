//
//  OnBoardingVC.swift
//  MyTask
//
//  Created by Danil on 02.08.2024.
//

import UIKit
import SnapKit

// MARK: - Protocol Definition

protocol OnBoardingViewControllerProtocol: AnyObject {
    func display(page: OnBoardingPage)
}

// MARK: - ViewController Implementation

final class OnBoardingViewController: UIViewController {
    
    // MARK: - Properties

    var presenter: OnBoardingPresenterProtocol!

    // MARK: - UI Elements

    private lazy var onBoardingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var onBoardingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.numberOfPages = presenter.getCountOfPages()
        control.pageIndicatorTintColor = .gray
        control.currentPageIndicatorTintColor = .blue
        control.isUserInteractionEnabled = false
        return control
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Localization.nextButton, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        presenter.showCurrentPage()
    }

    // MARK: - Methods

    private func setupViews() {
        view.backgroundColor = .black
        [onBoardingImage, onBoardingLabel, pageControl, nextButton].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        onBoardingImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(300)
        }
        
        onBoardingLabel.snp.makeConstraints { make in
            make.top.equalTo(onBoardingImage.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-20)
            make.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }

    // MARK: - Actions

    @objc private func nextPage() {
        if presenter.getCurrentPageIndex() == 2 {
            presenter.getNextPage()
            return
        }
        
        animatePageTransition {
            self.presenter.getNextPage()
        }
    }

    // MARK: - Animation

    private func animatePageTransition(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.3, animations: {
            self.onBoardingImage.alpha = 0
            self.onBoardingLabel.alpha = 0
        }, completion: { _ in
            completion()
            UIView.animate(withDuration: 0.3) {
                self.onBoardingImage.alpha = 1
                self.onBoardingLabel.alpha = 1
            }
        })
    }
}

// MARK: - Protocol Conformance

extension OnBoardingViewController: OnBoardingViewControllerProtocol {
    func display(page: OnBoardingPage) {
        onBoardingImage.image = page.imageName
        onBoardingLabel.text = page.text
        pageControl.currentPage = presenter.getCurrentPageIndex()
    }
}
