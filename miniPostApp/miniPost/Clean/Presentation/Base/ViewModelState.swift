//
//  ViewModelState.swift
//  miniPost
//
//  Created by Víctor Barrios Sánchez on 8/5/24.
//

import Foundation

enum ViewModelState<Value> {
    case idle
    case loading
    case failed(Error)
    case loaded(Value)
}
