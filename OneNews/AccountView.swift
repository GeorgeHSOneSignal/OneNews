//
//  AccountView.swift
//  OneNews
//
//  Created by George Hitchman-Smith on 14/05/2025.
//


import SwiftUI

struct AccountView: View {
    @EnvironmentObject var session: UserSession
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let user = session.currentUser {
                Text("Email: \(user.email)")
                Text("First Name: \(user.firstName)")
                Text("Last Name: \(user.lastName)")
                Text("Phone: \(user.phone)")
                Text("Account Type: \(user.accountType)")

                Spacer()

                Button(action: {
                    session.logout()
                    dismiss()
                }) {
                    Text("Logout")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .navigationTitle("My Account")
    }
}
