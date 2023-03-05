//
//  HabitViewController.swift
//  maHabitsApp
//
//  Created by Alexander on 07.05.2022.
//

import UIKit


class HabitViewController: UIViewController, UITextFieldDelegate {

    var habit: Habit?
    var habitName: String = ""
    
    var currentTime: String {
        get {
            let date = timePicker.date
            let time = DateFormatter()
            time.dateFormat = "HH:mm"
            return time.string(from: date)
        }
    }
    
    private lazy var habitNameTitleLabel = habitLabel(Labels.nameLabel)
    private lazy var habitColorTitleLabel = habitLabel(Labels.colorLabel)
    private lazy var habitTimeTitleLabel = habitLabel(Labels.timeLabel)
    
    private lazy var habitScrollView: UIScrollView = {
        let scrollVIew = UIScrollView(frame: self.view.bounds)
        scrollVIew.isScrollEnabled = false
        return scrollVIew
    }()
    
    private lazy var habitContentView: UIView = {
        let contentView = UIView()
        contentView.toAutoLayout()
        return contentView
    }()

    private lazy var habitSelectedTime: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = habit?.dateString ?? "\(Labels.everyDay)\(currentTime)"
        label.textColor = .black
        label.font = Fonts.bodyFont
        return label
    }()

    private lazy var habitNameTextField: UITextField = {
        let textField = UITextField()
        textField.toAutoLayout()
        textField.backgroundColor = .clear
        textField.placeholder = Labels.habitNamePlaceholder
        textField.font = Fonts.bodyFont
        textField.textColor = .black
        textField.autocorrectionType = UITextAutocorrectionType.yes
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.isEnabled = true
        textField.addTarget(self, action: #selector(saveButtonEnable), for: .editingChanged)
        return textField
    }()
    
    private lazy var habitColorPicker: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.backgroundColor = UIColor.randomColor
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(openColorPickerViewController), for: .touchUpInside)
        return button
    }()
    
    private lazy var timePicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.toAutoLayout()
        timePicker.backgroundColor = .white.withAlphaComponent(0.9)
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
        return timePicker
    }()
    
    private lazy var deleteHabitButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.backgroundColor = .clear
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(removeHabit), for: .touchUpInside)
        return button
    }()
    
    init(_ habitForEditing: Habit?) {
        super.init(nibName: nil, bundle: nil)
        habit = habitForEditing
        if let habitSource = habit {
            habitNameTextField.text = habitSource.name
            habitColorPicker.backgroundColor = habitSource.color
            timePicker.date = habitSource.date
            deleteHabitButton.isHidden = false
        } else {
            deleteHabitButton.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        habitNameTextField.delegate = self
        
        title = (habit == nil) ? Labels.createLabel : Labels.editLabel
        
        view.backgroundColor = .white
        
        let leftBarButtonItem = UIBarButtonItem(
            title: Labels.cancelLabel,
            style: .plain,
            target: self,
            action: #selector(cancelHabit)
        )
        let rightBarButtonItem = UIBarButtonItem(
            title: Labels.saveLabel,
            style: .plain ,
            target: self,
            action: #selector(saveHabit)
        )
        leftBarButtonItem.tintColor = Colors.purpleColor
        leftBarButtonItem.isEnabled = true
        navigationItem.leftBarButtonItem = leftBarButtonItem
        rightBarButtonItem.tintColor = Colors.purpleColor
        rightBarButtonItem.isEnabled = true
        navigationItem.rightBarButtonItem = rightBarButtonItem
        setupContent()
        saveButtonEnable()
        
        if let habit = habit {
            setConfigureOfViewController(habit: habit)
        }
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    public func setConfigureOfViewController (habit: Habit) {
        self.habit = habit
        self.habitNameTextField.text = habit.name
        self.habitColorPicker.backgroundColor = habit.color
        self.timePicker.date = habit.date
    }
    
    private func setupContent() {
        view.addSubview(habitScrollView)
        habitScrollView.addSubview(habitContentView)
        habitScrollView.contentSize = self.habitContentView.bounds.size
        habitContentView.addSubviews(habitNameTitleLabel, habitNameTextField, habitColorTitleLabel, habitColorPicker, habitTimeTitleLabel, habitSelectedTime, timePicker, deleteHabitButton)
        setupConstraints()
        self.loadViewIfNeeded()
    }
    
    @objc func saveHabit() {
        if let currentHabit = habit {
            currentHabit.name = habitNameTextField.text ?? Labels.unknown
            currentHabit.date = timePicker.date
            currentHabit.color = habitColorPicker.backgroundColor ?? Colors.purpleColor
            HabitsStore.shared.save()
        } else {
            let newHabit = Habit(name: habitNameTextField.text ?? Labels.unknown,
                                 date: timePicker.date,
                                 color: habitColorPicker.backgroundColor ?? Colors.purpleColor)
            if HabitsStore.shared.habits.contains(newHabit) == false {
                HabitsStore.shared.habits.append(newHabit)
            }
        }
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func removeHabit(sender: UIButton!) {
        let name = habit?.name ?? Labels.unknown
        let alertController = UIAlertController(
            title: Labels.alertDelete,
            message: "Вы хотите удалить привычку \(name)?",
            preferredStyle: .alert)
        
        let acceptAction = UIAlertAction(title: Labels.cancelLabel, style: .default) { (_) -> Void in }
        let declineAction = UIAlertAction(title: Labels.deleteLabel, style: .destructive) { (_) -> Void in
            if let removingHabit = self.habit {
                HabitsStore.shared.habits.removeAll(where: {$0 == removingHabit})
            }
            self.navigationController?.popToRootViewController(animated: true)
        }
        alertController.addAction(acceptAction)
        alertController.addAction(declineAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func cancelHabit () {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func openColorPickerViewController() {
        let picker = UIColorPickerViewController()
        picker.delegate = self
        picker.selectedColor = habitColorPicker.backgroundColor ?? Colors.purpleColor
        present(picker, animated: true)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            habitContentView.topAnchor.constraint(equalTo: habitScrollView.topAnchor),
            habitContentView.bottomAnchor.constraint(equalTo: habitScrollView.bottomAnchor),
            habitContentView.leadingAnchor.constraint(equalTo: habitScrollView.leadingAnchor),
            habitContentView.trailingAnchor.constraint(equalTo: habitScrollView.trailingAnchor),
            habitContentView.centerXAnchor.constraint(equalTo: habitScrollView.centerXAnchor),
            habitContentView.centerYAnchor.constraint(equalTo: habitScrollView.centerYAnchor),
            
            habitNameTitleLabel.topAnchor.constraint(equalTo: habitContentView.topAnchor, constant: Constants.leadingMargin),
            habitNameTitleLabel.leadingAnchor.constraint(equalTo: habitContentView.leadingAnchor, constant: Constants.leadingMargin),
            
            habitNameTextField.topAnchor.constraint(equalTo: habitNameTitleLabel.bottomAnchor, constant: Constants.inset),
            habitNameTextField.leadingAnchor.constraint(equalTo: habitContentView.leadingAnchor, constant: Constants.leadingMargin),
            habitNameTextField.trailingAnchor.constraint(equalTo: habitContentView.trailingAnchor, constant: Constants.trailingMargin),
            
            habitColorTitleLabel.topAnchor.constraint(equalTo: habitNameTextField.bottomAnchor, constant: Constants.leadingMargin),
            habitColorTitleLabel.leadingAnchor.constraint(equalTo: habitContentView.leadingAnchor, constant: Constants.leadingMargin),
            
            habitColorPicker.topAnchor.constraint(equalTo: habitColorTitleLabel.bottomAnchor, constant: Constants.inset),
            habitColorPicker.leadingAnchor.constraint(equalTo: habitContentView.leadingAnchor, constant: Constants.leadingMargin),
            habitColorPicker.widthAnchor.constraint(equalToConstant: Constants.colorPickerSide),
            habitColorPicker.heightAnchor.constraint(equalToConstant: Constants.colorPickerSide),
            
            habitTimeTitleLabel.topAnchor.constraint(equalTo: habitColorPicker.bottomAnchor, constant: Constants.leadingMargin),
            habitTimeTitleLabel.leadingAnchor.constraint(equalTo: habitContentView.leadingAnchor, constant: Constants.leadingMargin),
            
            habitSelectedTime.topAnchor.constraint(equalTo: habitTimeTitleLabel.bottomAnchor, constant: Constants.inset),
            habitSelectedTime.leadingAnchor.constraint(equalTo: habitContentView.leadingAnchor, constant: Constants.leadingMargin),
                        
            timePicker.topAnchor.constraint(equalTo: habitSelectedTime.bottomAnchor, constant: Constants.leadingMargin),
            timePicker.leadingAnchor.constraint(equalTo: habitContentView.leadingAnchor, constant: Constants.leadingMargin),
            timePicker.trailingAnchor.constraint(equalTo: habitContentView.trailingAnchor, constant: Constants.trailingMargin),
            timePicker.heightAnchor.constraint(equalToConstant: Constants.heightOfTimePicker),
            
            deleteHabitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constants.trailingMargin),
            deleteHabitButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
            
        ])
    }

    private func habitLabel(_ title: String) -> UILabel {
        let label = UILabel()
        label.toAutoLayout()
        label.text = title
        label.textColor = .black
        label.font = Fonts.footnoteFont
        label.numberOfLines = 1
        return label
    }
    
    private func equotable() -> Bool {
        return habit?.name == habitNameTextField.text &&
        habit?.color == habitColorPicker.backgroundColor &&
        habit?.date == timePicker.date
    }

    @objc func saveButtonEnable() {
        if habitNameTextField.text?.isEmpty == true || equotable() == true {
            navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    @objc func timeChanged () {
        habitSelectedTime.text = "\(Labels.everyDay)\(currentTime)"
        saveButtonEnable()
    }
}

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
   
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        habitColorPicker.backgroundColor = viewController.selectedColor
        saveButtonEnable()
    }
}
