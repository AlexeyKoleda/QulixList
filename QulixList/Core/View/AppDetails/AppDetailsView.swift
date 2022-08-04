//
//  AppDetailsView.swift
//  QulixList
//
//  Created by Alexey Koleda on 03.08.2022.
//

import UIKit

class AppDetailsView: UIView {

    var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    var headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    var imageViewActivityIndicator: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.color = .white
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }()

    var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
        nameLabel.numberOfLines = 2
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()

    var genresLabel: UILabel = {
        let genresLabel = UILabel()
        genresLabel.textColor = UIColor.theme.additionalTextColor
        genresLabel.numberOfLines = 0
        genresLabel.textAlignment = .center
        genresLabel.translatesAutoresizingMaskIntoConstraints = false
        return genresLabel
    }()

    var releaseLabel: UILabel = {
        let releaseLabel = UILabel()
        releaseLabel.textColor = UIColor.theme.additionalTextColor
        releaseLabel.numberOfLines = 1
        releaseLabel.textAlignment = .center
        releaseLabel.translatesAutoresizingMaskIntoConstraints = false
        return releaseLabel
    }()

    var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        priceLabel.textColor = UIColor.theme.discountPriceColor
        priceLabel.numberOfLines = 1
        priceLabel.textAlignment = .center
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        return priceLabel
    }()

    var discontLabel: UILabel = {
        let discontLabel = UILabel()
        discontLabel.textColor = UIColor.theme.discountPriceColor
        discontLabel.numberOfLines = 1
        discontLabel.textAlignment = .center
        discontLabel.translatesAutoresizingMaskIntoConstraints = false
        return discontLabel
    }()
    
    var horizontalLine: UIView = {
        let horizontalLine = UIView()
        horizontalLine.backgroundColor = UIColor.theme.additionalTextColor
        horizontalLine.translatesAutoresizingMaskIntoConstraints = false
        return horizontalLine
    }()

    var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = UIColor.theme.additionalTextColor
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()

    private var errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.textColor = .white
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        return errorLabel
    }()
    
    lazy var  additionalInfoContainer: UIStackView =
        .makeStackView([releaseLabel, priceLabel], spacing: 5, axis: .horizontal)

    override init(frame: CGRect) {
        super.init(frame: frame)
        startSettings()
    }

    convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        startSettings()
    }

    func setupView(with dataStatus: DataStatus) {
        switch dataStatus {
        case .success: setupSeccessView()
        case .empty: setupEmptyView()
        case .error: setupErrorView()
        }
    }

    private func setupSeccessView() {
        setupContentView()
        setupHeaderImageView()
        setupGameNameContainer()
        setupGenresLabel()
        setupAdditionalInfoContainer()
        setupHorizontalLine()
        setupDescriptionLabel()
    }

    private func setupEmptyView() {
        setupErrorLabel(text: "Oops... No data here")
    }

    private func setupErrorView() {
        setupErrorLabel(text: "Oops... Something went wrong")
    }

    private func startSettings() {
        self.setGradientBackground(from: UIColor.theme.lightBackgroundColor, to: UIColor.theme.darkBackgroundColor)
    }

    private func setupContentView() {
        addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }

    private func setupHeaderImageView() {
        contentView.addSubview(headerImageView)
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5)
        ])

        headerImageView.addSubview(imageViewActivityIndicator)
        NSLayoutConstraint.activate([
            imageViewActivityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageViewActivityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func setupGameNameContainer() {
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: headerImageView.bottomAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2)
        ])
    }

    private func setupGenresLabel() {
        contentView.addSubview(genresLabel)
        NSLayoutConstraint.activate([
            genresLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            genresLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            genresLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            genresLabel.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2)
        ])
    }

    private func setupAdditionalInfoContainer() {
        contentView.addSubview(additionalInfoContainer)
        NSLayoutConstraint.activate([
            additionalInfoContainer.topAnchor.constraint(equalTo: genresLabel.bottomAnchor),
            additionalInfoContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            additionalInfoContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            additionalInfoContainer.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2)
        ])

        nameLabel.addSubview(discontLabel)
        NSLayoutConstraint.activate([
            discontLabel.topAnchor.constraint(equalTo: additionalInfoContainer.bottomAnchor, constant: 10),
            discontLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            discontLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }

    private func setupHorizontalLine() {
        contentView.addSubview(horizontalLine)
        NSLayoutConstraint.activate([
            horizontalLine.topAnchor.constraint(equalTo: additionalInfoContainer.bottomAnchor, constant: 30),
            horizontalLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            horizontalLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            horizontalLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    private func setupDescriptionLabel() {
        contentView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: horizontalLine.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }

    private func setupErrorLabel(text: String) {
        addSubview(errorLabel)
        errorLabel.text = text
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

extension UIStackView {
    /// Helper to simplify creating stackViews
    static func makeStackView(
        _ views: [UIView],
        spacing: CGFloat,
        axis: NSLayoutConstraint.Axis = .vertical,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fillEqually
    ) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.spacing = spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
}
