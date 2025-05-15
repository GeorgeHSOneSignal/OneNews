//
//  SignUpView.swift
//  OneNews
//
//  Created by George Hitchman-Smith on 14/05/2025.
//


import SwiftUI
import OneSignalFramework

struct SignUpView: View {
    @EnvironmentObject var session: UserSession
    @Environment(\.dismiss) var dismiss

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var selectedPlan: String = "Free"


    var body: some View {
        VStack(spacing: 20) {
            Text("Create Account")
                .font(.largeTitle)
                .bold()

            TextField("First Name", text: $firstName)
                .textFieldStyle(.roundedBorder)

            TextField("Last Name", text: $lastName)
                .textFieldStyle(.roundedBorder)

            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .textFieldStyle(.roundedBorder)

            TextField("Phone Number", text: $phone)
                .keyboardType(.phonePad)
                .textFieldStyle(.roundedBorder)
            
            Picker("Choose Your Plan", selection: $selectedPlan) {
                Text("Free").tag("Free")
                Text("Paid (£5)").tag("Paid")
                Text("Premium (£10)").tag("Premium")
            }
            .pickerStyle(.segmented)
            .padding(.vertical, 10)

            Button(action: {
                print("New user created:")
                print("First Name: \(firstName)")
                print("Last Name: \(lastName)")
                print("Email: \(email)")
                print("Phone: \(phone)")
                print("Plan: \(selectedPlan)")

                session.currentUser = User(
                    email: email,
                    firstName: firstName,
                    lastName: lastName,
                    phone: phone,
                    accountType: selectedPlan  // or rename to `plan` if you prefer
                )
                
                // ✅ Set user ID (email)
                OneSignal.login(email)
                
                // ✅ Tag first and last name
                OneSignal.User.addTags([
                    "first_name": firstName,
                    "last_name": lastName,
                    "plan_type": selectedPlan
                ])
                
                // ✅ Subscribe to email and SMS
                OneSignal.User.addEmail(email)
                OneSignal.User.addSms(phone)
                
                // Send outcome with price if applicable
                if selectedPlan == "Paid" {
                    OneSignal.Session.addOutcome("PlanPurchase", 5.0)
                } else if selectedPlan == "Premium" {
                    OneSignal.Session.addOutcome("PlanPurchase", 10.0)
                }
                session.syncSubscribedCategoriesFromOneSignal()
                session.shouldResetNavigation = true
            }) {
                Text("Sign Up")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }


            Spacer()
        }
        .padding()
        .navigationTitle("Sign Up")
    }
}
