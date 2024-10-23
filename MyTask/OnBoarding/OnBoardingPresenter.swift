//
//  OnBoardingPresenter.swift
//  MyTask
//
//  Created by Danil on 02.08.2024.
//

import Foundation

protocol OnBoardingPresenterProtocol: AnyObject {
    func showCurrentPage()
    func getCurrentPage() -> OnBoardingPage?
    func getCurrentPageIndex() -> Int
    func getNextPage()
}

final class OnBoardingPresenter {
    private weak var view: OnBoardingViewControllerProtocol?
    private let model: OnBoardingModel
    private var currentPageIndex = 0
    private let router: Routes
    typealias Routes = Closable & TabBarRoute

    init(view: OnBoardingViewControllerProtocol, model: OnBoardingModel, router: Routes) {
        self.view = view
        self.model = model
        self.router = router
    }
}

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
            UserDefaults.standard.set(true, forKey: "isOnBoardingShown")
            router.openTabBar()
        } else {
            currentPageIndex += 1
            showCurrentPage()
        }
    }
}
