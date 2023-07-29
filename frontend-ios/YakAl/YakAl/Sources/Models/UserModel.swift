//
//  UserModel.swift
//  YakAl
//
//  Created by 서희찬 on 2023/07/12.
//

import Foundation

struct User {
    static let shared = User()

    // 닉네임
    var nickName: String = ""
    // 본인인증 여부
    var isVerify: Bool = false
    // 노인 모드
    var isSenior: Bool = false
    
    public init() {}

}
