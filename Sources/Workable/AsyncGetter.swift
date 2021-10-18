//
//  AsyncGetter.swift
//  AsyncWorkerDemo
//
//  Created by Nghia Nguyen on 26/09/2021.
//

import Foundation

/// The special type async worker that doesn't need the params to execute
public class AsyncGetter<Output>: AsyncWorker<Void, Output> {
    public var wrappedValue: Output {
        get async throws {
            try await self.execute(params: ())
        }
    }
}
