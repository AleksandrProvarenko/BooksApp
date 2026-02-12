//
//  ViewStates.swift
//  BooksApp
//
//  Created by Alex Provarenko on 11.02.2026.
//

import Foundation

enum ViewState: Equatable {
    case idle
    case loading
    case loaded([Book])
    case error(String)
}
