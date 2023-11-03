//
//  BookInfoCell.swift
//  TestTask
//
//  Created by Шахова Анастасия on 01.11.2023.
//

import Foundation
import UIKit

class BookInfoCell: UITableViewCell {

    let bookNameLabel = UILabel(text: "Book name", font: .laoSangamMN18())
    let authorNameLabel = UILabel(text: "Autor name", font: .laoSangamMN14())
    let ratingLabel = UILabel(text: "rating", font: .laoSangamMN14())

    weak var viewModel: BookInfoCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            bookNameLabel.text = viewModel.title
            authorNameLabel.text = viewModel.author
            ratingLabel.text = viewModel.rating
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .white
        ratingLabel.textAlignment = .center
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
   }
}

extension BookInfoCell {
    private func setupConstraints() {

        bookNameLabel.translatesAutoresizingMaskIntoConstraints = false
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(bookNameLabel)
        addSubview(authorNameLabel)
        addSubview(ratingLabel)
  
        NSLayoutConstraint.activate([
            bookNameLabel.topAnchor.constraint(equalTo: topAnchor),
            bookNameLabel.bottomAnchor.constraint(equalTo: authorNameLabel.topAnchor),
            bookNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            bookNameLabel.trailingAnchor.constraint(equalTo: ratingLabel.leadingAnchor),
            bookNameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            authorNameLabel.topAnchor.constraint(equalTo: bookNameLabel.bottomAnchor),
            authorNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            authorNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            authorNameLabel.trailingAnchor.constraint(equalTo: ratingLabel.leadingAnchor),
            authorNameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: topAnchor),
            ratingLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            ratingLabel.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
}
