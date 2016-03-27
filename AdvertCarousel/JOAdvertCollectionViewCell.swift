//
//  AdvertCollectionViewCell.swift
//  AdvertCarouselDemo
//
//  Created by django on 16/3/25.
//  Copyright © 2016年 django. All rights reserved.
//

import UIKit

class JOAdvertCollectionViewCell: UICollectionViewCell {
    
    private var _advertImage : UIImageView
    internal var advertImage : UIImageView! {
        get {
            return _advertImage
        }
    }

    internal var adverMediaAction: ((mediaImageView: UIImageView) -> Void)?
    
    override init(frame: CGRect) {
        _advertImage = UIImageView()
        super.init(frame: frame)
        self.loadView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // TODO:
    private func loadView() {
        _advertImage.clipsToBounds = true
        _advertImage.frame = self.bounds
        _advertImage.backgroundColor = UIColor.whiteColor()
        self.addSubview(_advertImage)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        _advertImage.frame = self.bounds
    }
}
