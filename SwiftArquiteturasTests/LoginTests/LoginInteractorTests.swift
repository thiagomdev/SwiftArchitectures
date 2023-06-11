import XCTest
@testable import SwiftArquiteturas

final class LoginInteractorTests: XCTestCase {
    
    func test_() {
        let (sut, spy) = makeSut()
        let user = UserModel(email: "ana@gmail.com", password: "121212")
        
        sut.presenter?.displaySuccess(response: .init(user: user))
        sut.diplayUser(with: .init(user: user))
        
        XCTAssertEqual(spy.didCalled, true)
    }
    
    private func makeSut() -> (sut: LoginInteractor, spy: LoginPresentationLogicSpy) {
        let spy = LoginPresentationLogicSpy()
        let sut = LoginInteractor()
        return (sut, spy)
    }
}

final class LoginPresentationLogicSpy: LoginPresentationLogic {
    private(set) var didCalled = false

    func displaySuccess(response: SwiftArquiteturas.Login.Something.Response) {
        didCalled = true
    }
    
    func displayError(_ error: SwiftArquiteturas.Login.Something.ViewError) {
        didCalled = true
    }
}
