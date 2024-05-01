import Foundation
import Collections
import Combine

final class ProfileViewModel: ObservableObject {
    @Published var userProfile: User?
    @Published var userHash = ""
    private var cancellables = Set<AnyCancellable>()

    private let userProfileService: NetworkProtocol
    
    init(userProfileService: NetworkProtocol) {
        self.userProfileService = userProfileService
        fetchUserProfile()
    }
    
    func fetchUserProfile() {
        userProfileService.fetchUserProfileService(id: "4").sink { completion in
            switch completion {
            case .failure(let error):
                print("Error fetching posts:", error.localizedDescription)
            case .finished:
                print("Finished receiving posts")
            }
        } receiveValue: { [weak self] result in
            self?.userProfile = result
            self?.userHash = self?.calculateUserHash(name: result.name, phone: result.phone, website: result.website) ?? ""
        }
        .store(in: &cancellables)
    }
    
    func calculateUserHash(name: String, phone: String, website: String) -> String {

        let nameComponents = name.components(separatedBy: " ")
        var nameAbbreviation = ""
        for component in nameComponents {
            let firstTwoChars = component.prefix(2)
            nameAbbreviation.append(contentsOf: firstTwoChars)
        }

        let phoneDigits = phone.components(separatedBy: "-")
        var phoneSum = 0
        for digit in phoneDigits {
            if let intValue = Int(digit) {
                phoneSum += intValue
            }
        }

        let websiteComponents = website.components(separatedBy: ".")
        let domainName = websiteComponents.first ?? ""

        let finalString = nameAbbreviation + String(phoneSum) + domainName
        return finalString
    }

}
