//
//  ProgressBarCollectionViewCell.swift
//  maHabitsApp
//
//  Created by Alexander on 07.05.2022.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
   
    private lazy var progressNameLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.textColor = .systemGray
        label.text = Labels.motivation
        label.font = Fonts.footnoteFont
        return label
    }()
    
    private lazy var progressProcentLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.footnoteFont
        label.textColor = .systemGray
        label.text = "50%"
        return label
    }()
    
    private lazy var progressLine: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .bar )
        progress.toAutoLayout()
        progress.trackTintColor = .systemGray2
        progress.progressTintColor = Colors.purpleColor
        progress.backgroundColor = .white
        progress.layer.cornerRadius = 5
        progress.clipsToBounds = true
        progress.layer.sublayers![1].cornerRadius = 3
        progress.subviews[1].clipsToBounds = true
        return progress
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        setupContent()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func setupContent() {
        contentView.addSubviews(progressNameLabel, progressProcentLabel, progressLine)
        progressLine.setProgress(HabitsStore.shared.todayProgress, animated: true)
        progressProcentLabel.text = String(Int(HabitsStore.shared.todayProgress * 100)) + "%"
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            progressNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.indent),
            progressNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.indent),
            
            progressProcentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.indent),
            progressProcentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.indent),

            progressLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.indent),
            progressLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.indent),
            progressLine.topAnchor.constraint(equalTo: progressNameLabel.bottomAnchor, constant: Constants.indent),
            progressLine.heightAnchor.constraint(equalToConstant: Constants.indent / 2),
        ])
    }
}
