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
    var buttonContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var playbackButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.setTitle(
            NSLocalizedString(
                "Play",
                comment: "Play/pause button"
            ),
            for: .normal
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var audioControlButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.setTitle(
            NSLocalizedString(
                "Mute",
                comment: "Mute/Unmute button"
            ),
            for: .normal
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(videoPlayerContainerView)
        self.view.addSubview(buttonContainerView)
        self.buttonContainerView.addSubview(playbackButton)
        self.buttonContainerView.addSubview(audioControlButton)

    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupVideoPlayerContainerView()
        setupButtonContainerView()
        setupPlaybackButton()
        setupAudioControlButton()


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

    func setupButtonContainerView() {
        buttonContainerView.backgroundColor = .red
        NSLayoutConstraint.activate([
            buttonContainerView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor),
            buttonContainerView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            buttonContainerView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            buttonContainerView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }


    func setupPlaybackButton() {
        
    }

    func setupAudioControlButton() {

    }

    deinit {
        print("VideoPlayerViewController deinit")
    }

}
