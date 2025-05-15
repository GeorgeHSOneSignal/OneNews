import SwiftUI
import OneSignalFramework

struct LoginView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var session: UserSession // 🔹 Needed to log user in
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showSignUp = false

    var body: some View {
        VStack(spacing: 20) {

            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)

            SecureField("Password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)

            Button(action: {
                session.login(
                    email: email,
                    firstName: "Demo",
                    lastName: "User",
                    phone: "000-000-0000"
                )
                OneSignal.login(email)
                print("logged in with: \(email)")
                session.syncSubscribedCategoriesFromOneSignal()
                dismiss()
            }) {
                Text("Login")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            Button(action: {
                showSignUp = true
            }) {
                Text("Sign Up")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Login")
        .navigationDestination(isPresented: $showSignUp) {
            SignUpView()
        }
    }
}
