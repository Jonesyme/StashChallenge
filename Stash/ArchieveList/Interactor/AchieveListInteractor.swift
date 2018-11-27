//
//  AchieveListInteractor.swift
//  Stash
//
//  Created by Mike Jones on 11/26/18.
//  Copyright © 2018 Mike Jones. All rights reserved.
//

import Foundation
import UIKit

class AchieveListInterector: AchieveListPresentorToInterectorProtocol{
    
    weak var presenter: AchieveListInterectorToPresenterProtocol?
    
    // use local file as outlined in challenge readme
    var achievementsSourceURL: URL? {
        let bundle = Bundle(for: type(of: self))
        let mockJSON = bundle.url(forResource: "achievements", withExtension: "json")
        guard let url = mockJSON else {
            return nil
        }
        return url
    }
    // ideally, this should reside in a separate storage controller but in the interest of time... I apologize to viper purists, I'm sorry.
    var imageCache = NSCache<NSNumber, UIImage>()
    
    // MARK: - Async fetch achievement list
    func fetchAchievements() {
        
        guard let url = achievementsSourceURL else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let wrapper = try decoder.decode(AchievementWrapper.self, from: data) as AchievementWrapper
                DispatchQueue.main.async {
                    self.presenter?.didFetchAchievements(title: wrapper.overview?.title, achievements: wrapper.achievements!)
                }
            } catch {
                DispatchQueue.main.async {
                    self.presenter?.achievementsFetchFailed()
                }
            }
        }.resume()
    }
    
    // MARK: - Async remote image fetch
    func fetchImageForTableCell(atIndexPath indexPath: IndexPath, imageURL: String) {
        
        guard let url = URL(string: imageURL) else { return }
        if let image = imageCache.object(forKey: NSNumber.init(value:indexPath.row)) {
            DispatchQueue.main.async() {
                self.presenter?.didFetchImageForTableCell(atIndexPath: indexPath, image: image)
            }
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                    self.imageCache.setObject(image, forKey: NSNumber.init(value:indexPath.row))
                DispatchQueue.main.async() {
                    self.presenter?.didFetchImageForTableCell(atIndexPath: indexPath, image: image)
                }
            }.resume()
        }
    }
}
