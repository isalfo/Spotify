//
//  PlaybackPresenter.swift
//  Spotify
//
//  Created by Gonzalo Alfonso on 09/08/2022.
//

import Foundation
import UIKit
import AVFoundation

protocol PlayerDataSource: AnyObject {
    var songName: String? { get }
    var subtitle: String? { get }
    var imageURL: URL? { get }
}

final class PlaybackPresenter {
    
    static let shared = PlaybackPresenter()
    
    private var track: AudioTrack?
    private var tracks = [AudioTrack]()
    
    var player: AVPlayer?
    var queuePlayer: AVQueuePlayer?
    
    var playerVC: PlayerViewController?
    
    var currentTrack: AudioTrack? {
        if let track = track, tracks.isEmpty {
            return track
        }
        else if let player = self.queuePlayer, !tracks.isEmpty {
            let item = player.currentItem
            let items = player.items()
            guard let index = items.firstIndex(where: { $0 == item }) else { return nil }
            return tracks[index]
        }
        
        return nil
    }
    
    func startPlayback(
        from viewController: UIViewController,
        track: AudioTrack
    ) {
        guard let url = URL(string: track.preview_url ?? "") else { return }
        player = AVPlayer(url: url)
        self.tracks = []
        self.track = track
        let vc = PlayerViewController()
        vc.title = track.name
        vc.dataSource = self
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true) { [weak self] in
            self?.player?.play()
            self?.player?.volume = 0.5
        }
        self.playerVC = vc
    }
    
    func startPlayback(
        from viewController: UIViewController,
        tracks: [AudioTrack]
    ) {
        self.track = nil
        self.tracks = tracks
        
        self.queuePlayer = AVQueuePlayer(
            items: tracks.compactMap({
                guard let url = URL(string: $0.preview_url ?? "") else { return nil }
                return AVPlayerItem(url: url)
            }))
        self.queuePlayer?.volume = 0.5
        self.queuePlayer?.play()
        let vc = PlayerViewController()
        vc.dataSource = self
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
        self.playerVC = vc
    }
}

extension PlaybackPresenter: PlayerDataSource {
    var songName: String? {
        return currentTrack?.name
    }
    
    var subtitle: String? {
        return currentTrack?.artists.first?.name
    }
    
    var imageURL: URL? {
        return URL(string: currentTrack?.album?.images.first?.url ?? "")
    }
}

extension PlaybackPresenter: PlayerViewControllerDelegate {
    func didSlideSlider(_ value: Float) {
        player?.volume = value
    }
    
    func didTapPlayPause() {
        if let player = player {
            if player.timeControlStatus == .playing {
                player.pause()
            }
            else if player.timeControlStatus == .paused {
                player.play()
            }
        } else if let player = queuePlayer {
            if player.timeControlStatus == .playing {
                player.pause()
            }
            else if player.timeControlStatus == .paused {
                player.play()
            }
        }
    }
    
    func didTapBack() {
        playerVC?.refreshUI()
        if tracks.isEmpty {
            player?.pause()
            player?.play()
        }
        else if let firstItem = queuePlayer?.items().first {
            queuePlayer?.pause()
            queuePlayer?.removeAllItems()
            queuePlayer = AVQueuePlayer(items: [firstItem])
            queuePlayer?.play()
            queuePlayer?.volume = 0.5
            
        }
    }
    
    func didTapNext() {
        playerVC?.refreshUI()
        if tracks.isEmpty {
            player?.pause()
        }
        else if let player = queuePlayer {
            player.advanceToNextItem()
        }
    }
    
    
}
