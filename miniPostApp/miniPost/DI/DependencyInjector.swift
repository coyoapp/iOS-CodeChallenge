//
//  DependencyInjector.swift
//  miniPost
//
//  Created by Amine Hajri on 25.04.24.
//

import Foundation

final class DependencyInjector {
    private static var dependencyList: [String: Any] = [:]
    
    private init(){}
    
    static func resolve<T>() -> T {
        guard let t = dependencyList[String(describing: T.self)] as? T else {
            fatalError("No provider registred for type: \(T.self)")
        }
        return t
    }
    
    static func register<T>(dependency: T) {
        dependencyList[String(describing: T.self)] = dependency
    }
}

@propertyWrapper struct Inject<T> {
    var wrappedValue: T
    
    init() {
        self.wrappedValue = DependencyInjector.resolve()
    }
}

@propertyWrapper struct Provider<T> {
    var wrappedValue: T
    
    init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        DependencyInjector.register(dependency: wrappedValue)
    }
}
