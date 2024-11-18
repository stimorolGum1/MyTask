//
//  CompleteScreenScreenViewController.swift
//  MyTask
//
//  Created by Danil on 12.08.2024.
//

import UIKit
import SnapKit

// MARK: - Protocol Definition

protocol CompleteScreenViewControllerProtocol: AnyObject {
    func updateCompleteTableView()
    func toggleEmptyView()
}

// MARK: - ViewController Implementation

final class CompleteScreenViewController: UIViewController {

    // MARK: - Properties

    var presenter: CompleteScreenPresenterProtocol!
    private let cellId = "CompleteCell"
    private let maxFontSize: CGFloat = 42
    private let minFontSize: CGFloat = 21

    // MARK: - UI Elements

    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = Localization.completeHeader
        label.font = UIFont.boldSystemFont(ofSize: 42)
        label.textColor = .white
        return label
    }()
    
    private lazy var searchCompelteBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.layer.cornerRadius = 10
        searchBar.layer.borderWidth = 1.0
        searchBar.layer.borderColor = UIColor.gray.cgColor
        searchBar.barTintColor = .clear
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: Localization.searchBarPlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        searchBar.searchTextField.textColor = .white
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var emptyTaskView: UIView = {
        let view = EmptyTaskView()
        return view
    }()
    
    private lazy var completeTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        toggleEmptyView()
    }

    // MARK: - Methods

    private func setupViews() {
        view.backgroundColor = .black
        [headerLabel, searchCompelteBar, completeTableView].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        searchCompelteBar.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(40)
        }
        
        completeTableView.snp.makeConstraints { make in
            make.top.equalTo(searchCompelteBar.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(15)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - Protocol Conformance

extension CompleteScreenViewController: CompleteScreenViewControllerProtocol {
    func updateCompleteTableView() {
        toggleEmptyView()
        completeTableView.reloadData()
    }
    
    func toggleEmptyView() {
        completeTableView.backgroundView = nil
        completeTableView.backgroundView = presenter.numberOfRowsInSection() > 0 ? nil : emptyTaskView
    }
}

extension CompleteScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? TableViewCell else {
            fatalError("Unable to dequeue TableViewCell")
        }
        let item = presenter.dataAtRow(index: indexPath)
        cell.display(
            taskNameLabel: item.taskName ?? "",
            dateLabel: item.taskDate?.convertToString() ?? ""
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = presenter.dataAtRow(index: indexPath)
        let taskViewModel = TaskViewScreenModel(
            taskID: item.objectID,
            taskDate: item.taskDate,
            taskDescription: item.taskDescription,
            taskName: item.taskName,
            taskPriority: item.taskPriority,
            taskStatus: item.taskStatus
        )
        presenter.openTaskView(data: taskViewModel)
    }
}

extension CompleteScreenViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.makeSearch(searchText: searchText)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        presenter.makeSearch(searchText: "")
    }
}
