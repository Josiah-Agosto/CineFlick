//
//  DetailViewController.swift
//  CineFlick
//
//  Created by Josiah Agosto on 2/21/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController, InnerSelectedIdProtocol {
    // References
    public lazy var detailView = DetailView()
    public lazy var detailManager = DetailNetworkManager.shared
    public lazy var apiManager = APINetworkManager.shared
    public lazy var homeController = HomeScreenController()
    public lazy var internetNetwork = InternetNetwork()
    public lazy var personController = PersonController()
    private lazy var slideMenu = SlideMenuHelper()
    private lazy var videoWebController = VideoWebController()
    private let group = DispatchGroup()
    // Movie Detail Variables
    var movieOverview: String = ""
    var movieReleaseData: String = ""
    // Movie Id Delegate Property
    var movieId: String = ""
    var movieName: String = ""
    var selectedBackdropUrl: String = ""
    // Video Thumbnail Properties
    private var videoKeys: [String] = []
    // Delegate
    public weak var videoPropertyViewDelegate: VideoPropertyViewProtocol?
    public weak var videoWebUrlDelegate: VideoWebDataProtocol?
    // MARK: - Lifecycle
    override func loadView() {
        view = detailView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        internetNetwork.checkForInternetConnectivity()
        setup()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        detailView.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        viewAppearedSetup()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setAsynchronousImage()
        detailView.scrollView.contentSize = videoPropertyViewDelegate!.movieHasVideo ? CGSize(width: UIScreen.main.bounds.width, height: detailView.videoCollectionView.frame.origin.y + 220) : CGSize(width: UIScreen.main.bounds.width, height: detailView.castCollectionView.frame.origin.y + 175)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        resetManagerData()
        resetLocalData()
    }
    
    
    private func setup() {
        self.videoPropertyViewDelegate = detailView
        addMovieTitleToNavigationTitle()
    }
    
    
    private func addMovieTitleToNavigationTitle() {
        title = movieName
        // Title Color
        navigationController?.navigationBar.tintColor = UIColor(named: "LabelColors")
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(named: "LabelColors")!]
        let doneButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonAction))
        navigationItem.backBarButtonItem = doneButtonItem
    }
    
    
    private func viewAppearedSetup() {
        fetchCastRequest()
        videoRequest()
        getRuntimeRequest()
    }
    
    
    private func videoRequest() {
        detailManager.getVideos(with: movieId) { (result) in
            switch result {
            case .success():
                for key in self.detailManager.videoKey {
                    self.videoKeys.append(key)
                    print(key)
                }
                self.videoLogic()
                DispatchQueue.main.async {
                    self.detailView.videoCollectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    private func videoLogic() {
        if detailManager.videos != 0 {
            getVideoThumbnails()
            addVideoProperties()
            videoPropertyViewDelegate?.movieHasVideo = true
        } else {
            removeVideoProperties()
            videoPropertyViewDelegate?.movieHasVideo = false
        }
    }
    
    
    private func addVideoProperties() {
        DispatchQueue.main.async {
            self.detailView.videoPlaceholder.isHidden = false
            self.detailView.videoCollectionView.isHidden = false
        }
    }
    
    
    private func removeVideoProperties() {
        DispatchQueue.main.async {
            self.detailView.videoPlaceholder.isHidden = true
            self.detailView.videoCollectionView.isHidden = true
        }
    }
    
    
    private func getVideoThumbnails() {
        for key in videoKeys {
            detailManager.requestThumbnailUrls(with: key)
        }
    }
    
    // MARK: - Delegate Functions
    private func fetchCastRequest() {
        detailManager.detailCast(movieId) { (result) in
            switch result {
            case .success():
                DispatchQueue.main.async {
                    self.detailView.castCollectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // Runtime Delegate Function
    private func getRuntimeRequest() {
        apiManager.getRuntime(with: movieId) { (valueForId) in
            self.detailView.runtime.text = valueForId
        }
    }
    
    
    private func resetLocalData() {
        movieName = ""
        movieId = ""
        movieOverview = ""
        movieReleaseData = ""
        selectedBackdropUrl = ""
        videoKeys = []
        detailManager.castPropertiesDelegate?.charName = []
        detailManager.castPropertiesDelegate?.name = []
        detailManager.castPropertiesDelegate?.castCountForSection = 0
    }
    
    
    private func resetManagerData() {
        detailManager.deleteAllSavedData()
    }
    

    private func setAsynchronousImage() {
        detailView.backdropImage.asynchronouslyLoadImage(with: selectedBackdropUrl)
    }
    
    // MARK: - Actions
    @objc private func doneButtonAction() {
        navigationController?.popToRootViewController(animated: true)
    }
    
}


// MARK: - Person Delegate
extension DetailViewController: PersonSelectionProtocol {
    func hasSelectedCell() {
        let personNavigationController = UINavigationController(rootViewController: personController)
        if #available(iOS 13.0, *) {
            personNavigationController.isModalInPresentation = true
        } else {
        }
        slideMenu.appDelegate?.navigationController?.present(personNavigationController, animated: true, completion: nil)
    }
}


// MARK: - Video Delegate
extension DetailViewController: SelectedVideoProtocol {
    func selectedVideo(_ key: String, _ videoCell: VideoCollectionViewCell) {
        self.videoWebUrlDelegate = videoWebController
        var fullPath: String = ""
        for site in detailManager.videoSite {
            if site == "YouTube" {
                videoCell.siteProvider = .youtube
                fullPath = "\(videoCell.siteProvider.rawValue)\(key)"
            } else {
                videoCell.siteProvider = .vimeo
                fullPath = "\(videoCell.siteProvider.rawValue)\(key)"
            }
        }
        videoWebUrlDelegate?.webUrl = fullPath
        slideMenu.appDelegate?.navigationController?.pushViewController(videoWebController, animated: true)
    }
}
