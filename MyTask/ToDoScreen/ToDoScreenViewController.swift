//
//  ToDoScreenViewController.swift
//  MyTask
//
//  Created by Danil on 12.08.2024.
//

import UIKit
import SnapKit

protocol ToDoScreenViewControllerProtocol: AnyObject { }

final class ToDoScreenViewController: UIViewController {
    
    var presenter: ToDoScreenPresenterProtocol!
    private let cellId = "toDoCell"
    private let maxFontSize: CGFloat = 42
    private let minFontSize: CGFloat = 21
    
    private lazy var header: UILabel = {
        let label = UILabel()
        label.text = "ToDo"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: maxFontSize)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var sortButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "filter"), for: .normal)
        button.menu = priorityMenu
        button.showsMenuAsPrimaryAction = true
        return button
    }()
    
    private lazy var searchTodoBar: UISearchBar = {
        let search = UISearchBar()
        search.layer.cornerRadius = 10
        search.layer.borderWidth = 1.0
        search.layer.borderColor = UIColor.gray.cgColor
        search.barTintColor = .clear
        search.searchBarStyle = .minimal
        search.searchTextField.attributedPlaceholder = NSAttributedString(
            string: Localization.searchBarPlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        search.searchTextField.textColor = .white
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    private lazy var emptyTaskView: UIView = {
        let view = EmptyTaskView()
        return view
    }()
    
    private lazy var toDoTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var priorityMenu: UIMenu = {
        let actionOne = UIAction(title: "High", image: UIImage(systemName: "star")) { _ in
            // Perform action 1
            print("1")
        }

        let actionTwo = UIAction(title: "Middle", image: UIImage(systemName: "heart")) { _ in
            // Perform action 2
            print("2")
        }

        let actionThree = UIAction(title: "Low", image: UIImage(systemName: "bell")) { _ in
            // Perform action 3
            print("3")
        }
        let menu = UIMenu(title: "choose priority", children: [actionOne, actionTwo, actionThree])
        return menu
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        searchTodoBar.delegate = self
        toDoTableView.register(TableViewCell.self, forCellReuseIdentifier: cellId)
        setupViews()
        setupConstraints()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        if presenter.numberOfRowsInSection() == 0 {
            toDoTableView.removeFromSuperview()
        } else {
            emptyTaskView.removeFromSuperview()
        }
    }
    
    func setupViews() {
        view.addSubview(header)
        view.addSubview(sortButton)
        view.addSubview(searchTodoBar)
        view.addSubview(toDoTableView)
        view.addSubview(emptyTaskView)
    }
    
    func setupConstraints() {
        header.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(20)
            make.height.equalTo(40)
        }
        
        sortButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(-20)
            make.height.width.equalTo(30)
        }
        
        searchTodoBar.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(10)
            make.leading.equalTo(15)
            make.trailing.equalTo(-15)
            make.height.equalTo(40)
        }
        toDoTableView.snp.makeConstraints { make in
            make.top.equalTo(searchTodoBar.snp.bottom).offset(10)
            make.leading.equalTo(15)
            make.trailing.equalTo(-15)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        
        emptyTaskView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(200)
            make.width.equalTo(300)
        }
    }
    
    @objc private func dismissKeyboard() {
            view.endEditing(true)
        }
}

extension ToDoScreenViewController: ToDoScreenViewControllerProtocol { }

extension ToDoScreenViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCell
        cell.taskNameLabel.text = "task \(indexPath.row)"
        cell.dateLabel.text = " 0\(indexPath.row).0\(indexPath.row).0\(indexPath.row)"
        return cell
    }
}
extension ToDoScreenViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let headerHeight: CGFloat = 100
        let fontSize = max(maxFontSize - (offsetY / headerHeight) * (maxFontSize - minFontSize), minFontSize)
        header.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
}

extension ToDoScreenViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != " " {
            print(searchText)
        }
    }
}
