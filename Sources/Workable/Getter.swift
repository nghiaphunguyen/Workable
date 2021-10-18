//
//  Getter.swift
//  AsyncWorkerDemo
//
//  Created by Nghia Nguyen on 26/09/2021.
//

import Foundation

@propertyWrapper
public class Getter<T>: Worker<Void, T> {
    public var wrappedValue: T {
        execute(params: ())
    }
}
