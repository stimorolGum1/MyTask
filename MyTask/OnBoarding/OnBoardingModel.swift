//
//  OnBoardingModel.swift
//  MyTask
//
//  Created by Danil on 02.08.2024.
//

import Foundation
import UIKit

struct OnBoardingPage {
    let imageName: UIImage!
    let text: String
}

struct OnBoardingModel {
    private var pages: [OnBoardingPage] = [
        OnBoardingPage(imageName: UIImage(named: "onBoarding1"), text: Localization.onBoardingSlide1),
        OnBoardingPage(imageName: UIImage(named: "onBoarding2"), text: Localization.onBoardingSlide2),
        OnBoardingPage(imageName: UIImage(named: "onBoarding3"), text: Localization.onBoardingSlide3)
    ]
    
    func getPage(at index: Int) -> OnBoardingPage? {
        guard index >= 0 && index < pages.count else { return nil }
        return pages[index]
    }
    
    func getPageCount() -> Int {
        return pages.count
    }
}
