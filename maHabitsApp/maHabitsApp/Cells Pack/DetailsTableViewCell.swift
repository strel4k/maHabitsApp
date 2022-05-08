//
//  DetailsTableViewCell.swift
//  maHabitsApp
//
//  Created by Alexander on 07.05.2022.
//

import UIKit

import UIKit

class HabitDetailTableViewCell: UITableViewCell {

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.title3Font
        return label
    }()
    
    lazy var checker: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.title3Font
        label.textColor = Colors.purpleColor
        label.text = "✔︎"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(dateLabel, checker)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.indent),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingMargin),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.indent),
            checker.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.indent),
            checker.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: Constants.leadingMargin),
            checker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingMargin)
        ])
    }
    
    func setConfigureOfCell(index: Int, check: Bool) {
        dateLabel.text = HabitsStore.shared.trackDateString(forIndex: index)
        checker.isHidden = !check
    }
}
