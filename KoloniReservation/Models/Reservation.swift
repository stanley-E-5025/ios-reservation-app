//
//  Reservation.swift
//  KoloniReservation
//
//  Created by Koloni on 19/12/24.
//

import Foundation


struct Reservation: Codable, Identifiable {
    let id: String
    let mode: String
    let tracking_number: String
}
