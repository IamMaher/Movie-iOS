//
//  APIRequestConfiguration.swift
//  TMDB
//
//  Created by Eslam Abo El Fetouh on 20/12/2023.
//

import Foundation
import Alamofire
// Encapsulate API request parameters
struct APIRequestConfiguration {
    let router: APIRouterProtocol
    let apiVersion: APIClient.APIVersion = .v3
    let method: APIClient.RequestMethod
    let header: HTTPHeaders = [:]
}
