import SwiftUI

protocol ProfileViewProtocol: class {
    func updateInfo(_ info: User)
    func getView() -> ProfileView
}

class ProfileViewHandler: ProfileViewProtocol {

    var presenter: ProfilePresenterProtocol!
    var view: ProfileView

    init() {
        view = ProfileView()
    }

    func getView() -> ProfileView {
        return view
    }

    func updateInfo(_ info: User) {
        view.updateModel(newName: info.name, newPhone: info.phone, newWebsite: info.website)
    }
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

class ProfileViewModel: ObservableObject {
    @Published var name: String
    @Published var phone: String
    @Published var website: String
    @Published var user_hash: String

    init(name: String = "", phone: String = "", website: String = "") {
        self.name = name
        self.phone = phone
        self.website = website
        self.user_hash = calculateUserHash(name: name, phone: phone, website: website)
    }
}

struct ProfileView: View {

    @ObservedObject var viewModel: ProfileViewModel

    init(viewModel: ProfileViewModel = ProfileViewModel()) {
        self.viewModel = viewModel
    }

    func updateModel(newName: String, newPhone: String, newWebsite: String) {
        viewModel.name = newName
        viewModel.phone = newPhone
        viewModel.website = newWebsite
        viewModel.user_hash = calculateUserHash(name: newName, phone: newPhone, website: newWebsite)
    }

    var body: some View {
        VStack {
            Text(viewModel.name)
                .font(.title)
                .padding()
            HStack {
                Image(systemName: "phone")
                    .imageScale(.large)
                Text(viewModel.phone)
            }
            HStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                Text(viewModel.website)
            }
            Text("Customer ID: "+viewModel.user_hash)
            Spacer()
        }.navigationTitle("My profile")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
