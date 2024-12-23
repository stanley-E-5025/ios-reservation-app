//
//  ReservationView.swift
//  KoloniReservation
//
//  Created by Koloni on 19/12/24.
//

import SwiftUI

struct ReservationView: View {
    @StateObject private var viewModel = ReservationListViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.reservations) { reservation in
                NavigationLink(destination: ReservationDetailView(reservation: reservation)) {
                    Text(reservation.tracking_number)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                        .padding(.vertical, 4)
                }
                .listRowInsets(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
            }
            .listStyle(.plain)
            .navigationTitle("Reservations")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.fetchReservations()
            }
        }
    }
}

#Preview {
    ReservationView()
}
