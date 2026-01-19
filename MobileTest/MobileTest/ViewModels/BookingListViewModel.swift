//
//  BookingListViewModel.swift
//  MobileTest
//
//  Created by yu on 2026/1/16.
//

import Foundation
import SwiftUI
import Combine
import Foundation

@MainActor
class BookingListViewModel: ObservableObject {

    @Published var bookings: [Booking] = []
    @Published var hasMoreData = true
    @Published var isLoadingMore = false

    private let dataManager = BookingDataManager.shared
    private var isInitialCacheLoaded = false

    // 首次进入页面：只执行一次
    func loadInitialCacheOnce() async {
        guard !isInitialCacheLoaded else { return }
        isInitialCacheLoaded = true

        // 显示缓存
        bookings = dataManager.loadCachedData()

        // 后台刷新第一页
        let fresh = await dataManager.refreshFirstPage()
        if !fresh.isEmpty {
            bookings = fresh
        }

        hasMoreData = !bookings.isEmpty
    }

    // 下拉刷新
    func pullToRefresh() async {
        let fresh = await dataManager.refreshFirstPage()
        if !fresh.isEmpty {
            bookings = fresh
        }
        hasMoreData = !bookings.isEmpty
    }

    // 上拉加载更多
    func loadMore() async {
        guard !isLoadingMore else { return }
        isLoadingMore = true

        let more = await dataManager.loadNextPage()
        if !more.isEmpty {
            bookings.append(contentsOf: more)
        }

        hasMoreData = !more.isEmpty
        isLoadingMore = false
    }
}

