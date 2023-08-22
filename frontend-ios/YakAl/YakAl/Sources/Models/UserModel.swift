//
//  UserModel.swift
//  YakAl
//
//  Created by 서희찬 on 2023/07/12.
//

import Foundation
import SwiftUI

class User: ObservableObject  {
    static let shared = User()

    // 닉네임
    @Published var nickName: String = ""
    // 본인인증 여부
    var isVerify: Bool = false
    // 노인 모드
    var isSenior: Bool = false
    
    // 테스트 진행 상태
    var testCnt: Int = 0
    
    
    public init() {}

}
