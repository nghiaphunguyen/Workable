//
//  AsyncWorker.swift
//  AsyncWorkerDemo
//
//  Created by Nghia Nguyen on 26/09/2021.
//

import Foundation

public class AsyncWorker<Params, Output> {

    private let executor: (Params) async throws -> Output

    public required init(_ executor: @escaping (Params) async throws -> Output){
        self.executor = executor
    }

    public func execute(params: Params) async throws -> Output {
        return try await executor(params)
    }
}

extension AsyncWorker {
    public static func just(_ output: Output) -> Self {
        self.init { _ in
            output
        }
    }

    public static func error<E: Error>(_ error: E) -> Self {
        self.init { _ in
            throw error
        }
    }
}

extension AsyncWorker where Params == Void {
    public convenience init(_ executor: @escaping () async throws -> Output){
        self.init { _ in
            return try await executor()
        }
    }
}
