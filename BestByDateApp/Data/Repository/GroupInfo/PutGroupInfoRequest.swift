//
//  GetOneItemGroupInfoRequest.swift
//  BestByDateApp
//
//  Created by 矢口諒 on 2024/03/10.
//
import Foundation

struct PutGroupInfoRequest: ApiRequestTemplate {
    typealias Response = PutGroupInfoResponse

    let groupName: String
    let password: String
    
    var baseUrlType: BaseUrlType = .bestByDateRequest

    var path: String {
        "/group-info"
    }

    var method: HttpMethod {
        .put
    }

    var bodyParams: [String: Any?]? {
        [
            "group_info": [
                "group_name": groupName,
                "group_password": password
            ]
        ]
    }

    var headerParams: [String: String] {
        [
            "": ""
        ]
    }
}

struct PutGroupInfoResponse: Decodable {
    let groupInfo: GroupInfo
}


