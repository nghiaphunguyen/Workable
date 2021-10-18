//
//  AsyncWorker.swift
//  AsyncWorkerDemo
//
//  Created by Nghia Nguyen on 26/09/2021.
//

import Foundation
import Combine

public class PublishWorker<Params, Output, WorkerError: Error>: PublishWorkable {

    private let executor: (Params) -> AnyPublisher<Output, WorkerError>

    public required init(_ executor: @escaping (Params) -> AnyPublisher<Output, WorkerError>){
        self.executor = executor
    }

    public final func execute(params: Params) -> AnyPublisher<Output, WorkerError> {
        return executor(params)
    }
}

extension PublishWorker {
    static func just(_ output: Output) -> Self {
        self.init { _ in
            Future { promise in
                promise(Result.success(output))
            }.eraseToAnyPublisher()
        }
    }

    static func error(_ error: WorkerError) -> Self {
        self.init { _ in
            Future { promise in
                promise(Result.failure(error))
            }.eraseToAnyPublisher()
        }
    }
}

extension PublishWorker where Params == Void {
    public convenience init(executor: @escaping @autoclosure () -> AnyPublisher<Output, WorkerError>) {
        self.init { _ in
            executor()
        }
    }
}
