//
//  TSUploadModel.swift
//  TSWeChat
//
//  Created by Hilen on 3/2/16.
//  Copyright © 2016 Hilen. All rights reserved.
//

import Foundation


// 上传图片接口返回的图片 Model
struct UploadImageModel: Codable {
    var originalURL: String?
    var originalHeight: Float?
    var originalWidth: Float?
    var thumbURL: String?
    var thumbHeight: Float?
    var thumbWidth: Float?
    var imageId: Int?


    enum CodingKeys: String, CodingKey {
        case originalURL = "original_URL"
        case originalHeight = "original_height"
        case originalWidth = "original_width"
        case imageId = "image_Id"
        case thumbURL = "thumb_URL"
        case thumbHeight = "thumb_height"
        case thumbWidth = "thumb_width"
    }
}


// 上传音频接口返回的图片 Model
struct UploadAudioModel: Codable {
    var audioId: String?
    var duration: Int?
    var audioURL: String?
    var fileSize: Int?
    var keyHash: String?
    var recordTime: String?



    enum CodingKeys: String, CodingKey {
        case audioId = "audio_id"
        case audioURL = "audio_url"
        case duration = "duration"
        case keyHash = "key_hash"
        case fileSize = "file_size"
        case recordTime = "recordTime"
    }
}
