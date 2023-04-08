import SwiftUI

struct LoginView: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var showingAlert = false
    @State private var isLogin = false

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
        .alert(isLogin ? "Успех" : "Ты неудачник", isPresented: $showingAlert) {
            if isLogin {
                Button("Clear password") {
                    password = ""
                }
                Button("Clear username") {
                    username = ""
                }
                Button("Clear all") {
                    password = ""
                    username = ""
                }
            } else {
                Button("Ok") {
                    
                }
            }
        }
    }

    func signIn() {
        if username == "Nikita" && password == "123" {
            isLogin = true
        } else {
            isLogin = false
        }
        showingAlert = true
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
