//
//  BookingService.swift
//  MobileTest
//
//  Created by yu on 2026/1/16.
//

import Foundation

class BookingService {
    
    /// 模拟分页接口，每页返回一条 Booking 数据
    /// - Parameter page: 当前页码，从 0 开始
    static func fetchBookingData(page: Int = 0) async throws -> Booking {
        // 模拟网络延迟
        try await Task.sleep(nanoseconds: 500_000_000)

        // 加载本地 mock JSON
        guard let url = Bundle.main.url(forResource: "booking", withExtension: "json") else {
            throw URLError(.fileDoesNotExist)
        }
        let data = try Data(contentsOf: url)
        var booking = try JSONDecoder().decode(Booking.self, from: data)

        // 使用页码修改唯一 ID，用来模拟不同的数据分页
        booking = Booking(
            shipReference: booking.shipReference + "_P\(page)",
            shipToken: booking.shipToken + "_P\(page)",
            canIssueTicketChecking: booking.canIssueTicketChecking,
            expiryTime: booking.expiryTime,
            duration: booking.duration,
            segments: booking.segments
        )

        return booking
    }
}



