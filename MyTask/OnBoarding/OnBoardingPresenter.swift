//
//  OnBoardingPresenter.swift
//  MyTask
//
//  Created by Danil on 02.08.2024.
//

import Foundation

// MARK: - Protocol Definition

protocol OnBoardingPresenterProtocol: AnyObject {
    func showCurrentPage()
    func getCurrentPage() -> OnBoardingPage?
    func getCurrentPageIndex() -> Int
    func getNextPage()
    func getCountOfPages() -> Int
}

// MARK: - Presenter Implementation

final class OnBoardingPresenter {
    
    // MARK: - Properties
    
    private weak var view: OnBoardingViewControllerProtocol?
    private let model: OnBoardingModel
    private var currentPageIndex = 0
    private let router: Routes
    private let pushManager: PushManager
    typealias Routes = Closable & TabBarRoute
    
    // MARK: - Initializer
    
    init(view: OnBoardingViewControllerProtocol, model: OnBoardingModel, router: Routes, pushManager: PushManager) {
        self.view = view
        self.model = model
        self.router = router
        self.pushManager = pushManager
    }
}

// MARK: - OnBoardingPresenterProtocol Conformance

extension OnBoardingPresenter: OnBoardingPresenterProtocol {
    func showCurrentPage() {
        guard let page = getCurrentPage() else { return }
        view?.display(page: page)
    }
    
    func getCurrentPage() -> OnBoardingPage? {
        return model.getPage(at: currentPageIndex)
    }
    
    func getCurrentPageIndex() -> Int {
        return currentPageIndex
    }
    
    func getNextPage() {
        if currentPageIndex == 2 {
            UserDefaults.standard.set(true, forKey: UserDefaultsEnum.isOnBoardingShown.rawValue)
            pushManager.requestPermission { [weak self] _ in
                DispatchQueue.main.async {
                    self?.router.openTabBar()
                }
                
            }
        } else {
            currentPageIndex += 1
            showCurrentPage()
        }
    }
    
    func getCountOfPages() -> Int {
        return model.getPageCount()
    }
}
