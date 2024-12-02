//
//  CreateTaskViewController.swift
//  MyTask
//
//  Created by Danil on 30.09.2024.
//

import UIKit
import SnapKit

// MARK: - Protocol Definitions

protocol CreateTaskViewControllerProtocol: AnyObject {}

// MARK: - ViewController Implementation

final class CreateTaskViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: CreateTaskPesenterProtocol!
    private var heightConstraint: Constraint?
    private var priority: NSDecimalNumber?
    private var status: NSDecimalNumber?
    
    private lazy var header: UILabel = {
        let label = UILabel()
        label.text = Localization.createTaskHeader
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 32)
        label.textColor = .white
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.backgroundColor = .gray
        button.tintColor = .black
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(closeCreateTaskButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var taskTitleLabel: UILabel = {
        let label = UILabel()
        label.text = Localization.taskTitleLabel
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        label.textColor = .white
        return label
    }()
    
    private lazy var taskTitleTextView: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.tintColor = .clear
        textView.isScrollEnabled = false
        textView.textColor = .white
        textView.backgroundColor = .black
        textView.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        return textView
    }()
    
    private lazy var taskDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = Localization.taskDescriptionLabel
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        label.textColor = .white
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
        textView.delegate = self
        return textView
    }()
    
    private lazy var taskDateLabel: UILabel = {
        let label = UILabel()
        label.text = Localization.taskDateLabel
        label.textColor = .white
        return label
    }()
    
    private lazy var taskDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = .gray
        datePicker.datePickerMode = .dateAndTime
        datePicker.layer.cornerRadius = 10
        datePicker.layer.masksToBounds = true
        return datePicker
    }()
    
    private lazy var taskPriorityLabel: UILabel = {
        let label = UILabel()
        label.text = Localization.taskPriorityLabel
        label.textColor = .white
        return label
    }()
    
    private lazy var taskPriorityButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = .gray
        button.menu = priorityMenu
        button.showsMenuAsPrimaryAction = true
        button.setTitle(Localization.taskPriorityButton, for: .normal)
        return button
    }()
    
    private lazy var priorityMenu: UIMenu = {
        let actionOne = UIAction(title: Localization.priorityOne) { [weak self] _ in
            self?.priority = 1
            self?.taskPriorityButton.setTitle(Localization.priorityOne, for: .normal)
        }
        
        let actionTwo = UIAction(title: Localization.priorityTwo) { [weak self] _  in
            self?.priority = 2
            self?.taskPriorityButton.setTitle(Localization.priorityTwo, for: .normal)
        }
        
        let actionThree = UIAction(title: Localization.priorityThree) { [weak self] _  in
            self?.priority = 3
            self?.taskPriorityButton.setTitle(Localization.priorityThree, for: .normal)
        }
        let menu = UIMenu(title: Localization.priorityMenuTitle, children: [actionOne, actionTwo, actionThree])
        return menu
    }()
    
    private lazy var taskStatusLabel: UILabel = {
        let label = UILabel()
        label.text = Localization.taskStatusLabel
        label.textColor = .white
        return label
    }()
    
    private lazy var taskStatusButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = .gray
        button.menu = statusMenu
        button.showsMenuAsPrimaryAction = true
        button.setTitle(Localization.taskStatusButton, for: .normal)
        return button
    }()
    
    private lazy var statusMenu: UIMenu = {
        let actionOne = UIAction(title: Localization.toDo) { [weak self] _ in
            self?.status = 1
            self?.taskStatusButton.setTitle(Localization.toDo, for: .normal)
        }
        
        let actionTwo = UIAction(title: Localization.onProgress) { [weak self] _ in
            self?.status = 2
            self?.taskStatusButton.setTitle(Localization.onProgress, for: .normal)
        }
        
        let actionThree = UIAction(title: Localization.complete) { [weak self] _ in
            self?.status = 3
            self?.taskStatusButton.setTitle(Localization.complete, for: .normal)
        }
        
        let menu = UIMenu(title: Localization.statusMenuTitle, children: [actionOne, actionTwo, actionThree])
        return menu
    }()
    
    private lazy var createTaskButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = .blue
        button.setTitle(Localization.createTaskButton, for: .normal)
        button.addTarget(self, action: #selector(createTaskButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Methods
    
    private func setupViews() {
        view.backgroundColor = .black
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        [header, closeButton, taskTitleLabel, taskTitleTextView, taskDescriptionLabel, taskDescriptionTextView,
         taskDateLabel, taskDatePicker, taskPriorityLabel, taskPriorityButton, taskStatusLabel, taskStatusButton, createTaskButton]
            .forEach { view.addSubview($0) }
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
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
        
        taskTitleTextView.snp.makeConstraints { make in
            make.top.equalTo(taskTitleLabel.snp.bottom).offset(10)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(40)
        }
        
        taskDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(taskTitleTextView.snp.bottom).offset(20)
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
        
        taskStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(taskPriorityLabel.snp.bottom).offset(20)
            make.leading.equalTo(20)
            make.width.equalTo(view.snp.width).dividedBy(2).offset(-30)
            make.height.equalTo(40)
        }
        
        taskStatusButton.snp.makeConstraints { make in
            make.top.equalTo(taskPriorityLabel.snp.bottom).offset(20)
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
    
    @objc private func createTaskButtonTapped() {
        if taskDescriptionLabel.text != "" &&
            taskTitleLabel.text != "" &&
            priority != nil &&
            status != nil {
            presenter.createTask(taskDate: taskDatePicker.date,
                                 taskDescription: taskDescriptionTextView.text,
                                 taskName: taskTitleTextView.text,
                                 taskPriority: priority!,
                                 taskStatus: status!) { [weak self] status in
                self?.showAlert(message: status)
            }
        } else {
            self.showAlert(message: Localization.fillAll)
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Protocol Conformance

extension CreateTaskViewController: CreateTaskViewControllerProtocol { }

extension CreateTaskViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = textView.sizeThatFits(CGSize(width: textView.frame.width, height: CGFloat.greatestFiniteMagnitude))
        textView.snp.updateConstraints { make in
            make.height.equalTo(size.height)
        }
    }
}
