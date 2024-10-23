//
//  CreateTaskViewController.swift
//  MyTask
//
//  Created by Danil on 30.09.2024.
//

import UIKit
import SnapKit

protocol CreateTaskViewControllerProtocol: AnyObject { }

final class CreateTaskViewController: UIViewController {
    
    var presenter: CreateTaskPesenterProtocol!
    private var heightConstraint: Constraint?
    
    private lazy var header: UILabel = {
        let label = UILabel()
        label.text = Localization.createTaskHeader
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 32)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.backgroundColor = .gray
        button.tintColor = .black
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(closeCreateTaskButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var taskTitleLabel: UILabel = {
        let label = UILabel()
        label.text = Localization.taskTitleLabel
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var taskTitleField: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.tintColor = .clear
        textView.isScrollEnabled = false
        textView.textColor = .white
        textView.backgroundColor = .black
        textView.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var taskDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = Localization.taskDescriptionLabel
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var taskDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.tintColor = .clear
        textView.backgroundColor = .black
        textView.isScrollEnabled = false
        textView.textColor = .white
        textView.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var taskDateLabel: UILabel = {
        let label = UILabel()
        label.text = Localization.taskDateLabel
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var taskDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = .gray
        datePicker.datePickerMode = .dateAndTime
        datePicker.layer.cornerRadius = 10
        datePicker.layer.masksToBounds = true
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    private lazy var taskPriorityLabel: UILabel = {
        let label = UILabel()
        label.text = Localization.taskPriorityLabel
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var taskPriorityButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = .gray
        button.menu = priorityMenu
        button.showsMenuAsPrimaryAction = true
        button.setTitle(Localization.taskPriorityButton, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var priorityMenu: UIMenu = {
        let actionOne = UIAction(title: Localization.actionOne) { _ in
            print("1")
        }

        let actionTwo = UIAction(title: Localization.actionTwo) { _ in
            print("2")
        }

        let actionThree = UIAction(title: Localization.actionThree) { _ in
            print("3")
        }
        let menu = UIMenu(title: Localization.menuTitle, children: [actionOne, actionTwo, actionThree])
        return menu
    }()
    
    private lazy var createTaskButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = .blue
        button.setTitle(Localization.createTaskButton, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        taskDescriptionTextView.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        setupViews()
        setupConstraints()
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    private func setupViews() {
        view.addSubview(header)
        view.addSubview(closeButton)
        view.addSubview(taskTitleLabel)
        view.addSubview(taskTitleField)
        view.addSubview(taskDescriptionLabel)
        view.addSubview(taskDescriptionTextView)
        view.addSubview(taskDateLabel)
        view.addSubview(taskDatePicker)
        view.addSubview(taskPriorityLabel)
        view.addSubview(taskPriorityButton)
        view.addSubview(createTaskButton)
    }
    
    private func setupConstraints() {
        header.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(20)
            make.trailing.equalTo(closeButton.snp.leading).offset(-10)
            make.height.equalTo(40)
        }

        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.trailing.equalTo(-20)
            make.height.width.equalTo(30)
        }
        
        taskTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(20)
            make.leading.equalTo(20)
            make.height.equalTo(15)
        }
        
        taskTitleField.snp.makeConstraints { make in
            make.top.equalTo(taskTitleLabel.snp.bottom).offset(10)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(40)
        }
        
        taskDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(taskTitleField.snp.bottom).offset(20)
            make.leading.equalTo(20)
            make.height.equalTo(15)
        }
        
        taskDescriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(taskDescriptionLabel.snp.bottom).offset(20)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            heightConstraint = make.height.equalTo(40).constraint
        }
        
        taskDateLabel.snp.makeConstraints { make in
            make.top.equalTo(taskDescriptionTextView.snp.bottom).offset(20)
            make.leading.equalTo(20)
            make.width.equalTo(view.snp.width).dividedBy(2).offset(-30)
            make.height.equalTo(40)
        }
        
        taskDatePicker.snp.makeConstraints { make in
            make.top.equalTo(taskDescriptionTextView.snp.bottom).offset(20)
            make.trailing.equalTo(-20)
            make.width.equalTo(view.snp.width).dividedBy(2).offset(-30)
            make.height.equalTo(40)
        }
        
        taskPriorityLabel.snp.makeConstraints { make in
            make.top.equalTo(taskDatePicker.snp.bottom).offset(20)
            make.leading.equalTo(20)
            make.width.equalTo(view.snp.width).dividedBy(2).offset(-30)
            make.height.equalTo(40)
        }
        
        taskPriorityButton.snp.makeConstraints { make in
            make.top.equalTo(taskDatePicker.snp.bottom).offset(20)
            make.trailing.equalTo(-20)
            make.width.equalTo(view.snp.width).dividedBy(2).offset(-30)
            make.height.equalTo(40)
        }
        
        createTaskButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }
    @objc private func closeCreateTaskButtonTapped() {
        presenter.closeCreateTask()
    }
    
}

extension CreateTaskViewController: CreateTaskViewControllerProtocol { }

extension CreateTaskViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
            let size = textView.sizeThatFits(CGSize(width: textView.frame.width, height: CGFloat.greatestFiniteMagnitude))
            textView.snp.updateConstraints { make in
                make.height.equalTo(size.height)
            }
        }
}
