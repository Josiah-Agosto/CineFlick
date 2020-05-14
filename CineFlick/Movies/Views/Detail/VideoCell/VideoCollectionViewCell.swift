//
//  VideoCollectionViewCell.swift
//  CineFlick
//
//  Created by Josiah Agosto on 5/6/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    // Properties / References
    static let reuseIdentifier = "videoCell"
    public var videoKey: String = ""
    public var siteProvider: VideoSources = .youtube
    // Video View
    public lazy var videoThumbnailView: CustomImageView = {
        let view = CustomImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.image = UIImage(named: "ImageNotFound")
        view.backgroundColor = UIColor.clear
        return view
    }()
    // Video Title
    public lazy var videoTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Not Available"
        label.font = UIFont(name: "AvenirNext-Medium", size: 23)
        label.backgroundColor = UIColor.clear
        return label
    }()
    // Delegate
    public weak var selectedVideoDelegate: SelectedVideoProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        // View
        backgroundColor = UIColor(named: "ContrastColors")
        // Subviews
        addSubview(videoThumbnailView)
        addSubview(videoTitle)
        // Constraints
        constraints()
    }
    
    
    private func constraints() {
        let screen = UIScreen.main.bounds
        // Video Title
        videoTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        videoTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant:  -5).isActive = true
        videoTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        videoTitle.heightAnchor.constraint(equalToConstant: 25).isActive = true
        // Video View
        videoThumbnailView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        videoThumbnailView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        videoThumbnailView.widthAnchor.constraint(equalToConstant: screen.width - 32).isActive = true
        videoThumbnailView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
