import XCTest
import Combine
@testable import Workable

final class WorkableTests: XCTestCase {

    private var cancellables = Set<AnyCancellable>()

    func testLoginSuccess() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let worker: ViewModel.LoginWorker = .just(())
        let viewModel = ViewModel(loginWorker: worker)

        let expectation = XCTestExpectation()

        viewModel.login(with: "nghia", password: "nghianguyen").sink { completion in

        } receiveValue: { _ in
            expectation.fulfill()
        }.store(in: &cancellables)

        wait(for: [expectation], timeout: 0.5)

    }

    func testLoginFailWithInvalidUsername() {
        let worker: ViewModel.LoginWorker = .error(.invalidPassword)
        let viewModel = ViewModel(loginWorker: worker)

        let expectation = XCTestExpectation()

        viewModel.login(with: "nghia", password: "nghianguyen").sink { completion in
            switch completion {
            case let .failure(error) where error == .invalidPassword:
                expectation.fulfill()
            default:
                break
            }

        } receiveValue: { _ in
        }.store(in: &cancellables)

        wait(for: [expectation], timeout: 0.5)
    }

    func testLoginFailWithInvalidPassword() {
        let worker: ViewModel.LoginWorker = .error(.invalidUsername)
        let viewModel = ViewModel(loginWorker: worker)

        let expectation = XCTestExpectation()

        viewModel.login(with: "nghia", password: "nghianguyen").sink { completion in
            switch completion {
            case let .failure(error) where error == .invalidUsername:
                expectation.fulfill()
            default:
                break
            }

        } receiveValue: { _ in
        }.store(in: &cancellables)

        wait(for: [expectation], timeout: 0.5)
    }

    func testGreeting() {
        let greeting = "Bonjour"
        let viewModel = ViewModel(loginWorker: .just(()), greetingGetter: .just(greeting))

        XCTAssert(viewModel.getGreeting() == greeting, "The greeting should be \(greeting)")
    }
}


class ViewModel {
    enum LoginError: Error {
        case invalidUsername
        case invalidPassword
    }

    typealias LoginWorker = PublishWorker<(username: String, password: String), Void, LoginError>
    private let loginWorker: LoginWorker
    private let greetingGetter: Getter<String>

    init(loginWorker: LoginWorker, greetingGetter: Getter<String> = .just("Hello")) {
        self.loginWorker = loginWorker
        self.greetingGetter = greetingGetter
    }

    func login(with username: String, password: String) -> AnyPublisher<Void, LoginError> {
        loginWorker.execute(params: (username: username, password: password))
    }

    func getGreeting() -> String {
        greetingGetter.wrappedValue
    }
}

