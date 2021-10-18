//
//  FutureWorkable.swift
//  AsyncWorkerDemo
//
//  Created by Nghia Nguyen on 26/09/2021.
//

import Foundation
import Combine

public protocol PublishWorkable {
    associatedtype Params
    associatedtype Output
    associatedtype WorkerError: Error

    func execute(params: Params) -> AnyPublisher<Output, WorkerError>
}
