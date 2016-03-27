//
//  JOPageControl.swift
//  PageDemo
//
//  Created by Djangolee on 16/3/27.
//  Copyright © 2016年 Djangolee. All rights reserved.
//

import UIKit

class JOPageControl: UIView {

    private var pageLayers : [CALayer] = [CALayer]()
    private var oldcenter : CGPoint?
    
    
    internal var controlHeight : CGFloat = 20.0 {
        didSet {
            sortColorSize()
        }
    }
    // 选中page半径
    internal var selectPageRadius : CGFloat = 2.5 {
        didSet {
            sortColorSize()
        }
    }
    // 未选中page半径
    internal var radius : CGFloat = 2.0 {
        didSet {
            sortColorSize()
        }
    }
    // 未选中page颜色
    internal var pageColor : CGColor =  UIColor ( red: 0.8, green: 0.8, blue: 0.8, alpha: 0.6 ).CGColor{
        didSet {
            sortColorSize()
        }
    }
    // 选中page颜色
    internal var selectColor : CGColor = UIColor ( red: 1.0, green: 0.4, blue: 0.4, alpha: 1.0 ).CGColor{
        didSet {
            sortColorSize()
        }
    }
    // page个数
    internal var pageCount : Int = 0 {
        didSet {
            if pageCount <= 0 {
                for page in pageLayers {
                    page.removeFromSuperlayer()
                }
                pageLayers.removeAll()
                selectIndex = 0
                return
            }
            self.addTagLayer()
            self.sortColorSize()
        }
    }
    // 选中第几个
    internal var selectIndex : Int = 0 {
        didSet {
            guard selectIndex < pageLayers.count && oldValue < pageLayers.count else { return }

            let page                = pageLayers[selectIndex]
            let oldpage             = pageLayers[oldValue]

            let position            = page.position
            let oldposition         = oldpage.position

            oldpage.bounds.size     = CGSizeMake(radius * 2, radius * 2)
            oldpage.cornerRadius    = radius
            oldpage.backgroundColor = pageColor
            oldpage.position        = oldposition

            page.bounds.size        = CGSizeMake(selectPageRadius * 2, selectPageRadius * 2)
            page.cornerRadius       = selectPageRadius
            page.backgroundColor    = selectColor
            page.position           = position
        }
    }

    /**
     初始化 增加和减少page
     */
    func addTagLayer() {
        
        // 剔除多余
        while pageLayers.count > pageCount {
            pageLayers.last?.removeFromSuperlayer()
            pageLayers.removeLast()
        }
        // 增加
        while pageLayers.count < pageCount {
            let page             = CALayer()
            pageLayers.append(page)
            self.layer.addSublayer(page)
        }
    }
    
    /**
     排序 大小 颜色
     */
    func sortColorSize() {
        
        self.frame.size = CGSizeMake(controlHeight * CGFloat(pageLayers.count), controlHeight)
        self.center     = oldcenter!
        // 排列
        for page in pageLayers {
            let index            = CGFloat(pageLayers.indexOf(page)!)
            page.bounds.size     = CGSizeMake(radius * 2, radius * 2)
            page.cornerRadius    = radius
            page.backgroundColor = pageColor
            page.position        = CGPointMake(controlHeight * (0.5 + index), controlHeight * 0.5)
            
        }
        // 选中页面
        selectIndex = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        oldcenter = CGPointMake(frame.minX, frame.minY)
    }
    override var frame: CGRect {
        didSet {
            super.center = CGPointMake(frame.midX, frame.midY)
            oldcenter    = super.center
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
