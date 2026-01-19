//
//  BookingDataManager.swift
//  MobileTest
//
//  Created by yu on 2026/1/16.
//

import Foundation

@MainActor
class BookingDataManager {

    static let shared = BookingDataManager()

    private init() {}

    private var currentPage = 0

    // 加载缓存
    func loadCachedData() -> [Booking] {
        BookingCacheManager.shared.load()?.filter { !BookingCacheManager.shared.isExpired($0) } ?? []
    }

    // 刷新第一页
    func refreshFirstPage() async -> [Booking] {
        do {
            let first = try await BookingService.fetchBookingData(page: 0)
            currentPage = 0
            BookingCacheManager.shared.save(bookings: [first])
            return [first]
        } catch {
            print("刷新第一页失败：\(error)")
            return loadCachedData()
        }
    }

    // 加载下一页
    func loadNextPage() async -> [Booking] {
        do {
            let nextPage = currentPage + 1
            let booking = try await BookingService.fetchBookingData(page: nextPage)
            currentPage = nextPage
            return [booking]
        } catch {
            print("加载更多失败：\(error)")
            return []
        }
    }
}



