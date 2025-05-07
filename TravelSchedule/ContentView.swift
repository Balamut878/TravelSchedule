//
//  ContentView.swift
//  TravelSchedule
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("Hello, world!")
            
            Button("Загрузить") {
                loadNearestStations()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
    
    private func log(_ message: String, emoji: String = "🔹") {
        print("\(emoji) \(message)")
    }
    
    // MARK: - Network
    private func loadNearestStations() {
        Task {
            let networkService = NetworkService()
            log("Старт загрузки данных", emoji: "🚀")

            do {
                let nearest = try await networkService.getNearestStations(
                    lat: 59.864177,
                    lng: 30.319163,
                    distance: 50
                )
                log("Станции загружены: \(nearest.stations?.count ?? 0)", emoji: "📍")

                _ = try await networkService.getStationsList()

                guard let stations = nearest.stations?.filter({ $0.transport_type == "train" }), stations.count >= 2 else {
                    log("Недостаточно станций для маршрута", emoji: "⚠️")
                    return
                }

                let fromStation = stations[0]

                guard let toStation = stations.first(where: { $0 != fromStation }) else {
                    log("Нет отличной станции для прибытия", emoji: "⚠️")
                    return
                }

                log("Выбрана станция прибытия: \(toStation)", emoji: "🎯")

                do {
                    _ = try await networkService.getScheduleOnStation(station: fromStation)
                    log("Расписание по станции загружено", emoji: "📅")
                } catch {
                    log("Ошибка при загрузке расписания по станции: \(error)", emoji: "❌")
                }

                if fromStation != toStation {
                    do {
                        let schedule = try await networkService.getScheduleBetweenStations(from: fromStation, to: toStation)
                        log("Расписание между станциями загружено", emoji: "🛤️")

                        if let thread = schedule?.segments?.first?.thread, let uid = thread.uid {
                            log("UID нитки маршрута: \(uid)", emoji: "🧵")

                            do {
                                if let thread = schedule?.segments?.first?.thread {
                                    _ = try await networkService.getRouteStations(station: .init(code: uid))

                                    do {
                                        let city = try await networkService.getNearestSettlement(lat: 59.864177, lng: 30.319163)
                                        log("✅ Ближайший город успешно загружен: \(city.title ?? "неизвестно")", emoji: "🏙️")

                                        do {
                                            let carrier = try await networkService.getCarrierInfo(code: "TK")
                                            log("✅ Перевозчик успешно загружен: \(carrier)", emoji: "🚛")
                                        } catch {
                                            log("Ошибка при загрузке информации о перевозчике: \(error)", emoji: "❌")
                                        }
                                    } catch {
                                        log("Ошибка при загрузке ближайшего города: \(error)", emoji: "❌")
                                    }

                                } else {
                                    log("Не удалось получить объект thread", emoji: "⚠️")
                                }
                            } catch {
                                log("Ошибка при загрузке нитки маршрута: \(error)", emoji: "❌")
                            }
                        } else {
                            log("Не удалось получить UID нитки маршрута", emoji: "⚠️")
                        }
                    } catch {
                        log("Ошибка при загрузке расписания между станциями: \(error)", emoji: "❌")
                    }
                } else {
                    log("Станции отправления и прибытия совпадают — пропуск", emoji: "⚠️")
                }

            } catch {
                log("Ошибка при загрузке ближайших станций: \(error)", emoji: "❌")
            }

            do {
                let copyright = try await networkService.getCopyright()
                log("✅ Копирайт успешно загружен: \(copyright)", emoji: "©️")
            } catch {
                log("Ошибка при загрузке копирайта: \(error)", emoji: "❌")
            }
            log("Загрузка завершена", emoji: "✅")
        }
    }
}

#Preview {
    ContentView()
}
