//
//  AchieveListCellView.swift
//  Stash
//
//  Created by Mike Jones on 11/26/18.
//  Copyright © 2018 Mike Jones. All rights reserved.
//

import UIKit

class AchieveListCellView: UITableViewCell {

    @IBOutlet weak var bgShadowView: UIView! {
        // superfluous view to add a shadow
        didSet(param) {
            bgShadowView.layer.shadowColor = UIColor.black.cgColor
            bgShadowView.layer.shadowOpacity = 0.33
            bgShadowView.layer.shadowRadius = 8.0
            bgShadowView.layer.cornerRadius = 10.0
            bgShadowView.layer.masksToBounds = false
        }
    }
    @IBOutlet weak var bgImageView: UIImageView! {
        didSet(param) {
            bgImageView.layer.cornerRadius = 10.0
            bgImageView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var progressView: UIProgressView! {
        didSet(param) {
            progressView.transform = progressView.transform.scaledBy(x: 1, y: 4)
            progressView.progressImage = UIImage(named:"progressImage")?.stretchableImage(withLeftCapWidth: 4, topCapHeight: 0)
            progressView.layer.cornerRadius = 8.0
        }
    }
    @IBOutlet weak var circleImageView: UIImageView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var totalMinLabel: UILabel!
    @IBOutlet weak var totalMaxLabel: UILabel!
    
    override func prepareForReuse() {
        bgImageView.image = UIImage(named: "placeholder")
    }
    
    func set(forAchievement achievement: AchievementModel) {
        self.selectionStyle = .none
        
        levelLabel.text = achievement.level
        totalMinLabel.text = AchieveListPresenter.formatPoints(value: achievement.progress)
        totalMaxLabel.text = AchieveListPresenter.formatPoints(value: achievement.total)
        
        let progressValue:Float = AchieveListPresenter.calcProgressBarValue(progressValue: achievement.progress, totalValue: achievement.total)
        progressView.setProgress(progressValue, animated: true)
        
        bgImageView.alpha = AchieveListPresenter.calcBackgroundImageAlpha(accessibleValue: achievement.accessible)
    }
    
    func updateBackgroundImage(image: UIImage) {
        bgImageView.image = image
    }
}
