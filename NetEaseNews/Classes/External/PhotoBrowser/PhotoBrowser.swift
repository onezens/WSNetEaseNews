//
//  PhotoBrowser.swift
//  PhotoBrowser
//
//  Created by 成林 on 15/7/29.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit

/**  展示样式  */
enum ShowType{
    
    /**  push展示：网易新闻  */
    case Push
    
    /**  modal展示：可能有需要  */
    case Modal
    
    /**  frame放大模式：单击相册可关闭 */
    case ZoomAndDismissWithSingleTap
    
    /**  frame放大模式：点击按钮可关闭 */
    case ZoomAndDismissWithCancelBtnClick
}


/**  相册类型  */
enum PhotoType{
    
    /**  本地相册  */
    case Local
    
    /**  服务器相册  */
    case Host
}

class PhotoBrowser: UIViewController {
    
    lazy var collectionView: UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: Layout())

    /**  展示样式：请设置  */
    var showType: ShowType!
    
    /**  相册类型：请设置  */
    var photoType: PhotoType!
    
    /**  相册数据  */
    var photoModels: [PhotoModel]!{didSet{collectionView.reloadData()}}
    
    /**  强制关闭一切信息显示: 仅仅针对ZoomAndDismissWithSingleTap模式有效  */
    var hideMsgForZoomAndDismissWithSingleTap: Bool = false
    
    lazy var pagecontrol = UIPageControl()
    
    var page: Int = 0 {didSet{pageControlPageChanged(page)}}
    
    weak var vc: UIViewController!
    
    var isNavBarHidden: Bool!
    var isTabBarHidden: Bool!
    var isStatusBarHidden: Bool!
    
    var showIndex: Int = 0
    
    var dismissBtn,saveBtn: UIButton!
    var isHiddenBar: Bool = false
    
    lazy var photoArchiverArr: [Int] = []

    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    lazy var hud: UILabel = {
        
        let hud = UILabel()
        hud.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        hud.textColor = UIColor.whiteColor()
        hud.alpha = 0
        hud.textAlignment = NSTextAlignment.Center
        hud.layer.cornerRadius = 5
        hud.layer.masksToBounds = true
        return hud
    }()
    
    
    class func showBrowser(imgUrl: String, title: String, desc: String, vc: UIViewController, sourceView: UIImageView) {
        
        let pbVC = PhotoBrowser()
        
        /**  设置相册展示样式  */
        pbVC.showType = .ZoomAndDismissWithCancelBtnClick
        
        /**  设置相册类型  */
        pbVC.photoType = PhotoType.Host
        
        //强制关闭显示一切信息
        pbVC.hideMsgForZoomAndDismissWithSingleTap = true
        
        var models: [PhotoModel] = []
        
        let model = PhotoModel(hostHDImgURL: imgUrl, hostThumbnailImg: UIImage(named: "1"), titleStr: title, descStr: desc, sourceView: sourceView)
        
        models.append(model)
        
        pbVC.photoModels = models
        
        pbVC.show(inVC: vc, index: 0)
        
    }
}
