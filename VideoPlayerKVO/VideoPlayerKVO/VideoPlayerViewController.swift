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

    var playbackButtonTitle = NSLocalizedString("Pause", comment: "")

    var playbackButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.sizeToFit()
        button.addTarget(
            self,
            action: #selector(playbackButtonTapped),
            for: .touchUpInside
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
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.sizeToFit()

        button.addTarget(
            self,
            action: #selector(audioControlButtonTapped),
            for: .touchUpInside
        )

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    @objc var videoPlayer = AVPlayer()

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

        self.videoPlayer = AVPlayer(url: videoURL)
        self.videoPlayer.addObserver(
            self,
            forKeyPath: "rate",
            options: .new,
            context: nil
        )
        let layer = AVPlayerLayer(player: self.videoPlayer)
        layer.frame = videoPlayerContainerView.bounds
        layer.videoGravity = AVLayerVideoGravity.resizeAspect
        videoPlayerContainerView.layer.addSublayer(layer)
        self.videoPlayer.play()
        self.playbackButton.setTitle(playbackButtonTitle, for: .normal)

    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "rate" {
            if self.videoPlayer.rate == 1.0 {

            } else if self.videoPlayer.rate == 0.0 {

            } else {

            }
        }
    }

    @objc func playbackButtonTapped() {
        if self.videoPlayer.rate == 0.0 {
            self.videoPlayer.play()
            print("play")
        } else if self.videoPlayer.rate == 1.0 {
            self.videoPlayer.pause()
            print("pause")
        } else {
            print("unknown")
        }

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

        playVideoWith(url: "http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8")

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
        NSLayoutConstraint.activate([
            playbackButton.leftAnchor.constraint(equalTo: buttonContainerView.leftAnchor, constant: 20),
            playbackButton.centerYAnchor.constraint(equalTo: buttonContainerView.centerYAnchor),
            playbackButton.heightAnchor.constraint(equalToConstant: 19),
            playbackButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 33)
        ])
    }

    func setupAudioControlButton() {
        NSLayoutConstraint.activate([
            audioControlButton.rightAnchor.constraint(equalTo: buttonContainerView.rightAnchor, constant: -16),
            audioControlButton.centerYAnchor.constraint(equalTo: buttonContainerView.centerYAnchor),
            audioControlButton.heightAnchor.constraint(equalToConstant: 19),
            audioControlButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 39)
        ])
    }

    @objc func audioControlButtonTapped() {
        if audioControlButton.currentTitle == NSLocalizedString("Mute", comment: "audioControlButton") {
            audioControlButton.setTitle(
                NSLocalizedString("Unmute", comment: "audioControlButton"),
                for: .normal
            )
            self.videoPlayer.isMuted = true
        } else {
            audioControlButton.setTitle(
                NSLocalizedString("Mute", comment: "audioControlButton"),
                for: .normal
            )
            self.videoPlayer.isMuted = false
        }

    }

    deinit {
        self.videoPlayer.removeObserver(self, forKeyPath: "rate")
        print("VideoPlayerViewController deinit")
    }

}
