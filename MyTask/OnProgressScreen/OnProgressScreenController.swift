//
//  OnProgressScreenController.swift
//  MyTask
//
//  Created by Danil on 12.08.2024.
//

import UIKit
import SnapKit

// MARK: - Protocol Definitions

protocol OnProgressScreenViewControllerProtocol: AnyObject {
    func updateOnProgressTableView()
    func toggleEmptyView()
}

// MARK: - ViewController Implementation

final class OnProgressScreenViewController: UIViewController {

    // MARK: - Properties

    var presenter: OnProgressScreenPresenterProtocol!
    private let cellId = "onProgressCell"
    private let maxFontSize: CGFloat = 42
    private let minFontSize: CGFloat = 21

    // MARK: - UI Elements

    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = Localization.onProgressHeader
        label.font = .boldSystemFont(ofSize: 42)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var searchOnProgressBar: UISearchBar = {
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
    
    private lazy var onProgressTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureConstraints()
        toggleEmptyView()
    }

    // MARK: - Methods

    private func configureView() {
        view.backgroundColor = .black
        [headerLabel, searchOnProgressBar, onProgressTableView].forEach {
            view.addSubview($0)
        }
    }
    
    private func configureConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        searchOnProgressBar.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(40)
        }
        
        onProgressTableView.snp.makeConstraints { make in
            make.top.equalTo(searchOnProgressBar.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(15)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - Protocol Conformance

extension OnProgressScreenViewController: OnProgressScreenViewControllerProtocol {
    func updateOnProgressTableView() {
        toggleEmptyView()
        onProgressTableView.reloadData()
    }
    
    func toggleEmptyView() {
        onProgressTableView.backgroundView = nil
        onProgressTableView.backgroundView = presenter.numberOfRowsInSection() > 0 ? nil : emptyTaskView
    }
}

extension OnProgressScreenViewController: UITableViewDataSource, UITableViewDelegate {
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

extension OnProgressScreenViewController: UISearchBarDelegate {
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
