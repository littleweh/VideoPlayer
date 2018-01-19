//
//  VideoPlayerViewController.swift
//  VideoPlayerKVO
//
//  Created by 典萱 高 on 2018/1/19.
//  Copyright © 2018年 LostRfounds. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    var videoPlayerContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // searchbar

    // button and container view

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(videoPlayerContainerView)

    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupVideoPlayerContainerView()

    }

    func playVideoWith(url: String) {
        guard
            let videoURL = URL(string: url)
        else {
            // ToDo: send alert to user and re enter url
            return
        }

        let player = AVPlayer(url: videoURL)
        let layer = AVPlayerLayer(player: player)
        layer.frame = videoPlayerContainerView.bounds
        layer.videoGravity = AVLayerVideoGravity.resizeAspect
        videoPlayerContainerView.layer.addSublayer(layer)
        player.play()
    }

    func setupVideoPlayerContainerView() {
        // autolayout
        self.videoPlayerContainerView.frame = CGRect(
            x: 0,
            y: 0,
            width: self.view.frame.width,
            height: self.view.frame.height
        )

        NSLayoutConstraint.activate([
            videoPlayerContainerView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor)
        ])

    }

    deinit {
        print("VideoPlayerViewController deinit")
    }

}
