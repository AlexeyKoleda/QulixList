//
//  AppDetailsViewController.swift
//  QulixList
//
//  Created by Alexey Koleda on 03.08.2022.
//

import UIKit

class AppDetailsViewController: UIViewController {

    var appId: String!

    private let customView = AppDetailsView()
    private let viewModel: AppDetailsViewModel
    private var appModel: DetailedAppModel!

    // MARK: initializers
    public init(viewModel: AppDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }


    private func loadData() {
        viewModel.loadAppDetails(appId: appId) { [weak self] appModel in
            self?.appModel = appModel
            DispatchQueue.main.async {
                guard let status = self?.appModel.dataStatus else { return }
                self?.customView.setupView(with: status)
                self?.updateView()
            }
        }
    }

    private func updateView() {
        guard
            appModel.dataStatus == .success,
            let appInfo = appModel.appDetails
        else {
            return
        }
        fillHeaderImage(appInfo: appInfo)
        fillName(appInfo: appInfo)
        fillDescription(appInfo: appInfo)
        fillReleaseDate(appInfo: appInfo)
        fillGenres(appInfo: appInfo)
        fillPrice(appInfo: appInfo)
    }

    private func fillHeaderImage(appInfo: AppDetails) {
        if let url = appInfo.headerImageURLString {
            customView.imageViewActivityIndicator.startAnimating()
            downloadImage(from: url, to: customView.headerImageView)
        } else {
            setDefaultImage()
        }
    }

    private func fillName(appInfo: AppDetails) {
        customView.nameLabel.text = appInfo.name
    }

    private func fillDescription(appInfo: AppDetails) {
        customView.descriptionLabel.text = appInfo.shortDescription
    }

    private func fillReleaseDate(appInfo: AppDetails) {
        if appInfo.isComingSoon {
            customView.releaseLabel.text = "Coming soon"
        } else {
            if let date = appInfo.releaseDate {
                customView.releaseLabel.text = CustomDateFormater.shared.getString(from: date)
            }
        }
    }

    private func fillGenres(appInfo: AppDetails) {
        if let genres = appInfo.genres {
            var genresString = ""
            for genre in genres {
                genresString += "\(genre)    "
            }
            customView.genresLabel.text = genresString
        }
    }

    private func fillPrice(appInfo: AppDetails) {
        if appInfo.isFree {
            customView.priceLabel.text = "Free to play"
        } else {
            customView.priceLabel.text = appInfo.priceTitle
            if let discont = appInfo.discont,
               discont != 0 {
                customView.discontLabel.text = "-\(discont)%"
            }
        }
    }

    private func setDefaultImage() {
        customView.headerImageView.image = UIImage(named: "default_game_image")
    }

    func downloadImage(from url: String, to imageView: UIImageView) {
        let ns = NetworkServiceImplementation()
        ns.downloadImage(url: url) { data in
            DispatchQueue.main.async { [weak self] in
                imageView.image = UIImage(data: data)
                self?.customView.imageViewActivityIndicator.stopAnimating()
            }
        }
    }

}
