//
//  ReservationDetailView.swift
//  KoloniReservation
//
//  Created by Koloni on 19/12/24.
//

import SwiftUI

struct ReservationDetailView: View {
    let reservation: Reservation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Mode
            VStack(alignment: .leading, spacing: 4) {
                Text("MODE")
                    .font(.system(.caption, weight: .medium))
                    .foregroundColor(.secondary)
                    .textCase(.uppercase)
                
                Text(reservation.mode.capitalized)
                    .font(.system(.body, weight: .regular))
                    .foregroundColor(.primary)
            }

            // Reservation ID
            VStack(alignment: .leading, spacing: 4) {
                Text("RESERVATION ID")
                    .font(.system(.caption, weight: .medium))
                    .foregroundColor(.secondary)
                    .textCase(.uppercase)
                
                Text(reservation.id)
                    .font(.system(.body, weight: .regular))
                    .foregroundColor(.primary)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Reservation Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
