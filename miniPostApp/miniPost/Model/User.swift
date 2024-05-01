struct User: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let phone: String
    let website: String
}
