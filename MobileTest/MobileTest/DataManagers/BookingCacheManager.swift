//
//  BookingCacheManager.swift
//  MobileTest
//
//  Created by yu on 2026/1/16.
//

import Foundation

class BookingCacheManager {
    
    static let shared = BookingCacheManager()
    private let cacheFileName = "bookings_cache.json"
    
    private init() {}
    
    private func cacheURL() -> URL {
        let dir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return dir.appendingPathComponent(cacheFileName)
    }
    
    // 保存 Booking（可追加多条，自动去重）
    func save(bookings newBookings: [Booking]) {
        var cachedBookings = load() ?? []
        
        for booking in newBookings {
            if let index = cachedBookings.firstIndex(where: { $0.id == booking.id }) {
                cachedBookings[index] = booking // 替换已有的
            } else {
                cachedBookings.append(booking) // 追加新数据
            }
        }
        
        do {
            let data = try JSONEncoder().encode(cachedBookings)
            try data.write(to: cacheURL())
        } catch {
            print("保存缓存失败: \(error.localizedDescription)")
        }
    }
    
    // 保存单条 Booking（内部调用多条保存）
    func save(booking: Booking) {
        save(bookings: [booking])
    }
    
    // 读取缓存（自动过滤过期）
    func load() -> [Booking]? {
        do {
            let data = try Data(contentsOf: cacheURL())
            let bookings = try JSONDecoder().decode([Booking].self, from: data)
            return bookings.filter { !isExpired($0) }
        } catch {
            return nil
        }
    }
    
    // 判断 Booking 是否过期
    func isExpired(_ booking: Booking) -> Bool {
        guard let expiry = booking.expiryDate else { return true }
        return Date() > expiry
    }
    
    // 清理缓存
    func clearCache() {
        do {
            try FileManager.default.removeItem(at: cacheURL())
        } catch {}
    }
}
