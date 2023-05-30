import SwiftUI
import DesignComponentLibrary

struct LoginView: View {

    @State var userName = ""
    @State var password = ""
    @State var passwordValidation: InputComponent.InputComponentValidation = .none
    @State var passwordDescriptionText = "Only numeric input allowed"
    @State var isSecure = true
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: Dimensions.Spacing.systemTwentyFour) {
                userNameField
                passwordField
                Spacer()
                CustomButton(text: "Login") {
                    validatePassword()
                }
            }
            .padding(Dimensions.Spacing.systemThirtyThree)
            .navigationBarTitle("InputField Demo")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    var userNameField: some View {
        InputComponent(keyboardType: .default, text: $userName,
                       isSecure: false, label: "Username",
                       validationState: nil,
                       descriptionText: nil,
                       maxCharLimit: 100,
                       trailingIcon: nil,
                       onFinishEditing: {

        })
    }

    var passwordField: some View {
        InputComponent(keyboardType: .numberPad, text: $password,
                       isSecure: isSecure, label: "Pin",
                       validationState: $passwordValidation,
                       descriptionText: $passwordDescriptionText,
                       maxCharLimit: 8,
                       trailingIcon: InputComponent.TrailingIcon(icon: isSecure ? .eye : .eyeSlash, accessibilityName: isSecure ? "Show pin" : "Hide pin", action: {
            self.isSecure.toggle()
            toggleKeyboard()
        }),
                       onFinishEditing: validatePassword)
    }

    func toggleKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    func validatePassword() {
        let passwordValidator = InputComponent.PasswordFieldValidator(text: password)
        passwordValidation = passwordValidator.validationState
        passwordDescriptionText = passwordValidator.displayMessage
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
