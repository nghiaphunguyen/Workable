//
//  Worker.swift
//  AsyncWorkerDemo
//
//  Created by Nghia Nguyen on 26/09/2021.
//

import Foundation

public class Worker<Params, Output>: Workable {
    private let executor: (Params) -> Output

    public required init(_ executor: @escaping (Params) -> Output) {
        self.executor = executor
    }

    public func execute(params: Params) -> Output {
        executor(params)
    }
}

extension Worker {
    static func just(_ output: Output) -> Self {
        self.init { _ in
            output
        }
    }
}

extension Worker where Params == Void {
    public convenience init(_ executor: @escaping @autoclosure () -> Output) {
        self.init { _ in
            executor()
        }
    }
}
