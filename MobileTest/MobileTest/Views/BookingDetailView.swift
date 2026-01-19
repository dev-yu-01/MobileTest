//
//  BookingDetailView.swift
//  MobileTest
//
//  Created by yu on 2026/1/16.
//

import SwiftUI

struct BookingDetailView: View {
    let booking: Booking
    let segment: Segment
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Ship Reference: \(booking.shipReference)")
                        .font(.headline)
                    Text("Duration: \(booking.duration) 秒")
                    Text("Can Issue Ticket Checking: \(booking.canIssueTicketChecking ? "Yes" : "No")")
                }
                
                Divider()
                
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Origin")
                        .font(.subheadline)
                        .bold()
                    Text("City: \(segment.originAndDestinationPair.originCity)")
                    Text("Code: \(segment.originAndDestinationPair.origin.code)")
                    Text("Display Name: \(segment.originAndDestinationPair.origin.displayName)")
                    Text("URL: \(segment.originAndDestinationPair.origin.url)")
                        .foregroundColor(.blue)
                }
                
                Divider()
                
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Destination")
                        .font(.subheadline)
                        .bold()
                    Text("City: \(segment.originAndDestinationPair.destinationCity)")
                    Text("Code: \(segment.originAndDestinationPair.destination.code)")
                    Text("Display Name: \(segment.originAndDestinationPair.destination.displayName)")
                    Text("URL: \(segment.originAndDestinationPair.destination.url)")
                        .foregroundColor(.blue)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Segment Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

