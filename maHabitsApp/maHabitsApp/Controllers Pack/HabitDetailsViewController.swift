//
//  HabitDetailsViewController.swift
//  maHabitsApp
//
//  Created by Alexander on 07.05.2022.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    let habit: Habit

    private lazy var rightBarButtonItem = setBarButton(title: Labels.editLabel, action: #selector(editHabit))
    private lazy var leftBarButtonItem = setBarButton(title: Labels.todayBack, action: #selector(tapToCancel))

    static let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped )
        table.toAutoLayout()
        table.separatorInset = .zero
        table.rowHeight = UITableView.automaticDimension
        return table
    }()

    init(_ habit: Habit) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.lightGrayColor
        view.addSubview(HabitDetailsViewController.tableView)
        setupConstraints()
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
        HabitDetailsViewController.tableView.dataSource = self
        HabitDetailsViewController.tableView.delegate = self
        
        HabitDetailsViewController.tableView.register(
            HabitDetailTableViewCell.self,
            forCellReuseIdentifier: String(
                describing: HabitDetailTableViewCell.self)
        )
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        title = habit.name
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            HabitDetailsViewController.tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            HabitDetailsViewController.tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            HabitDetailsViewController.tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            HabitDetailsViewController.tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    @objc func tapToCancel() {
        navigationController?.popViewController(animated: true)
    }

    @objc func editHabit() {
        navigationController?.pushViewController(HabitViewController(habit), animated: true)
    }
    
    private func setBarButton(title: String, action: Selector) -> UIBarButtonItem {
        let button = UIBarButtonItem  (
            title: title,
            style: .plain ,
            target: self,
            action: action
        )
        button.tintColor = Colors.purpleColor
        return button
    }
}

extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HabitDetailTableViewCell.self), for: indexPath) as? HabitDetailTableViewCell else { return UITableViewCell() }
        let date = HabitsStore.shared.dates[indexPath.row]
        cell.setConfigureOfCell(index: indexPath.row, check: HabitsStore.shared.habit(habit, isTrackedIn: date))
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Labels.activityLabel
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
