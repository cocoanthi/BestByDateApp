//
//  GetOneItemGroupInfoRequest.swift
//  BestByDateApp
//
//  Created by 矢口諒 on 2024/03/10.
//
import Foundation

struct GetOneItemGroupInfoRequest: ApiRequestTemplate {
    typealias Response = GetOneItemGroupInfoResponse

    let groupId: String
    let password: String
    
    var baseUrlType: BaseUrlType = .bestByDateRequest

    var path: String {
        "/group-info?group_id=\(groupId)&group_password=\(password)"
    }

    var method: HttpMethod {
        .get
    }

    var bodyParams: [String: Any?]?

    var headerParams: [String: String] {
        [
            "": ""
        ]
    }
}

struct GetOneItemGroupInfoResponse: Decodable {
    let groupInfo: GroupInfo
}
