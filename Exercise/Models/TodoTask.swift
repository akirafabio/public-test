import Foundation

struct TodoTask {
    let id = UUID()
    let name: String
    var isSaving: Bool = true
    var didFail: Bool = false
}
