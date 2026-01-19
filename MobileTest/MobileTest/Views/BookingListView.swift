//
//  BookingListView.swift
//  MobileTest
//
//  Created by yu on 2026/1/16.
//

import SwiftUI

struct BookingListView: View {

    @StateObject private var viewModel = BookingListViewModel()

    var body: some View {
        NavigationView {
            List {
                // bookings
                ForEach(viewModel.bookings, id: \.id) { booking in
                    Section(header: Text("Ship: \(booking.shipReference)")) {
                        ForEach(booking.segments, id: \.id) { segment in
                            NavigationLink(destination: BookingDetailView(booking: booking, segment: segment)) {
                                VStack(alignment: .leading) {
                                    Text("From: \(segment.originAndDestinationPair.originCity)")
                                    Text("To: \(segment.originAndDestinationPair.destinationCity)")
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                }

                // 点击加载更多
                if viewModel.hasMoreData {
                    HStack {
                        Spacer()
                        if viewModel.isLoadingMore {
                            ProgressView()
                        } else {
                            Button {
                                Task { await viewModel.loadMore() }
                            } label: {
                                Text("点击加载更多")
                                    .foregroundColor(.blue)
                            }
                        }
                        Spacer()
                    }
                }
            }
            .navigationTitle("Bookings")
            .listStyle(.insetGrouped)

            // 下拉刷新
            .refreshable {
                await viewModel.pullToRefresh()
            }

            // 首次进入加载缓存并刷新
            .task {
                await viewModel.loadInitialCacheOnce()
            }
        }
    }
}
