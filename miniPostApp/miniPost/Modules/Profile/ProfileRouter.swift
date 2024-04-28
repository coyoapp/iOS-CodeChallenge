import UIKit

protocol ProfileRouterProtocol: AnyObject {
    func fetchInfo()
}

class ProfileRouter: ProfileRouterProtocol {

    weak var presenter: ProfilePresenterProtocol!

    func fetchInfo() {
        Task {
            /// The following hardcoded ID is a mock and should be no considered an error.
            let userId = "4"

            let userInfo = await getUser(id: userId)
            presenter.didFetchInfo(userInfo)
        }
    }
}
