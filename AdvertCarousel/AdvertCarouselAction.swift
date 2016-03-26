//
//  AdvertCarouselAction.swift
//  AdvertCarouselDemo
//
//  Created by Djangolee on 16/3/26.
//  Copyright © 2016年 django. All rights reserved.
//

import Foundation

// MARK: - 广告行为逻辑
extension AdvertCarouselView {
    
    // 定时器
    private var timer : NSTimer? {
        get {
            return objc_getAssociatedObject(self, "timer") as? NSTimer
        }
        set {
            objc_setAssociatedObject(self, "timer", newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
 
    /**
     开始滚动广告视图
     
     - parameter second: 隔多少时间滚动一次
     */
    func startRun(time second: NSTimeInterval) {
        
        guard self.adverCount > 1 else { return }
        
        timer?.invalidate()
        timer = NSTimer(timeInterval: second, target: self, selector: #selector(AdvertCarouselView.nextAdvert), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
    }
    /**
     停止滚动
     */
    func stopRun() {
        timer?.invalidate()
        timer = nil
    }
    
    /**
     滚动到下一个广告
     */
    func nextAdvert() {
        
        guard self.adverCount > 1 else { return }
        
        // 触摸 或 滑动
        guard !self.collectionView.tracking || !self.collectionView.dragging else { return }
        guard let indexPath = self.collectionView.indexPathsForVisibleItems().first else { return }
        
        // 只要不是最后一格item就继续往后
        if indexPath.item < self.collectionView.numberOfItemsInSection(indexPath.section) - 1 {
            self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: indexPath.item + 1, inSection: indexPath.section), atScrollPosition: .CenteredHorizontally, animated: true)
        }
    }
    
    // TODO: UIScrollerViewDelegate
    // 滑动ing 手势 代码 有效
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        // cell 有效
        guard (self.collectionView.indexPathsForVisibleItems().last != nil) else { return }
        // 坐标溢出
        guard scrollView.contentOffset.x < 0 || scrollView.contentOffset.x > scrollView.contentSize.width - scrollView.frame.size.width else { return }
        
        if scrollView.contentOffset.x < 0 {
            scrollView.setContentOffset(CGPointMake(scrollView.contentSize.width - 2 * scrollView.frame.size.width, 0), animated: false)
        } else {
            scrollView.setContentOffset(CGPointMake(scrollView.frame.size.width, 0), animated: false)
        }
    }

    // 代码设置有效 滚动停止
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
        guard let indexPath = self.collectionView.indexPathsForVisibleItems().first else { return }
        
        // 只要是最后一个item 就拉到1 个item
        if indexPath.item == self.collectionView.numberOfItemsInSection(indexPath.section) - 1 {
            self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: 1, inSection: indexPath.section), atScrollPosition: .CenteredHorizontally, animated: false)
        }
    }
    // 手势触摸有效 滚动停止
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        guard let indexPath = self.collectionView.indexPathsForVisibleItems().first else { return }
        
        // 只要是最后一个item 就拉到1 个item
        if indexPath.item == self.collectionView.numberOfItemsInSection(indexPath.section) - 1 {
            self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: 1, inSection: indexPath.section), atScrollPosition: .CenteredHorizontally, animated: false)
        }
        // 只要是第零个item 就拉到 倒数第二个item
        if indexPath.item == 0 {
            let count = self.collectionView.numberOfItemsInSection(indexPath.section) - 1
            self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: count - 1, inSection: indexPath.section), atScrollPosition: .CenteredHorizontally, animated: false)
        }
    }
}










