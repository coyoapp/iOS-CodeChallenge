import Foundation

protocol ProfileInteractorProtocol: AnyObject {
    var presenter: ProfilePresenterProtocol! { get set }
}

class ProfileInteractor: ProfileInteractorProtocol {
    weak var presenter: ProfilePresenterProtocol!
}
