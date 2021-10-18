//
//  Workable.swift
//  AsyncWorkerDemo
//
//  Created by Nghia Nguyen on 26/09/2021.
//

import Foundation

public protocol Workable {
    associatedtype Params
    associatedtype Output
    func execute(params: Params) -> Output
}
