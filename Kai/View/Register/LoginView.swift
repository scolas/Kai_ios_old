//
//  LoginView.swift
//  Kai
//
//  Created by Scott Colas on 2/8/22.
//

import SwiftUI
import FirebaseAuth
class AppViewModel: ObservableObject{
    let auth = Auth.auth()
    // updates becuse its binding/live data
    @Published var signedIn = false
    
    var isSignedIn: Bool{
        return auth.currentUser != nil
    }
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password) {[weak self] result, error in
            guard result != nil, error == nil else{
                return
            }
            //success
            DispatchQueue.main.async {
                self?.signedIn = true
            }
            
        }
    }
    
    func signUp(email: String, password: String){
        auth.createUser(withEmail: email, password: password) {[weak self] result, error in
            guard result != nil, error == nil else{
                return
            }
            //success
            DispatchQueue.main.async {
                self?.signedIn = true
            }
            
        }
    }
    
}

struct LoginView: View {
   
    @EnvironmentObject var viewModel: AppViewModel

    var body: some View {
       /* NavigationView{
            if viewModel.signedIn{
                PortfolioView()
            }else{
                LoginSubView(vm: viewModel)
            }
        }.onAppear{
            viewModel.signedIn = viewModel.isSignedIn
        }*/
        /*TabView{
            PortfolioView()
                .tabItem{
                    Image(systemName: "house")
                }
            FinanceView()
                .tabItem{
                    Image(systemName: "wallet.pass")
                }
            AddPropertyView()
                .tabItem{
                    Image(systemName: "plus.circle")
                }
        }*/
        Home()
        
        
        
    }

}

struct LoginSubView: View {
    let green : UIColor = UIColor(red: 0.063, green: 0.376, blue: 0.282, alpha: 1)
    @State var username: String = ""
    @State var password: String = ""
    //@EnvironmentObject var viewModel: AppViewModel
    var vm: AppViewModel
    @State private var emailFieldIsFocused: Bool = false

    var body: some View {
        
        VStack{
            Text("Email")
            TextField("Email",text:$username)
                .padding()
                .disableAutocorrection(true)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            Text("Password")
                .padding()
            SecureField("password",text:$password)
                .padding()
            
            Text("Forgot your password")
                .disableAutocorrection(true)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            Button("Log In") {
                print("Button pressed!")
            }
            .padding()
            .foregroundColor(.white)
            .frame(width: 319, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color(red: 0.063, green: 0.376, blue: 0.282))
            .clipShape(Capsule())
            
            Button(action: {
                guard !username.isEmpty, !password.isEmpty else {
                    return
                }
                vm.signIn(email: username, password: password)
            }, label: {
                Text("Sign In")
                    .foregroundColor(.white)
                    .frame(width: 319, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color(red: 0.063, green: 0.376, blue: 0.282))
                    .clipShape(Capsule())
            })
            NavigationLink("Create Account22", destination: signUpSubView(vm: vm))
            
            Text("Dont have an account?")
            Text("Register Now")
        }

    }
    
    
}

struct signUpSubView: View {
    let green : UIColor = UIColor(red: 0.063, green: 0.376, blue: 0.282, alpha: 1)
    @State var username: String = ""
    @State var password: String = ""
    //@EnvironmentObject var viewModel: AppViewModel
    var vm: AppViewModel
    @State private var emailFieldIsFocused: Bool = false

    var body: some View {
        
        VStack{
            Text("Email")
            TextField("Email",text:$username)
                .padding()
                .disableAutocorrection(true)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            Text("Password")
                .padding()
                .disableAutocorrection(true)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            SecureField("password",text:$password)
                .padding()
      
            Button(action: {
                guard !username.isEmpty, !password.isEmpty else {
                    return
                }
                vm.signUp(email: username, password: password)
            }, label: {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .frame(width: 319, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color(red: 0.063, green: 0.376, blue: 0.282))
                    .clipShape(Capsule())
            })
            .padding()
            
        }
        .navigationTitle("Create Account")

    }
    
    
}

struct Homeq: View{

    @State var selectedtab = "house"
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    //Location For each Curve...
    @State var xAxis: CGFloat = 0
    
    var body: some View{
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView(selection: $selectedtab){
                PortfolioView()
                    .tabItem{
                        Image(systemName: "house")
                    }
                    .tag("house")
                /*Color.orange
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("house")*/
                FinanceView()
                    .tabItem{
                        Image(systemName: "wallet.pass")
                    }
                    .tag("wallet.pass")
               /* Color.red
                    ignoresSafeArea(.all, edges: .all)
                    .tag("wallet.pass")*/
                /*Color.purple
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("dollarsign.circle")*/
                TenantHome()
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("dollarsign.circle")
                AddPropertyView()
                    .tabItem{
                        Image(systemName: "plus.circle")
                    }
                    .tag("plus.circle")
                /*Color.blue
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("plus.circle")*/
                
            }
            
            // Custom tab Bar...
            HStack(spacing:0){
                ForEach(tabs,id: \.self){image in
                  
                    GeometryReader {reader in
                        Button(action: {
                            withAnimation(.spring()){
                                selectedtab = image
                                xAxis = reader.frame(in: .global).minX
                            }
                        }, label: {
                            //print(image)
                           // print(selectedtab)
                            Image(systemName: (image))
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(selectedtab == image ? getColor(image: image) : Color.gray)
                                //.padding(selectedtab == image ? 15 : 0)
                                //.padding(selectedtab == "plus.circle" ? 34 : 0 )
                                .background(Color.white.opacity(selectedtab == image ? 1 : 0).clipShape(Circle()))
                                
    //.offset(x:reader.frame(in: .global).minX - reader.frame(in: .global).midX,  y: selectedtab == image ? -50 : 0)
                                
                        })
                            .onAppear(perform: {
                                if image == tabs.first{
                                    //xAxis = reader.frame(in: .global).minX
                                }
                            })
                    }
                    .frame(width: 25, height: 25)
                    // .offset(x:((image == "plus.circle") ? 0 : 25 ), y: 25)
                    if image != tabs.last{Spacer(minLength: 0)}
                }
                
            }
            .padding(.horizontal,30)
            .padding(.vertical)
            .background(Color.white.clipShape(CustomShape(xAxis: xAxis,photos: selectedtab)))
            //.background(Color.white)
            
            //curved eedges and float
            //.cornerRadius(12)
            //.padding(.horizontal)
            
            // Bottom Edge...
            //padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
    func getColor(image: String)->Color{
        switch image {
        case "house":
            return Color.black
        case "wallet.pass":
            return Color.black
        case "dollarsign.circle":
            return Color.black
        case "plus.circle":
            return Color.green
        default:
            return Color.black
        }
    }
}


var tabs = ["house","wallet.pass","dollarsign.circle","plus.circle"]


struct CustomShape: Shape{
    var xAxis: CGFloat
    var photos: String
    //var xAxis: CGFloat = 335.0
    
    func path(in rect: CGRect) -> Path{
        print("this is xAxis")
        print(xAxis)
        print("this is photos")
        print(photos)
        
        return Path{path in
            path.move(to: CGPoint(x:0, y:0))
            path.addLine(to: CGPoint(x: rect.width,y: 0))
            path.addLine(to: CGPoint(x: rect.width,y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            //let center = rect.width/2
            
            //let center = xAxis
            var center = 335.0
            center = rect.width - 45
            
            path.move(to: CGPoint(x: center - 50, y: 0))
            
            //let to1 = CGPoint(x: center, y: 35)
            let to1 = CGPoint(x: center, y: 40)
            let control1 = CGPoint(x: center - 25, y: 0)
            let control2 = CGPoint(x: center - 25, y: 35)
            
            let to2 = CGPoint(x: center + 50, y: 0)
            let control3 = CGPoint(x: center+25, y: 35)
            let control4 = CGPoint(x: center+25, y: 0)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
