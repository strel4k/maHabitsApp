//
//  Presets.swift
//  maHabitsApp
//
//  Created by Alexander on 07.05.2022.
//

import Foundation
import UIKit

public struct Fonts {
    static let title3Font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    static let headlineFont = UIFont.systemFont(ofSize: 17, weight: .semibold)
    static let bodyFont = UIFont.systemFont(ofSize: 17, weight: .regular)
    static let footnoteBoldFont = UIFont.systemFont(ofSize: 13, weight: .semibold)
    static let footnoteStatusFont = UIFont.systemFont(ofSize: 13, weight: .semibold)
    static let footnoteFont = UIFont.systemFont(ofSize: 13, weight: .regular)
    static let captionFont = UIFont.systemFont(ofSize: 12, weight: .regular)
}

public struct Colors {
    static let lightGrayColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
    static var purpleColor = UIColor(red: 161/255, green: 22/255, blue: 204/255, alpha: 1)
    static let blueColor = UIColor(red: 41/255, green: 109/255, blue: 255/255, alpha: 1)
    static let greenColor = UIColor(red: 29/255, green: 179/255, blue: 34/255, alpha: 1)
    static let indigoColor = UIColor(red: 98/255, green: 54/255, blue: 255/255, alpha: 1)
    static let orangeColor = UIColor(red: 255/255, green: 159/255, blue: 79/255, alpha: 1)
    static let navigationBarColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 0.94)
}

public struct Labels {
    
    static let today = "Сегодня"
    static let yesterday = "Вчера"
    static let beforeYesterday = "Позавчера"
    
    static let info = "Информация"
        static let habitsTabBarTitle = "Привычки"
    
    static let createLabel = "Создать"
    static let saveLabel = "Сохранить"
    static let cancelLabel = "Отменить"
    static let deleteLabel = "Удалить"
    static let editLabel = "Править"
    static let todayBack = "❮ Сегодня"
    static let nameLabel = "НАЗВАНИЕ"
    static let colorLabel = "ЦВЕТ"
    static let timeLabel = "ВРЕМЯ"
    static let activityLabel = "  АКТИВНОСТЬ"
    static let everyDay = "Каждый день в "
    static let habitNamePlaceholder = "Бегать по утрам, спать 8 часов и т.п."
    static let motivation = "Всё получится!"
    static let unknown = "unknown"
    static let alertDelete = "Удалить привычку"
}

public struct InfoDescription {
        
    static let placeholder = "Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму: 1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага. \n\n2. Выдержать 2 дня в прежнем состоянии самоконтроля. \n\n3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться. \n\n4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств. \n\n5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой. \n\n6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся. \n\nИсточник: psychbook.ru"
}

public struct Constants {
    static let leadingMargin: CGFloat = 16
    static let trailingMargin: CGFloat = -16
    static let indent: CGFloat = 12
    static let inset: CGFloat = 8
    
    static let topSectionInset: CGFloat = 22
    static let bottomSectionInset: CGFloat = 12
    static let heightOfInformationTitle: CGFloat = 40
    static let heightOfTimePicker: CGFloat = 200
    static let colorPickerSide: CGFloat = 30
    static let checkerSide: CGFloat = 36
    static let heightFor0Section: CGFloat = 60
    static let heightFor1Section: CGFloat = 130
    
    static let collectionViewCellIndent: CGFloat = 20
    static let collectionViewCellBackIndent: CGFloat = -20
    static let collectionViewCellDoubleIndent: CGFloat = 40
    static let collectionViewCellDoubleBackIndent: CGFloat = -20
    static let collectionViewCellInset: CGFloat = 4
    static let collectionViewCellTrailingMargin: CGFloat = -25



}

public extension UIView {

    func toAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviews(_ subviews: UIView...) {
          subviews.forEach { addSubview($0) }
      }
}

public extension UIColor {
    static var randomColor: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}
