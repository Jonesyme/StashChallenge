//
//  AchieveListView.swift
//  Stash
//
//  Created by Mike Jones on 11/26/18.
//  Copyright © 2018 Mike Jones. All rights reserved.
//

import Foundation
import UIKit

class AchieveListView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: AchieveListViewToPresenterProtocol?
    var achievementList: [AchievementModel] = []
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.updateAchieveListView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension AchieveListView: AchieveListPresenterToViewProtocol {
    
    func displayAchievementList(title: String?, achievements: [AchievementModel]) {
        self.title = title
        achievementList = achievements
        tableView.reloadData()
    }
    
    func displayErrorRetry() {
        let alert = UIAlertController(title: "Alert", message: "Unable to fetch Achievement List", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Retry",  style: .default, handler: { [weak self] sender in
            self?.presenter?.updateAchieveListView()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func displayImageForTableCell(atIndexPath indexPath: IndexPath, image: UIImage) {
        guard let cell = self.tableView.cellForRow(at: indexPath) as? AchieveListCellView else {
            return
        }
        cell.updateBackgroundImage(image: image)
    }
}

extension AchieveListView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AchieveListCellView", for: indexPath) as? AchieveListCellView else {
            return UITableViewCell()
        }
        
        let achievement = achievementList[indexPath.row]
        cell.set(forAchievement: achievement)
        
        if let imageUrl = achievement.bgImageUrl {
            self.presenter?.updateImageForTableCell(atIndexPath: indexPath, imageURL: imageUrl)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return achievementList.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
}
