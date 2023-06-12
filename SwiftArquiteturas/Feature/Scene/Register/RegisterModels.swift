import UIKit

enum Register {
    // MARK: Use cases
    
    enum Make {
        struct Request {
            var user: UserModel
        }
        
        struct Response {
            var user: UserModel
        }
        
        struct ViewModel {
            var user: UserModel
        }
        
        struct ViewError {
            var error: Error
        }
    }
}
