# AdvertCarouselView  广告无限轮播图 Swift版
* 纯Swift广告轮播图
* /// AdvertCarouselView文件夹下
* JOAdvertCarouselAction
* JOPageControl.swift
* JOAdvertCarouselView.swift
* JOAdvertCarouselAction.swift
* JOAdvertCollectionViewCell.swift
* 使用方法: 
* 实现代理AdverCarouselProtocol 进行图片展示和广告点击回调
* 代理advertCarouselView(_:mediaImageView:cellIndex:) 将展示图片传出, 只要为mediaImageView赋值相应的image就可以展示广告图片, 这样做可以更自由的选择image加载和缓存方案
* 调用startRun(time:) \ stopRun 开启或关闭自动播放 
