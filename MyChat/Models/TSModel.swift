
import Foundation
import UIKit

enum GenderType: Int {
    case female = 0, male
}


/* 消息内容类型:
0 - 文本
1 - 图片
2 - 语音
3 - 群组提示信息，例如:A 邀请 B,C 加入群聊
4 - 文件
110 - 时间（客户端生成数据）
*/
enum MessageContentType: Int,Codable {
    case Text
    case Image
    case Voice
    case System
    case File
    case Time
}


//服务器返回的是字符串
enum MessageFromType: Int,Codable {
    //消息来源类型
    case System    // 0是系统
    case Personal    // 1是个人
    case Group   // 2是群组
    case PublicServer   // 服务号
    case PublicSubscribe    //订阅号
    
    //消息类型对应的占位图
    var placeHolderImage: UIImage {
        switch (self) {
        case .Personal:
            return TSAsset.Icon_avatar.image
        case .System, .Group, .PublicServer, .PublicSubscribe:
            return TSAsset.Icon_avatar.image
        }
    }
}

//发送消息的状态
enum MessageSendSuccessType: Int,Codable {
    case success = 0    //消息发送成功
    case failed     //消息发送失败
    case sending    //消息正在发送
}



