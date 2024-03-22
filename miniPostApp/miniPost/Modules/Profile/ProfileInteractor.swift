import Foundation

protocol ProfileInteractorProtocol: class {
    var presenter: ProfilePresenterProtocol! { get set }
}

class ProfileInteractor: ProfileInteractorProtocol {
    weak var presenter: ProfilePresenterProtocol!
}
