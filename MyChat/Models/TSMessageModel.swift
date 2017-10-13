
import Foundation


struct MessageModel: Codable {
    var middleImageURL : String?
    var unreadNumber : Int?
    var nickname : String?
  //  var messageFromType : MessageFromType = MessageFromType.Personal
  //  var messageContentType : MessageContentType = MessageContentType.Text
    var chatId : String?  //每个人，群，公众帐号都有一个 uid，统一叫 chatId
    var latestMessage : String? //当且仅当消息类型为 Text 的时候，才有数据，其他类型需要本地造
    var dateString: String?

}

