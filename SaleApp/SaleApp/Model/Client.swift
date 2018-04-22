//
//  Client.swift
//  SaleApp
//
//  Created by logan on 2018/4/8.
//  Copyright © 2018 Chuanqi. All rights reserved.
//

import UIKit


struct Client: Equatable {
    var name: String?
    var image: String?
    var key: String?
    var id: String?
    var phone: String?
    var address: String?
    
    public static func ==(lhs: Client, rhs: Client) -> Bool{
        guard let leftKey = lhs.key else { return false }
        guard let rightKey = rhs.key else { return false }
        return leftKey == rightKey
    }
}
