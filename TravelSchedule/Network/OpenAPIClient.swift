//
//  OpenAPIClient.swift
//  TravelSchedule
//
//  Created by Александр Дудченко on 06.05.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

enum API {
    // Мой ключ!
    static let key = "b94f167d-9ac3-4219-89e7-e6f52aa3cd72"
    static let shared: Client = {
        let url = try! Servers.Server1.url()
        return Client(
            serverURL: url,
            transport: URLSessionTransport())
    }()
}
