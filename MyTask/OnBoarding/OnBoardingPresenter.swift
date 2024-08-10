//
//  OnBoardingPresenter.swift
//  MyTask
//
//  Created by Danil on 02.08.2024.
//

import Foundation

protocol OnBoardingPresenterProtocol: AnyObject {
    func showOnBoarding()
    func getCurrentPage() -> OnBoardingPage?
    func getCurrentPageIndex() -> Int
    func getNextPage()
}

class OnBoardingPresenter {
    private weak var view: OnBoardingViewControllerProtocol?
    private let model: OnBoardingModel
    private var currentPageIndex = 0
    private let router: Routes
    typealias Routes = Closable

    init(view: OnBoardingViewControllerProtocol, model: OnBoardingModel, router: Routes) {
        self.view = view
        self.model = model
        self.router = router
    }

    private func showCurrentPage() {
        guard let page = getCurrentPage() else { return }
        view?.display(page: page)
    }
}

extension OnBoardingPresenter: OnBoardingPresenterProtocol {
    func showOnBoarding() {
        showCurrentPage()
    }

    func getCurrentPage() -> OnBoardingPage? {
        return model.getPage(at: currentPageIndex)
    }

    func getCurrentPageIndex() -> Int {
        return currentPageIndex
    }

    func getNextPage() {
        currentPageIndex += 1
        if currentPageIndex >= model.getPageCount() {
            print("Finish") // router.toMainScreen()
        } else {
            showCurrentPage()
        }
    }
}
