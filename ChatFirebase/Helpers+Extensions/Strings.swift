//
//  Strings.swift
//  ChatFirebase
//
//  Created by Mitya Kim on 6/21/22.
//

import Foundation

struct Strings {
    static let appName = "🤳Let's Chat"
    static let registerSegue = "registerSegue"
    static let loginSegue = "loginSegue"
    static let cellIdentifier = "chatCell"
    static let cellNibName = "MessageTableViewCell"
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dataField = "date"
    }
}
