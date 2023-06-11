import XCTest
@testable import SwiftArquiteturas

final class LoginPresenterTests: XCTestCase {
    
    func test_() {
//        let (sut, spy) = makeSut()
//        let user = UserModel(email: "ana@gmail.com", password: "121212")
//        
//        sut.viewController?.displaySomething(viewModel: .init(user: user))
        
//        XCTAssertEqual(spy.displaySomethingCalled, true)
    }
    
    private func makeSut() -> (sut: LoginPresenter, spy: LoginDisplayLogicSpy) {
        let spy = LoginDisplayLogicSpy()
        let sut = LoginPresenter()
        return (sut, spy)
    }
}

final class LoginDisplayLogicSpy: LoginDisplayLogic {
    private(set) var displaySomethingCalled = false
    private(set) var error: Login.Something.ViewError?
    
    func displayViewError(_ error: SwiftArquiteturas.Login.Something.ViewError) {
        self.error = error
        displaySomethingCalled = true
    }
    
    func displaySomething(viewModel: Login.Something.ViewModel) {
        displaySomethingCalled = true
    }
}
