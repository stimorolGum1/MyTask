//
//  TabBar.swift
//  MyTask
//
//  Created by Danil on 17.10.2024.
//
import UIKit
import SnapKit

protocol CustomTabBarDelegate: AnyObject { }

final class CustomTabBar: UITabBar {
    
    weak var customDelegate: CustomTabBarControllerProtocol?
    
    private lazy var centerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 35
        button.clipsToBounds = true
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(centerButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        unselectedItemTintColor = .darkGray
        tintColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(centerButton)
    }
    
    private func setupConstraints() {
        centerButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.top)
            make.width.height.equalTo(70)
        }
    }
    
    @objc func centerButtonTapped() {
        customDelegate?.openCreateTask()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let tabBarButtons = subviews.filter { $0 is UIControl && $0 != centerButton }.sorted { $0.frame.minX < $1.frame.minX }
        guard tabBarButtons.count == 4 else { return }
        let centralSpacing: CGFloat = 90.0
        let sideButtonSpacing: CGFloat = 10.0
        let tabBarWidth = self.frame.width
        let sideWidth = (tabBarWidth - centralSpacing) / 2.0
        let buttonWidth = (sideWidth - sideButtonSpacing) / 2.0
        for (index, button) in tabBarButtons[0...1].enumerated() {
            var frame = button.frame
            frame.origin.x = CGFloat(index) * (buttonWidth + sideButtonSpacing)
            frame.size.width = buttonWidth
            button.frame = frame
        }
        for (index, button) in tabBarButtons[2...3].enumerated() {
            var frame = button.frame
            frame.origin.x = tabBarWidth - sideWidth + CGFloat(index) * (buttonWidth + sideButtonSpacing)
            frame.size.width = buttonWidth
            button.frame = frame
        }
    }
    
    override func draw(_ rect: CGRect) {
        setupShape()
    }
    
    private func setupShape() {
        let path = setupBezierPath()
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineWidth = 3
        shape.strokeColor = UIColor.white.cgColor
        shape.fillColor = UIColor.white.cgColor
        layer.insertSublayer(shape, at: 0)
    }
    
    private func setupBezierPath() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 100, y: 0))
        path.addArc(withCenter: CGPoint(x: frame.width / 2, y: 0),
                    radius: 40,
                    startAngle: .pi,
                    endAngle: .pi * 2,
                    clockwise: false)
        path.addLine(to: CGPoint(x: frame.width, y: 0))
        path.addLine(to: CGPoint(x: frame.width, y: frame.height))
        path.addLine(to: CGPoint(x: 0, y: frame.height))
        return path
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if centerButton.frame.contains(point) {
            return centerButton
        } else {
            return super.hitTest(point, with: event)
        }
    }
}

extension CustomTabBar: CustomTabBarDelegate { }
