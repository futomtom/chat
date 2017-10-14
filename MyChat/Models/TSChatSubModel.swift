//
//  TSChatModel.swift
//  TSWeChat
//
//  Created by Hilen on 12/9/15.
//  Copyright © 2015 Hilen. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics


/*
* 聊天内的子 model，根据字典返回类型做处理
*/
struct ChatAudioModel : Codable {
    var audioId : String?
    var audioURL : String?
    var bitRate : String?
    var channels : String?
    var createTime : String?
    var duration : Float?
    var fileSize : String?
    var formatName : String?
    var keyHash : String?
    var mimeType : String?

}

/*
* 聊天内的子 model，根据字典返回类型做处理
*/
struct ChatImageModel : Codable {
    var imageHeight : CGFloat?
    var imageWidth : CGFloat?
    var imageId : String?
    var originalURL : String?
    var thumbURL : String?
    var localStoreName: String?  //拍照，选择相机的图片的临时名称
    var localThumbnailImage: UIImage? {  //从 Disk 加载出来的图片
        if let theLocalStoreName = localStoreName {
            let path = ImageFilesManager.cachePathForKey(theLocalStoreName)
            return UIImage(contentsOfFile: path!)
        } else {
            return nil
        }
    }

}






