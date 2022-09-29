//
//  PlayerViewController.swift
//  Spotify
//
//  Created by Gonzalo Alfonso on 15/07/2022.
//

import UIKit
import SDWebImage

protocol PlayerViewControllerDelegate: AnyObject {
    func didTapPlayPause()
    func didTapBack()
    func didTapNext()
    func didSlideSlider(_ value: Float)
}

class PlayerViewController: UIViewController {
    
    weak var dataSource: PlayerDataSource?
    weak var delegate: PlayerViewControllerDelegate?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemBlue
        return imageView
    }()
    
    private let controlsView = PlayersControlView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(controlsView)
        configureBarButtons()
        controlsView.delegate = self
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: view.width,
            height: view.width
        )
        controlsView.frame = CGRect(
            x: 10,
            y: imageView.bottom+10,
            width: view.width-20,
            height: view.height-imageView.height-view.safeAreaInsets.top-view.safeAreaInsets.bottom-15
        )
    }
    
    func refreshUI() {
        configure()
    }
    
    private func configure() {
        imageView.sd_setImage(with: dataSource?.imageURL, completed: nil)
        controlsView.configure(with: PlayersControlViewViewModel(
            title: dataSource?.songName,
            subtitle: dataSource?.subtitle
        ))
    }
    
    private func configureBarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapAction))
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapAction() {
        
    }
}

extension PlayerViewController: PlayerControlViewDelegate {
    func playerControlView(_ playerControlView: PlayersControlView, didSlideSlider value: Float) {
        delegate?.didSlideSlider(value)
    }
    
    
    func playerControlViewDidTapPlayPauseButton(_ playerControlView: PlayersControlView) {
        delegate?.didTapPlayPause()
    }
    
    func playerControlViewDidTapBackButton(_ playerControlView: PlayersControlView) {
        delegate?.didTapBack()
    }
    
    func playerControlViewDidTapNextButton(_ playerControlView: PlayersControlView) {
        delegate?.didTapNext()
    }
}
