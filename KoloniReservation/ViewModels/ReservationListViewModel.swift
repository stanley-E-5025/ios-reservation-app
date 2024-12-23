//
//  ReservationListViewModel.swift
//  KoloniReservation
//
//  Created by Koloni on 19/12/24.
//

import Foundation
import SwiftUI

final class ReservationListViewModel: ObservableObject {
    @Published var reservations: [Reservation] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let networkManager = NetworkManager()

    func fetchReservations() {
        isLoading = true
        networkManager.fetchReservations { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let fetchedReservations):
                    self?.reservations = fetchedReservations
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
