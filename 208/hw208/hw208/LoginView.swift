import SwiftUI

struct LoginView: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            
            TextField("Username", text: $username)
                .padding()
                .background(Color.white)
                .cornerRadius(8)

            SecureField("Password", text: $password)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
            
            Button(action: signIn ) {
                Text("Sign In")
                    .foregroundColor(.white)
                    .padding()
            }
            Spacer()
        }
        .padding()
        .background(Color.gray)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    func signIn() {
        if username.isEmpty || password.isEmpty {
            alertMessage = "Пожалуйста, заполните все поля"
            alertTitle = "Ошибка ввода"
            showingAlert = true
        } else if username == "Nikita" && password == "123" {
            alertMessage = "Успешный вход!"
            alertTitle = "Успех"
            showingAlert = true
        } else {
            alertMessage = "Такого пользователя не существует"
            alertTitle = "Ошибка входа"
            showingAlert = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
