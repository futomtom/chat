//
//  TSChatModel.swift
//  TSWeChat
//
//  Created by Hilen on 12/9/15.
//  Copyright © 2015 Hilen. All rights reserved.
//

import Foundation

import YYText

struct ChatModel: Codable {
    var audioModel : ChatAudioModel? //音频的 Model
    var imageModel : ChatImageModel? //图片的 Model
    var chatSendId : String?    //发送人 ID
    var chatReceiveId : String? //接受人 ID
    var device : String? //设备类型，iPhone，Android
    var messageContent : String?  //消息内容
    var messageId : String?  //消息 ID
    var messageContentType : MessageContentType = .Text //消息内容的类型
    var timestamp : String? //同 publishTimestamp
    var messageFromType : MessageFromType = MessageFromType.Group
    //以下是为了配合 UI 来使用
    var fromMe : Bool { return self.chatSendId == UserInstance.userId }
    var richTextLayout: YYTextLayout?
    var richTextLinePositionModifier: TSYYTextLinePositionModifier?
    var richTextAttributedString: NSMutableAttributedString?
    var messageSendSuccessType: MessageSendSuccessType = .failed //发送消息的状态
    var cellHeight: CGFloat = 0 //计算的高度储存使用，默认0

 
}

extension ChatModel {
    //后一条数据是否比前一条数据 多了 2 分钟以上
    func isLateForTwoMinutes(_ targetModel: ChatModel) -> Bool {
        //11是秒，服务器时间精确到毫秒，做一次判断
        guard self.timestamp!.length > 11 else {
            return false
        }
        
        guard targetModel.timestamp!.length > 11 else {
            return false
        }

        let nextSeconds = Double(self.timestamp!)!/1000
        let previousSeconds = Double(targetModel.timestamp!)!/1000
        return (nextSeconds - previousSeconds) > 120
    }
    
    var timeDate: Date {
        get {
            let seconds = Double(self.timestamp!)!/1000
            let timeInterval: TimeInterval = TimeInterval(seconds)
            return Date(timeIntervalSince1970: timeInterval)
        }
    }
}



// MARK: - 聊天时间的 格式化字符串
extension Date {
    fileprivate var chatTimeString: String {
        get {
            let calendar = Calendar.current
            let now = Date()
            let unit: NSCalendar.Unit = [
                NSCalendar.Unit.minute,
                NSCalendar.Unit.hour,
                NSCalendar.Unit.day,
                NSCalendar.Unit.month,
                NSCalendar.Unit.year,
            ]
            let nowComponents:DateComponents = (calendar as NSCalendar).components(unit, from: now)
            let targetComponents:DateComponents = (calendar as NSCalendar).components(unit, from: self)
            
            let year = nowComponents.year! - targetComponents.year!
            let month = nowComponents.month! - targetComponents.month!
            let day = nowComponents.day! - targetComponents.day!
            
            if year != 0 {
                return String(format: "%zd年%zd月%zd日 %02d:%02d", targetComponents.year!, targetComponents.month!, targetComponents.day!, targetComponents.hour!, targetComponents.minute!)
            } else {
                if (month > 0 || day > 7) {
                    return String(format: "%zd月%zd日 %02d:%02d", targetComponents.month!, targetComponents.day!, targetComponents.hour!, targetComponents.minute!)
                } else if (day > 2) {
                    return String(format: "%@ %02d:%02d",self.week(), targetComponents.hour!, targetComponents.minute!)
                } else if (day == 2) {
                    if targetComponents.hour! < 12 {
                        return String(format: "前天上午 %02d:%02d",targetComponents.hour!, targetComponents.minute!)
                    } else if targetComponents.hour == 12 {
                        return String(format: "前天下午 %02d:%02d",targetComponents.hour!, targetComponents.minute!)
                    } else {
                        return String(format: "前天下午 %02d:%02d",targetComponents.hour! - 12, targetComponents.minute!)
                    }
                } else if (day == 1) {
                    if targetComponents.hour! < 12 {
                        return String(format: "昨天上午 %02d:%02d",targetComponents.hour!, targetComponents.minute!)
                    } else if targetComponents.hour == 12 {
                        return String(format: "昨天下午 %02d:%02d",targetComponents.hour!, targetComponents.minute!)
                    } else {
                        return String(format: "昨天下午 %02d:%02d",targetComponents.hour! - 12, targetComponents.minute!)
                    }
                } else if (day == 0){
                    if targetComponents.hour! < 12 {
                        return String(format: "上午 %02d:%02d",targetComponents.hour!, targetComponents.minute!)
                    } else if targetComponents.hour == 12 {
                        return String(format: "下午 %02d:%02d",targetComponents.hour!, targetComponents.minute!)
                    } else {
                        return String(format: "下午 %02d:%02d",targetComponents.hour! - 12, targetComponents.minute!)
                    }
                } else {
                    return ""
                }
            }
        }
    }
}














