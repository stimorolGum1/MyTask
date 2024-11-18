//
//  OnBoardingModel.swift
//  MyTask
//
//  Created by Danil on 02.08.2024.
//

import Foundation
import UIKit

// MARK: - OnBoardingPage

struct OnBoardingPage {
    let imageName: UIImage!
    let text: String
}

// MARK: - OnBoardingModel

struct OnBoardingModel {
    
    // MARK: - Properties
    
    private var pages: [OnBoardingPage] = [
        OnBoardingPage(imageName: UIImage(named: "onBoarding1"), text: Localization.slide1),
        OnBoardingPage(imageName: UIImage(named: "onBoarding2"), text: Localization.slide2),
        OnBoardingPage(imageName: UIImage(named: "onBoarding3"), text: Localization.slide3)
    ]
    
    // MARK: - Methods
    
    func getPage(at index: Int) -> OnBoardingPage? {
        guard index >= 0 && index < pages.count else { return nil }
        return pages[index]
    }
    
    func getPageCount() -> Int {
        return pages.count
    }
}
