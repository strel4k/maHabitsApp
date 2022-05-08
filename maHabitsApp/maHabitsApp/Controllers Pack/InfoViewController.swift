//
//  InfoViewController.swift
//  maHabitsApp
//
//  Created by Alexander on 07.05.2022.
//

import UIKit

class InfoViewController: UIViewController {

    private lazy var infoScrollView: UIScrollView = {
        let scrollVIew = UIScrollView()
        scrollVIew.translatesAutoresizingMaskIntoConstraints = false
        return scrollVIew
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.toAutoLayout()
        return contentView
    }()
    
    private lazy var informationTitle: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "Привычка за 21 день"
        label.numberOfLines = 1
        label.textColor = .black
        label.font = Fonts.title3Font
        return label
    }()
    
    private lazy var informationTextView: UITextView = {
        let textView = UITextView()
        textView.toAutoLayout()
        textView.text = InfoDescription.placeholder
        textView.font = Fonts.bodyFont
        textView.textColor = .black
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.isSelectable = false
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(infoScrollView)
        infoScrollView.addSubview(contentView)
        infoScrollView.contentSize = self.informationTextView.bounds.size
        contentView.addSubviews(informationTitle, informationTextView)
        setupConstraints()
        self.loadViewIfNeeded()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            infoScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            infoScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            infoScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: infoScrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: infoScrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: infoScrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: infoScrollView.trailingAnchor),
            contentView.centerXAnchor.constraint(equalTo: infoScrollView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: infoScrollView.centerYAnchor),
            
            informationTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.leadingMargin),
            informationTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingMargin),
            informationTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingMargin),
            informationTitle.heightAnchor.constraint(equalToConstant: Constants.heightOfInformationTitle),

            informationTextView.topAnchor.constraint(equalTo: informationTitle.bottomAnchor),
            informationTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingMargin),
            informationTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingMargin),
            informationTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
