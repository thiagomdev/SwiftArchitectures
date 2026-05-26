import UIKit

enum Login {
    enum Make {
        struct Request {
            var user: UserModel
        }
        
        struct Response: Equatable {
            var user: UserModel
        }
        
        struct ViewModel: Equatable {
            var user: UserModel
        }
        
        struct ViewError: Equatable {
            static func == (lhs: Login.Make.ViewError, rhs: Login.Make.ViewError) -> Bool {
                return lhs.error.localizedDescription == rhs.error.localizedDescription
            }
            var error: Error
        }
    }
}
