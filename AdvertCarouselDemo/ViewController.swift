//
//  ViewController.swift
//  AdvertCarouselDemo
//
//  Created by django on 16/3/24.
//  Copyright © 2016年 django. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var images : [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let adview = AdvertCarouselView(frame: UIScreen.mainScreen().bounds)
        adview.delegate = self
        self.view .addSubview(adview)
        
        images = ["http://c.hiphotos.baidu.com/zhidao/pic/item/71cf3bc79f3df8dc0bc3589bcb11728b4710283a.jpg",
                  "http://img1.dzwww.com:8080/tupian_pl/20150818/75/6824462976615371047.jpg",
                  "http://pic1.5442.com/2013/0518/04/05.jpg",
                  "http://img4q.duitang.com/uploads/item/201207/20/20120720190413_h5riQ.jpeg"]
        adview.adverCount = (images?.count)!
        adview.startRun(time: 3.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController : AdverCarouselProtocol {
    func advertCarouselView(adverView: AdvertCarouselView, mediaImageView imageView: UIImageView, cellIndex index: Int) {
        imageView.contentMode = .ScaleAspectFit
   
        imageView.yy_setImageWithURL(NSURL(string: images![index]), options: .SetImageWithFadeAnimation)
    }
    func advertCarouselView(adverView: AdvertCarouselView, didSelectItemAtIndex index: Int) {
        UIAlertView(title: "\(index)", message: "想干嘛?", delegate: nil, cancelButtonTitle: "不想").show()
    }
}
