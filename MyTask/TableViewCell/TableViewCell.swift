//
//  ToDoScreenCell.swift
//  MyTask
//
//  Created by Danil on 20.08.2024.
//

import UIKit
import SnapKit

// MARK: - TableViewCell

final class TableViewCell: UITableViewCell {

    // MARK: - UI Elements

    private lazy var cellView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2117647059, green: 0.2117647059, blue: 0.2117647059, alpha: 1)
        view.layer.cornerRadius = 15
        return view
    }()

    private lazy var taskNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        label.textColor = .white
        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "ToDo"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        label.textColor = #colorLiteral(red: 0.6862745098, green: 0.6862745098, blue: 0.6862745098, alpha: 1)
        return label
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    private func setupViews() {
        contentView.addSubview(cellView)
        cellView.addSubview(taskNameLabel)
        cellView.addSubview(dateLabel)
    }

    private func setupConstraints() {
        cellView.snp.makeConstraints { make in
            make.height.equalTo(72)
            make.leading.trailing.equalTo(0)
            make.top.equalTo(contentView.snp.top).inset(15)
            make.bottom.equalTo(contentView.snp.bottom).inset(15)
        }
        taskNameLabel.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.leading.equalTo(10)
            make.height.equalTo(30)
        }
        dateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(-10)
            make.leading.equalTo(10)
            make.height.equalTo(20)
        }
    }

    func display(taskNameLabel: String, dateLabel: String) {
        self.taskNameLabel.text = taskNameLabel
        self.dateLabel.text = dateLabel
    }
}
