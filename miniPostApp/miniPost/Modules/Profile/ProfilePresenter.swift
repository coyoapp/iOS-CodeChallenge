import Foundation
import SwiftUI

protocol ProfilePresenterProtocol: class {
    var view: ProfileViewProtocol! { get set }
    var interactor: ProfileInteractorProtocol! { get set }

    func fetchInfo()
    func didFetchInfo(_ info: User)
    func getView() -> ProfileView
}

class ProfilePresenter: ProfilePresenterProtocol {

    var view: ProfileViewProtocol!
    var interactor: ProfileInteractorProtocol!
    var router: ProfileRouterProtocol!

    func getView() -> ProfileView {
        if let view = self.view {
            return view.getView()
        } else {
            fatalError("Tried to get a non initialized profile view")
        }
    }

    func fetchInfo() {
        router.fetchInfo()
    }

    func didFetchInfo(_ info: User) {
        view.updateInfo(info)
    }
}
