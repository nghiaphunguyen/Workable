//
//  AsyncGetter.swift
//  AsyncWorkerDemo
//
//  Created by Nghia Nguyen on 26/09/2021.
//

import Foundation
import Combine

@propertyWrapper
public class PublishGetter<Output, WorkerError: Error>: PublishWorker<Void, Output, WorkerError> {
    public var wrappedValue: AnyPublisher<Output, WorkerError> {
        execute(params: ())
    }
}
