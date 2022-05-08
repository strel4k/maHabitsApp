//
//  HabitCollectionViewCell.swift
//  maHabitsApp
//
//  Created by Alexander on 07.05.2022.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    var habit: Habit?
    var habitCheckerAction: (()->())?
    
    private lazy var habitNameLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.headlineFont
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var habitSelectedTimeLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.textAlignment = .left
        label.textColor = .systemGray2
        label.font = Fonts.captionFont
        return label
    }()
    
    private lazy var habitCounter: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.textAlignment = .left
        label.textColor = .systemGray
        label.font = Fonts.footnoteFont
        return label
    }()
    lazy var checker: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setImage(UIImage(systemName: "checkmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40)), for: .normal)
        button.tintColor = .green
        button.addTarget(self, action: #selector(tapOnChecker), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.addSubviews(habitNameLabel, habitSelectedTimeLabel, habitCounter, checker)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setConfigureOfCell(habit: Habit) {
        self.habit = habit
        habitNameLabel.text = habit.name
        habitNameLabel.textColor = habit.color
        habitSelectedTimeLabel.text = habit.dateString
        checker.tintColor = habit.color
        habitCounter.text = "Счётчик: " + String(habit.trackDates.count)
        
        if habit.isAlreadyTakenToday == true {
            checker.setImage(UIImage(systemName: "checkmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40)), for: .normal)
            checker.isUserInteractionEnabled = false
        } else {
            self.checker.setImage(UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40)), for: .normal)
            checker.isUserInteractionEnabled = true
        }
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            habitNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.collectionViewCellIndent),
            habitNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.collectionViewCellIndent),
            
            habitSelectedTimeLabel.topAnchor.constraint(equalTo: habitNameLabel.bottomAnchor, constant: Constants.collectionViewCellInset),
            habitSelectedTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.collectionViewCellIndent),
            
            checker.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checker.leadingAnchor.constraint(equalTo: habitNameLabel.trailingAnchor, constant: Constants.collectionViewCellDoubleIndent),
            checker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.collectionViewCellTrailingMargin),
            checker.widthAnchor.constraint(equalToConstant: Constants.checkerSide),
            checker.heightAnchor.constraint(equalToConstant: Constants.checkerSide),
            
            habitCounter.topAnchor.constraint(equalTo: checker.bottomAnchor, constant: Constants.collectionViewCellIndent),
            habitCounter.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.collectionViewCellIndent),
            habitCounter.trailingAnchor.constraint(equalTo: checker.leadingAnchor, constant: Constants.collectionViewCellDoubleBackIndent)
        ])
    }
    
    @objc func tapOnChecker() {
        guard let trackedHabit = habit else { return }
        HabitsStore.shared.track(trackedHabit)
        habitCheckerAction?()
    }
}
