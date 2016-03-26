//
//  AdvertCarouselView.swift
//  AdvertCarouselDemo
//
//  Created by django on 16/3/24.
//  Copyright © 2016年 django. All rights reserved.
//




import UIKit

@objc protocol AdverCarouselProtocol : class {
    // 图片代理
    optional func advertCarouselView(adverView: AdvertCarouselView, mediaImageView imageView: UIImageView, cellIndex index: Int)
    // 广告点击代理
    optional func advertCarouselView(adverView: AdvertCarouselView, didSelectItemAtIndex index: Int)
}

/// AdvertCarouselView.swift
/// AdvertCarouselAction.swift
/// AdvertCollectionViewCell.swift
/// 使用方法: 
/// 实现代理AdverCarouselProtocol 进行图片展示和广告点击回调
/// 代理advertCarouselView(_:mediaImageView:cellIndex:) 将展示图片传出, 只要为mediaImageView赋值相应的image就可以展示广告图片, 这样做可以更自由的选择image加载和缓存方案
/// 调用startRun(time:) 或 stopRun 开启 或关闭 自动轮播
class AdvertCarouselView: UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    // 代理
    weak internal var delegate : AdverCarouselProtocol?
    // 广告个数
    private var itemCount : Int = 0
    internal var adverCount : Int = 0 {
        didSet{
            itemCount = adverCount > 1 ? adverCount + 2 : adverCount
            collectionView.reloadData()
            if itemCount != adverCount {
                collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: 1, inSection: 0), atScrollPosition: .CenteredHorizontally, animated: true)
            }
        }
    }
    // 展示图
    private let _collectionView : UICollectionView
    internal var collectionView : UICollectionView {
        get {
            return _collectionView
        }
    }

    override init(frame: CGRect) {
        
        let flowLayout                     = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing      = 0
        flowLayout.scrollDirection         = .Horizontal
        _collectionView                     = UICollectionView(frame: CGRectMake(0, 0, frame.size.width, frame.size.height), collectionViewLayout: flowLayout)
        
        super.init(frame: frame)
        self.loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = self.bounds
    }
    
    // 变量进一步赋值
    private func loadView() {
        self.backgroundColor                          = UIColor.whiteColor()
        collectionView.backgroundColor                = UIColor.whiteColor()
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.pagingEnabled                  = true;
        collectionView.bounces                        = true;
        collectionView.dataSource                     = self;
        collectionView.delegate                       = self;
        collectionView.registerClass(AdvertCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.addSubview(collectionView)
    }
    
    //TODO: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return collectionView.frame.size
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = "cell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath)
        return cell
    }
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        if let tempProtocol = delegate {
            if let method = tempProtocol.advertCarouselView(_:mediaImageView:cellIndex:) {
                var index : Int = indexPath.item
                
                if adverCount != itemCount {
                    if indexPath.item == 0 {
                        index = adverCount - 1
                    } else if indexPath.item == itemCount - 1 {
                        index = 0
                    } else {
                        index = indexPath.item - 1
                    }
                }
                
                let imageView = (cell as! AdvertCollectionViewCell).advertImage
                method(self, mediaImageView: imageView, cellIndex: index)
            }
        }
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
      
        if let tempProtocol = delegate {
            if let method = tempProtocol.advertCarouselView(_:didSelectItemAtIndex:) {
                var index : Int = indexPath.item
                
                if adverCount != itemCount {
                    if indexPath.item == 0 {
                        index = adverCount - 1
                    } else if indexPath.item == itemCount - 1 {
                        index = 0
                    } else {
                        index = indexPath.item - 1
                    }
                }
                
                method(self, didSelectItemAtIndex: index)
            }
        }
    }
}