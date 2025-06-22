//
//  NetworkService.swift
//  TravelSchedule
//


import OpenAPIRuntime
import OpenAPIURLSession


private func log(_ message: String) {
    print("[TS] \(message)")
}

actor NetworkService {
    private let client: Client
    private let apikey: String

    // MARK: - Инициализация
    init(client: Client = API.shared, apikey: String = API.key) {
        self.client = client
        self.apikey = apikey
        log("🧩 NetworkService инициализирован")
    }

    // MARK: - Ближайшие объекты
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> Stations {
        let response = try await client.getNearestStations(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng,
            distance: distance
        ))
        log("🚀 Загрузка ближайших станций...")
        let result = try response.ok.body.json
        log("✅ Станции успешно загружены:")
        log("🔢 Кол-во ближайших станций: \(result.stations?.count ?? 0)")
        return result
    }

    func getNearestSettlement(lat: Double, lng: Double, distance: Int? = nil) async throws -> NearestCity {
        log("🚀 Загрузка ближайшего города по координатам: lat=\(lat), lng=\(lng)")
        let response = try await client.getNearestSettlement(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng,
            distance: distance,
            lang: "ru_RU",
            format: "json"
        ))
        let result = try response.ok.body.json
        log("✅ Ближайший город успешно загружен:")
        log("🏙 Название ближайшего города: \(result.title ?? "неизвестно")")
        return result
    }

    // MARK: - Расписания
    func getScheduleOnStation(station: Station, date: String? = nil) async throws -> ScheduleOnStation {
        let code = station.code ?? ""
        log("🚀 Загрузка расписания по станции: \(code)")
        let response = try await client.getScheduleOnStation(query: .init(
            apikey: apikey,
            station: code,
            date: date,
            transport_types: nil
        ))
        let result = try response.ok.body.json
        log("✅ Расписание успешно загружено:")
        log("📅 Данные по станции загружены.")
        return result
    }

    func getScheduleBetweenStations(from: Station, to: Station, date: String? = nil) async throws -> SchedulePointPoint? {
        let fromCode = from.code ?? ""
        let toCode = to.code ?? ""
        log("🚀 Загрузка расписания между станциями: \(fromCode) → \(toCode)")
        if fromCode == toCode {
            log("⚠️ Отправление и прибытие не должны быть одинаковыми: \(fromCode)")
            return nil
        }
        let response = try await client.getScheduleBetweenStations(query: .init(
            apikey: apikey,
            from: fromCode,
            to: toCode,
            date: date
        ))

        switch response {
        case .ok(let ok):
            let result = try ok.body.json
            log("✅ Расписание успешно загружено:")
            log("🔀 Кол-во сегментов между станциями: \(result.segments?.count ?? 0)")
            return result
        default:
            log("❌ Ошибка загрузки расписания между станциями.")
            return nil
        }
    }

    func getRouteStations(station: Station) async throws -> Route {
        let uid = station.code ?? ""
        log("🚀 Загрузка нитки маршрута с uid: \(uid)")
        let response = try await client.getRouteStations(query: .init(
            apikey: apikey,
            uid: uid
        ))
        let result = try response.ok.body.json
        log("✅ Нитка маршрута успешно загружена:")
        log("🧵 Нитка маршрута успешно получена.")
        return result
    }

    // MARK: - Перевозчик и копирайт
    func getCarrierInfo(code: String) async throws -> Copyright {
        log("🚀 Загрузка информации о перевозчике с кодом: \(code)")
        let response = try await client.getCarrier(query: .init(
            apikey: apikey,
            code: code,
            format: "json",
            lang: "ru_RU",
            system: "iata"
        ))
        let result = try response.ok.body.json
        log("✅ Информация о перевозчике успешно загружена:")
        return result
    }

    func getStationsList() async throws -> StationsList {
        log("🚀 Загрузка списка всех станций (HTML)")
        let response = try await client.getStationsList(
            query: Operations.getStationsList.Input.Query(
                apikey: apikey,
                format: "json",
                lang: "ru_RU"
            )
        )
        let result = try response.ok.body.html
        log("✅ Список станций успешно загружен (HTML)")
        return result
    }
    
    func getCopyright() async throws -> Copyright {
        log("🚀 Загрузка информации о копирайте Яндекс Расписаний")
        let response = try await client.getCopyright(query: .init(
            apikey: apikey,
            format: "json"
        ))
        let result = try response.ok.body.json
        log("✅ Копирайт успешно загружен:")
        return result
    }
}
