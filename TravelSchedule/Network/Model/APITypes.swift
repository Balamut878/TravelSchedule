//
//  APITypes.swift
//  TravelSchedule
//
//  Created by Александр Дудченко on 07.05.2025.
//

import Foundation
import OpenAPIRuntime

// MARK: - Транспорт
typealias Thread = Components.Schemas.Thread
typealias Carrier = Components.Schemas.Carrier

// MARK: - Расписания и маршруты
typealias ScheduleOnStation = Components.Schemas.ScheduleOnStation
typealias SchedulePointPoint = Components.Schemas.SchedulePointPoint
typealias Route = Components.Schemas.Route

// MARK: - География
typealias Station = Components.Schemas.Station
typealias Stations = Components.Schemas.Stations
typealias NearestCity = Components.Schemas.NearestCity

// MARK: - Прочее
typealias Copyright = OpenAPIObjectContainer
typealias StationsList = HTTPBody
