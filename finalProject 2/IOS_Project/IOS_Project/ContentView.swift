//
//  ContentView.swift
//  IOS_Project
//
//  Created by Ahsan Habib Swassow on 24/12/22.
//

import SwiftUI
import Firebase

struct ContentView: View {
    var body: some View {
        
        NavigationStack{
            Home()
            // for light status bar...
                .preferredColorScheme(.dark)
        }.navigationBarBackButtonHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    
    @State var index = 0
    @State private var showAlert = false

    
    var body: some View{
        
        
            GeometryReader{_ in
                
                VStack{
                    
                    Image("logo")
                    .resizable()
                    .frame(width: 60, height: 60)
                    
                    ZStack{
                        
                        SignUP(index: self.$index)
                            // changing view order...
                            .zIndex(Double(self.index))
                        
                        Login(index: self.$index)

                    }
                    
                    
                }
                .padding(.vertical)
            }
            .background(Color("Color").edgesIgnoringSafeArea(.all))
        
    }
}

// Curve...

struct CShape : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in

            // right side curve...
            
            path.move(to: CGPoint(x: rect.width, y: 100))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: 0))
            
        }
    }
}


struct CShape1 : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in

            // left side curve...
            
            path.move(to: CGPoint(x: 0, y: 100))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            
        }
    }
}

struct Login : View {
    
    @State var email = ""
    @State var pass = ""
    @Binding var index : Int
    @State var loginSuccess : Bool = false
    @State var showAlert : Bool = false
    
    var body: some View{
        
        ZStack(alignment: .bottom) {
            
            VStack{
                
                HStack{
                    
                    VStack(spacing: 10){
                        
                        Text("Login")
                            .foregroundColor(self.index == 0 ? .white : .gray)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Capsule()
                            .fill(self.index == 0 ? Color.blue : Color.clear)
                            .frame(width: 100, height: 5)
                    }
                    
                    Spacer(minLength: 0)
                }
                .padding(.top, 30)// for top curve...
                
                VStack{
                    
                    HStack(spacing: 15){
                        
                        Image(systemName: "envelope.fill")
                        .foregroundColor(Color("Color1"))
                        
                        TextField("Email Address", text: self.$email)
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 40)
                
                VStack{
                    
                    HStack(spacing: 15){
                        
                        Image(systemName: "eye.slash.fill")
                        .foregroundColor(Color("Color1"))
                        
                        SecureField("Password", text: self.$pass)
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 30)
                
                HStack{
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        
                    }) {
                        
                        Text("Forget Password?")
                            .foregroundColor(Color.white.opacity(0.6))
                    }
                }
                .padding(.horizontal)
                .padding(.top, 30)
            }
            .padding()
            // bottom padding...
            .padding(.bottom, 65)
            .background(Color("Color2"))
            .clipShape(CShape())
            .contentShape(CShape())
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5)
            .onTapGesture {
            
                self.index = 0
                    
            }
            .cornerRadius(35)
            .padding(.horizontal,20)
            
            // Button...
            
            Button(action: {
                login()
            }) {
                
                Text("LOGIN")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .padding(.horizontal, 50)
                    .background(Color("Color1"))
                    .clipShape(Capsule())
                    // shadow...
                    .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
            }
            .alert(isPresented: $loginSuccess) {
                        Alert(title: Text("Login Info"), message: Text("Login Successful"), dismissButton: .default(Text("Got it!")))
            }
            .alert(isPresented: $showAlert) {
                        Alert(title: Text("Login Info"), message: Text("Login Unsuccessful"), dismissButton: .default(Text("Got it!")))
            }
            // moving view down..
            .offset(y: 25)
            .opacity(self.index == 0 ? 1 : 0)
            .navigationDestination(isPresented: $loginSuccess) {
                ContestPage().preferredColorScheme(.light);
            }
            .navigationBarBackButtonHidden(true)
            
        }
    }
    
    func login(){
        //loginSuccess = true
        Auth.auth().signIn(withEmail: email, password: pass){ authResult, error in
            if error != nil {
                print(error?.localizedDescription ?? "hello");
                showAlert = true
            }
            else {
                print("Login Successfull")
                loginSuccess = true
            }
        }
    }
}

// SignUP Page..

struct SignUP : View {
    
    @State var email = ""
    @State var pass = ""
    @State var Repass = ""
    @Binding var index : Int
    @State var LoginSuccess : Bool = false
    @State var showAlart : Bool = false
    
    var body: some View{
        
        ZStack(alignment: .bottom) {
            
            VStack{
                
                HStack{
                    
                    Spacer(minLength: 0)
                    
                    VStack(spacing: 10){
                        
                        Text("SignUp")
                            .foregroundColor(self.index == 1 ? .white : .gray)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Capsule()
                            .fill(self.index == 1 ? Color.blue : Color.clear)
                            .frame(width: 100, height: 5)
                    }
                }
                .padding(.top, 30)// for top curve...
                
                VStack{
                    
                    HStack(spacing: 15){
                        
                        Image(systemName: "envelope.fill")
                        .foregroundColor(Color("Color1"))
                        
                        TextField("Email Address", text: self.$email)
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 40)
                
                VStack{
                    
                    HStack(spacing: 15){
                        
                        Image(systemName: "eye.slash.fill")
                        .foregroundColor(Color("Color1"))
                        
                        SecureField("Password", text: self.$pass)
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 30)
                
                // replacing forget password with reenter password...
                // so same height will be maintained...
                
                VStack{
                    
                    HStack(spacing: 15){
                        
                        Image(systemName: "eye.slash.fill")
                        .foregroundColor(Color("Color1"))
                        
                        SecureField("Password", text: self.$Repass)
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 30)
            }
            .padding()
            // bottom padding...
            .padding(.bottom, 65)
            .background(Color("Color2"))
            .clipShape(CShape1())
            // clipping the content shape also for tap gesture...
            .contentShape(CShape1())
            // shadow...
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5)
            .onTapGesture {
            
                self.index = 1
                    
            }
            .cornerRadius(35)
            .padding(.horizontal,20)
            
            // Button...
            
            Button(action: {
                register()
            }) {
                
                Text("SIGNUP")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .padding(.horizontal, 50)
                    .background(Color("Color1"))
                    .clipShape(Capsule())
                    // shadow...
                    .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
            }
            .alert(isPresented: $showAlart) {
                        Alert(title: Text("Register Info"), message: Text("Register Unsuccessful"), dismissButton: .default(Text("Got it!")))
            }
            // moving view down..
            .offset(y: 25)
            // hiding view when its in background...
            // only button...
            .opacity(self.index == 1 ? 1 : 0)
            .navigationDestination(isPresented: $LoginSuccess) {
                ContestPage().navigationBarBackButtonHidden(true).preferredColorScheme(.light);
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    func register(){
        if pass == Repass{
            Auth.auth().createUser(withEmail: email, password: pass) { authResult, error in
                if error != nil {
                    print(error?.localizedDescription ?? "hello");
                    showAlart = true;
                }
                else {
                    print("successfully register");
                    LoginSuccess = true;
                }
            }
        }
        else {
            print("Register error");
        }
    }
    
    
}

// Home page

// --------------------------------- contest page ---------------------------------

struct ContestPage : View {
    var body: some View{
        
            //Rectangle().frame(width: 1000, height: 1000)
            
            NavigationView(content: {
                List{
                    Section(header:
                                Text("All Contest")
                        .foregroundColor(Color.white)
                    ) {
                        NavigationLink(destination: AllContest()) {
                            HStack{
                                Image("app")
                                    .resizable()
                                    .frame(width: 80, height: 50)
                                    
                                Text("All Future Contest")
                                    .padding(10)
                                    .font(.system(size: 20))
                            }
                        }
                        
                    }
                    Section(header:
                                Text("Individual site Contest")
                        .foregroundColor(Color.white)
                    ) {
                        NavigationLink(destination: CodeforcesContest()) {
                            HStack{
                                Image("CodeForces")
                                    .resizable()
                                    .frame(width: 120, height: 50)
                                    .foregroundColor(Color.white)
                                    
                                Text("CodeForeces")
                                    .padding(10)
                                    .font(.system(size: 20))
                            }
                        }
                        NavigationLink(destination: AtcoderContest()) {
                            HStack{
                                Image("AtCoder")
                                    .resizable()
                                    .frame(width: 80, height: 50)
                                    .padding(.trailing,45)
                                    
                                Text("AtCoder")
                                    .padding(10)
                                    .font(.system(size: 20))
                            }
                        }
                        NavigationLink(destination: CodechefContest()) {
                            HStack{
                                Image("CodeChef")
                                    .resizable()
                                    .frame(width: 120, height: 50)
                                    
                                Text("CodeChef")
                                    .padding(10)
                                    .font(.system(size: 20))
                            }
                        }
                        NavigationLink(destination: HackContest()) {
                            HStack{
                                Image("HackerRank")
                                    .resizable()
                                    .frame(width: 120, height: 50)
                                    
                                Text("HackerRank")
                                    .padding(10)
                                    .font(.system(size: 20))
                            }
                        }
                        NavigationLink(destination: TophContest()) {
                            HStack{
                                Image("Toph")
                                    .resizable()
                                    .frame(width: 80, height: 50)
                                    .padding(.trailing,45)
                                Text("Toph")
                                    .padding(10)
                                    .font(.system(size: 20))
                            }
                        }
                        NavigationLink(destination: TopContest()) {
                            HStack{
                                Image("TopCoder")
                                    .resizable()
                                    .frame(width: 120, height: 50)
                                    
                                Text("TopCoder")
                                    .padding(10)
                                    .font(.system(size: 20))
                            }
                        }
                        NavigationLink(destination: EarthContest()) {
                            HStack{
                                Image("HackerEarth")
                                    .resizable()
                                    .frame(width: 120, height: 50)
                                    
                                Text("HackerEarth")
                                    .padding(10)
                                    .font(.system(size: 20))
                            }
                        }
                        NavigationLink(destination: LeetContest()) {
                            HStack{
                                Image("LeetCode")
                                    .resizable()
                                    .frame(width: 120, height: 50)
                                    
                                Text("LeetCode")
                                    .padding(10)
                                    .font(.system(size: 20))
                            }
                        }
                        NavigationLink(destination: KeekContest()) {
                            HStack{
                                Image("Kick Start")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .padding(.trailing,70)
                                Text("Kick Start")
                                    .padding(10)
                                    .font(.system(size: 20))
                            }
                        }
                    }
                }
                .navigationTitle("Code In Vein")
                .navigationBarTitleDisplayMode(.automatic)
                .navigationBarBackButtonHidden(true)
                .preferredColorScheme(.light)
                .background(Color("Color").edgesIgnoringSafeArea(.all))
            })
            .background(Color("Color").edgesIgnoringSafeArea(.all))
            .navigationBarBackButtonHidden(true)
        
    }
}

struct ContestInfo : Hashable , Codable {
    let name : String
    let url : String
    let start_time : String
    let end_time : String
    let duration : String
    let site : String
    let in_24_hours : String
    let status: String
}

class ViewModel : ObservableObject {
    
    @Published var contestInfo : [ContestInfo] = []
    
    func fetch() {
        guard let url = URL(string:  "https://kontests.net/api/v1/all") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            guard let data = data , error == nil else {
                return
            }
            
            // convert to json
            do {
                let contestInfo = try JSONDecoder().decode([ContestInfo].self, from: data)
                DispatchQueue.main.async {
                    self?.contestInfo = contestInfo
                }
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
}

// All contest Page
struct AllContest : View {
    @StateObject var viewModel = ViewModel()
    var body: some View{
        NavigationView {
            ScrollView{
                
                ForEach(viewModel.contestInfo , id: \.self){ contest in
                    ZStack{
                        RoundedRectangle(cornerRadius: 25)
                            .fill(
                                Color(UIColor.secondarySystemBackground)
                            )
                            .frame(width: 370, height: 200)
                            .padding(5)
                            .shadow(radius: 5)
                        
                        VStack{
                            HStack{
                                Image(contest.site)
                                    .resizable()
                                    .frame(height: 30, alignment: .leading)
                                    .frame(maxWidth: 120)
                                    .padding(.trailing,10)
                                Text(contest.site)
                                Spacer()
                            }
                            .padding([.leading,.trailing],40)
                            Rectangle()
                                .frame(width: 340,height: 3)
                                
                            HStack{
                                Text("Name: ")
                                Spacer()
                                Text(contest.name)
                                
                            }
                            .padding([.leading,.trailing],40)
                            HStack{
                                Text("Start: ")
                                Spacer()
                                Text(contest.start_time)
                                
                            }
                            .padding([.leading,.trailing],40)
                            HStack{
                                Text("End: ")
                                Spacer()
                                Text(contest.end_time)
                                
                            }
                            .padding([.leading,.trailing],40)
                            HStack{
                                Text("Duration: ")
                                Spacer()
                                Text(contest.duration)
                                
                            }
                            .padding([.leading,.trailing],40)
                            
                        }
                            
                    }
                }
            }
            .navigationTitle("All Contest")
            .navigationBarTitleDisplayMode(.automatic)
            
            .onAppear{
                viewModel.fetch()
            }
        }
        //.navigationBarBackButtonHidden(true)
    }
}

// ----------------------------------- codeforces contest ------------------------------------
struct CodeforcesInfo : Hashable , Codable {
    let name : String
    let url : String
    let start_time : String
    let end_time : String
    let duration : String
    let in_24_hours : String
    let status: String
}

class ViewModelCodeforces : ObservableObject {
    
    @Published var contestInfo : [CodeforcesInfo] = []
    
    func fetch() {
        guard let url = URL(string:  "https://kontests.net/api/v1/codeforces") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            guard let data = data , error == nil else {
                return
            }
            
            // convert to json
            do {
                let contestInfo = try JSONDecoder().decode([CodeforcesInfo].self, from: data)
                DispatchQueue.main.async {
                    self?.contestInfo = contestInfo
                }
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
}

struct CodeforcesContest : View {
    @StateObject var viewModel = ViewModelCodeforces()
    var body: some View{
        NavigationView {
            ScrollView{
                
                ForEach(viewModel.contestInfo , id: \.self){ contest in
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 25)
                            .fill(
                                Color(UIColor.secondarySystemBackground)
                            )
                            .frame(width: 370, height: 200)
                            .padding(5)
                            .shadow(radius: 5)
                        
                        VStack{
                            HStack{
                                Image("CodeForces")
                                    .resizable()
                                    .frame(height: 30, alignment: .leading)
                                    .frame(maxWidth: 120)
                                    .padding(.trailing,10)
                                Text("CodeForces")
                                Spacer()
                            }
                            .padding([.leading,.trailing],40)
                            Rectangle()
                                .frame(width: 340,height: 3)
                                
                            HStack{
                                Text("Name: ")
                                Spacer()
                                Text(contest.name)
                                
                            }
                            .padding([.leading,.trailing],40)
                            HStack{
                                Text("Start: ")
                                Spacer()
                                Text(contest.start_time)
                                
                            }
                            .padding([.leading,.trailing],40)
                            HStack{
                                Text("End: ")
                                Spacer()
                                Text(contest.end_time)
                                
                            }
                            .padding([.leading,.trailing],40)
                            HStack{
                                Text("Duration: ")
                                Spacer()
                                Text(contest.duration)
                                
                            }
                            .padding([.leading,.trailing],40)
                            
                        }
                            
                    }
                }
            }
            .navigationTitle("CodeForces")
            .navigationBarTitleDisplayMode(.automatic)
            
            .onAppear{
                viewModel.fetch()
            }
        }
        //.navigationBarBackButtonHidden(true)
    }
}

// --------------------------- AtCoder section ----------------------

struct AtcoderInfo : Hashable , Codable {
    let name : String
    let url : String
    let start_time : String
    let end_time : String
    let duration : String
    let in_24_hours : String
    let status: String
}

class ViewModelAtcoder : ObservableObject {
    
    @Published var contestInfo : [AtcoderInfo] = []
    
    func fetch() {
        guard let url = URL(string:  "https://kontests.net/api/v1/at_coder") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            guard let data = data , error == nil else {
                return
            }
            
            // convert to json
            do {
                let contestInfo = try JSONDecoder().decode([AtcoderInfo].self, from: data)
                DispatchQueue.main.async {
                    self?.contestInfo = contestInfo
                }
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
}

struct AtcoderContest : View {
    @StateObject var viewModel = ViewModelAtcoder()
    var body: some View{
        NavigationView {
            ScrollView{
                
                ForEach(viewModel.contestInfo , id: \.self){ contest in
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 25)
                            .fill(
                                Color(UIColor.secondarySystemBackground)
                            )
                            .frame(width: 370, height: 200)
                            .padding(5)
                            .shadow(radius: 5)
                        
                        VStack{
                            HStack{
                                Image("AtCoder")
                                    .resizable()
                                    .frame(height: 30, alignment: .leading)
                                    .frame(maxWidth: 80)
                                    .padding(.trailing,10)
                                Text("AtCoder")
                                Spacer()
                            }
                            .padding([.leading,.trailing],40)
                            Rectangle()
                                .frame(width: 340,height: 3)
                                
                            HStack{
                                Text("Name: ")
                                Spacer()
                                Text(contest.name)
                                
                            }
                            .padding([.leading,.trailing],40)
                            HStack{
                                Text("Start: ")
                                Spacer()
                                Text(contest.start_time)
                                
                            }
                            .padding([.leading,.trailing],40)
                            HStack{
                                Text("End: ")
                                Spacer()
                                Text(contest.end_time)
                                
                            }
                            .padding([.leading,.trailing],40)
                            HStack{
                                Text("Duration: ")
                                Spacer()
                                Text(contest.duration)
                                
                            }
                            .padding([.leading,.trailing],40)
                            
                        }
                            
                    }
                }
            }
            .navigationTitle("AtCoder")
            .navigationBarTitleDisplayMode(.automatic)
            
            .onAppear{
                viewModel.fetch()
            }
        }
        //.navigationBarBackButtonHidden(true)
    }
}


// ------------------------- CodeChef -------------------------

struct CodeChefInfo : Hashable , Codable {
    let name : String
    let url : String
    let start_time : String
    let end_time : String
    let duration : String
    let in_24_hours : String
    let status: String
}

class ViewModelCodechef : ObservableObject {
    
    @Published var contestInfo : [CodeChefInfo] = []
    
    func fetch() {
        guard let url = URL(string:  "https://kontests.net/api/v1/code_chef") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            guard let data = data , error == nil else {
                return
            }
            
            // convert to json
            do {
                let contestInfo = try JSONDecoder().decode([CodeChefInfo].self, from: data)
                DispatchQueue.main.async {
                    self?.contestInfo = contestInfo
                }
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
}

struct CodechefContest : View {
    @StateObject var viewModel = ViewModelCodechef()
    var body: some View{
        NavigationView {
            ScrollView{
                
                ForEach(viewModel.contestInfo , id: \.self){ contest in
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 25)
                            .fill(
                                Color(UIColor.secondarySystemBackground)
                            )
                            .frame(width: 370, height: 200)
                            .padding(5)
                            .shadow(radius: 5)
                        
                        VStack{
                            HStack{
                                Image("CodeChef")
                                    .resizable()
                                    .frame(height: 30, alignment: .leading)
                                    .frame(maxWidth: 120)
                                    .padding(.trailing,10)
                                Text("CodeChef")
                                Spacer()
                            }
                            .padding([.leading,.trailing],40)
                            Rectangle()
                                .frame(width: 340,height: 3)
                                
                            HStack{
                                Text("Name: ")
                                Spacer()
                                Text(contest.name)
                                
                            }
                            .padding([.leading,.trailing],40)
                            HStack{
                                Text("Start: ")
                                Spacer()
                                Text(contest.start_time)
                                
                            }
                            .padding([.leading,.trailing],40)
                            HStack{
                                Text("End: ")
                                Spacer()
                                Text(contest.end_time)
                                
                            }
                            .padding([.leading,.trailing],40)
                            HStack{
                                Text("Duration: ")
                                Spacer()
                                Text(contest.duration)
                                
                            }
                            .padding([.leading,.trailing],40)
                            
                        }
                            
                    }
                }
            }
            .navigationTitle("Code Chef")
            .navigationBarTitleDisplayMode(.automatic)
            
            .onAppear{
                viewModel.fetch()
            }
        }
        //.navigationBarBackButtonHidden(true)
    }
}


//--------------------------- HackerRank ----------------------------

struct HackInfo : Hashable , Codable {
    let name : String
    let url : String
    let start_time : String
    let end_time : String
    let duration : String
    let in_24_hours : String
    let status: String
}

class ViewModelHack : ObservableObject {
    
    @Published var contestInfo : [HackInfo] = []
    
    func fetch() {
        guard let url = URL(string:  "https://kontests.net/api/v1/hacker_rank") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            guard let data = data , error == nil else {
                return
            }
            
            // convert to json
            do {
                let contestInfo = try JSONDecoder().decode([HackInfo].self, from: data)
                DispatchQueue.main.async {
                    self?.contestInfo = contestInfo
                }
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
}

struct HackContest : View {
    @StateObject var viewModel = ViewModelHack()
    var body: some View{
        NavigationView {
            ScrollView{
                
                ForEach(viewModel.contestInfo , id: \.self){ contest in
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 25)
                            .fill(
                                Color(UIColor.secondarySystemBackground)
                            )
                            .frame(width: 370, height: 200)
                            .padding(5)
                            .shadow(radius: 5)
                        
                        VStack{
                            HStack{
                                Image("HackerRank")
                                    .resizable()
                                    .frame(height: 30, alignment: .leading)
                                    .frame(maxWidth: 120)
                                    .padding(.trailing,10)
                                Text("HackerRank")
                                Spacer()
                            }
                            .padding([.leading,.trailing],40)
                            Rectangle()
                                .frame(width: 340,height: 3)
                                
                            HStack{
                                Text("Name: ")
                                Spacer()
                                Text(contest.name)
                                
                            }
                            .padding([.leading,.trailing],40)
                            HStack{
                                Text("Start: ")
                                Spacer()
                                Text(contest.start_time)
                                
                            }
                            .padding([.leading,.trailing],40)
                            HStack{
                                Text("End: ")
                                Spacer()
                                Text(contest.end_time)
                                
                            }
                            .padding([.leading,.trailing],40)
                            HStack{
                                Text("Duration: ")
                                Spacer()
                                Text(contest.duration)
                                
                            }
                            .padding([.leading,.trailing],40)
                            
                        }
                            
                    }
                }
            }
            .navigationTitle("Hacker Rank")
            .navigationBarTitleDisplayMode(.automatic)
            
            .onAppear{
                viewModel.fetch()
            }
        }
        //.navigationBarBackButtonHidden(true)
    }
}

// -------------------------------- Toph -------------------------------------------
struct TophInfo : Hashable , Codable {
    let name : String
    let url : String
    let start_time : String
    let end_time : String
    let duration : String
    let in_24_hours : String
    let status: String
}

class ViewModelToph : ObservableObject {
    
    @Published var contestInfo : [TophInfo] = []
    
    func fetch() {
        guard let url = URL(string:  "https://kontests.net/api/v1/top_coder") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            guard let data = data , error == nil else {
                return
            }
            
            // convert to json
            do {
                let contestInfo = try JSONDecoder().decode([TophInfo].self, from: data)
                DispatchQueue.main.async {
                    self?.contestInfo = contestInfo
                }
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
}

struct TophContest : View {
    @StateObject var viewModel = ViewModelToph()
    var body: some View{
        NavigationView {
            ScrollView{
                
                ForEach(viewModel.contestInfo , id: \.self){ contest in
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 25)
                            .fill(
                                Color(UIColor.secondarySystemBackground)
                            )
                            .frame(width: 370, height: 200)
                            .padding(5)
                            .shadow(radius: 5)
                        
                        VStack{
                            HStack{
                                Image("Toph")
                                    .resizable()
                                    .frame(height: 30, alignment: .leading)
                                    .frame(maxWidth: 80)
                                    .padding(.trailing,10)
                                Text("Toph")
                                Spacer()
                            }
                            .padding([.leading,.trailing],40)
                            Rectangle()
                                .frame(width: 340,height: 3)
                                
                            HStack{
                                Text("Name: ")
                                Spacer()
                                Text(contest.name)
                                
                            }
                            .padding([.leading,.trailing],40)
                            HStack{
                                Text("Start: ")
                                Spacer()
                                Text(contest.start_time)
                                
                            }
                            .padding([.leading,.trailing],40)
                            HStack{
                                Text("End: ")
                                Spacer()
                                Text(contest.end_time)
                                
                            }
                            .padding([.leading,.trailing],40)
                            HStack{
                                Text("Duration: ")
                                Spacer()
                                Text(contest.duration)
                                
                            }
                            .padding([.leading,.trailing],40)
                            
                        }
                            
                    }
                }
            }
            .navigationTitle("Toph")
            .navigationBarTitleDisplayMode(.automatic)
            
            .onAppear{
                viewModel.fetch()
            }
        }
        //.navigationBarBackButtonHidden(true)
    }
}

// --------------------------------- TopCoder -------------------------

struct TopInfo : Hashable , Codable {
    let name : String
    let url : String
    let start_time : String
    let end_time : String
    let duration : String
    let in_24_hours : String
    let status: String
}

class ViewModelTop : ObservableObject {
    
    @Published var contestInfo : [TopInfo] = []
    
    func fetch() {
        guard let url = URL(string:  "https://kontests.net/api/v1/top_coder") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            guard let data = data , error == nil else {
                return
            }
            
            // convert to json
            do {
                let contestInfo = try JSONDecoder().decode([TopInfo].self, from: data)
                DispatchQueue.main.async {
                    self?.contestInfo = contestInfo
                }
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
}

struct TopContest : View {
    @StateObject var viewModel = ViewModelTop()
    var body: some View{
        NavigationView {
            ScrollView{
                
                ForEach(viewModel.contestInfo , id: \.self){ contest in
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 25)
                            .fill(
                                Color(UIColor.secondarySystemBackground)
                            )
                            .frame(width: 370, height: 200)
                            .padding(5)
                            .shadow(radius: 5)
                        
                        VStack{
                            HStack{
                                Image("TopCoder")
                                    .resizable()
                                    .frame(height: 30, alignment: .leading)
                                    .frame(maxWidth: 120)
                                    .padding(.trailing,10)
                                Text("TopCoder")
                                Spacer()
                            }
                            .padding([.leading,.trailing],40)
                            Rectangle()
                                .frame(width: 340,height: 3)
                                
                            HStack{
                                Text("Name: ")
                                Spacer()
                                Text(contest.name)
                                
                            }
                            .padding([.leading,.trailing],40)
                            HStack{
                                Text("Start: ")
                                Spacer()
                                Text(contest.start_time)
                                
                            }
                            .padding([.leading,.trailing],40)
                            HStack{
                                Text("End: ")
                                Spacer()
                                Text(contest.end_time)
                                
                            }
                            .padding([.leading,.trailing],40)
                            HStack{
                                Text("Duration: ")
                                Spacer()
                                Text(contest.duration)
                                
                            }
                            .padding([.leading,.trailing],40)
                            
                        }
                            
                    }
                }
            }
            .navigationTitle("Top Coder")
            .navigationBarTitleDisplayMode(.automatic)
            
            .onAppear{
                viewModel.fetch()
            }
        }
        //.navigationBarBackButtonHidden(true)
    }
}

//------------------------------- Hacker Earth --------------------------------

struct EarthInfo : Hashable , Codable {
    let name : String
    let url : String
    let start_time : String
    let end_time : String
    let duration : String
    let in_24_hours : String
    let status: String
}

class ViewModelEarth : ObservableObject {
    
    @Published var contestInfo : [EarthInfo] = []
    
    func fetch() {
        guard let url = URL(string:  "https://kontests.net/api/v1/hacker_earth") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            guard let data = data , error == nil else {
                return
            }
            
            // convert to json
            do {
                let contestInfo = try JSONDecoder().decode([EarthInfo].self, from: data)
                DispatchQueue.main.async {
                    self?.contestInfo = contestInfo
                }
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
}

struct EarthContest : View {
    @StateObject var viewModel = ViewModelEarth()
    var body: some View{
        NavigationView {
            ScrollView{
                
                ForEach(viewModel.contestInfo , id: \.self){ contest in
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 25)
                            .fill(
                                Color(UIColor.secondarySystemBackground)
                            )
                            .frame(width: 370, height: 200)
                            .padding(5)
                            .shadow(radius: 5)
                        
                        VStack{
                            HStack{
                                Image("HackerEarth")
                                    .resizable()
                                    .frame(height: 30, alignment: .leading)
                                    .frame(maxWidth: 120)
                                    .padding(.trailing,10)
                                Text("HackerEarth")
                                Spacer()
                            }
                            .padding([.leading,.trailing],40)
                            Rectangle()
                                .frame(width: 340,height: 3)
                                
                            HStack{
                                Text("Name: ")
                                Spacer()
                                Text(contest.name)
                                
                            }
                            .padding([.leading,.trailing],40)
                            HStack{
                                Text("Start: ")
                                Spacer()
                                Text(contest.start_time)
                                
                            }
                            .padding([.leading,.trailing],40)
                            HStack{
                                Text("End: ")
                                Spacer()
                                Text(contest.end_time)
                                
                            }
                            .padding([.leading,.trailing],40)
                            HStack{
                                Text("Duration: ")
                                Spacer()
                                Text(contest.duration)
                                
                            }
                            .padding([.leading,.trailing],40)
                            
                        }
                            
                    }
                }
            }
            .navigationTitle("Hacker Earth")
            .navigationBarTitleDisplayMode(.automatic)
            
            .onAppear{
                viewModel.fetch()
            }
        }
        //.navigationBarBackButtonHidden(true)
    }
}


// ---------------------- LeetCode -----------------------

struct LeetInfo : Hashable , Codable {
    let name : String
    let url : String
    let start_time : String
    let end_time : String
    let duration : String
    let in_24_hours : String
    let status: String
}

class ViewModelLeet : ObservableObject {
    
    @Published var contestInfo : [LeetInfo] = []
    
    func fetch() {
        guard let url = URL(string:  "https://kontests.net/api/v1/leet_code") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            guard let data = data , error == nil else {
                return
            }
            
            // convert to json
            do {
                let contestInfo = try JSONDecoder().decode([LeetInfo].self, from: data)
                DispatchQueue.main.async {
                    self?.contestInfo = contestInfo
                }
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
}

struct LeetContest : View {
    @StateObject var viewModel = ViewModelLeet()
    var body: some View{
        NavigationView {
            ScrollView{
                
                ForEach(viewModel.contestInfo , id: \.self){ contest in
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 25)
                            .fill(
                                Color(UIColor.secondarySystemBackground)
                            )
                            .frame(width: 370, height: 200)
                            .padding(5)
                            .shadow(radius: 5)
                        
                        VStack{
                            HStack{
                                Image("LeetCode")
                                    .resizable()
                                    .frame(height: 30, alignment: .leading)
                                    .frame(maxWidth: 120)
                                    .padding(.trailing,10)
                                Text("LeetCode")
                                Spacer()
                            }
                            .padding([.leading,.trailing],40)
                            Rectangle()
                                .frame(width: 340,height: 3)
                                
                            HStack{
                                Text("Name: ")
                                Spacer()
                                Text(contest.name)
                                
                            }
                            .padding([.leading,.trailing],40)
                            HStack{
                                Text("Start: ")
                                Spacer()
                                Text(contest.start_time)
                                
                            }
                            .padding([.leading,.trailing],40)
                            HStack{
                                Text("End: ")
                                Spacer()
                                Text(contest.end_time)
                                
                            }
                            .padding([.leading,.trailing],40)
                            HStack{
                                Text("Duration: ")
                                Spacer()
                                Text(contest.duration)
                                
                            }
                            .padding([.leading,.trailing],40)
                            
                        }
                            
                    }
                }
            }
            .navigationTitle("Leet Code")
            .navigationBarTitleDisplayMode(.automatic)
            
            .onAppear{
                viewModel.fetch()
            }
        }
        //.navigationBarBackButtonHidden(true)
    }
}


// ---------------------------- keek start -----------------------

struct KeekInfo : Hashable , Codable {
    let name : String
    let url : String
    let start_time : String
    let end_time : String
    let duration : String
    let in_24_hours : String
    let status: String
}

class ViewModelKeek : ObservableObject {
    
    @Published var contestInfo : [KeekInfo] = []
    
    func fetch() {
        guard let url = URL(string:  "https://kontests.net/api/v1/kick_start") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            guard let data = data , error == nil else {
                return
            }
            
            // convert to json
            do {
                let contestInfo = try JSONDecoder().decode([KeekInfo].self, from: data)
                DispatchQueue.main.async {
                    self?.contestInfo = contestInfo
                }
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
}

struct KeekContest : View {
    @StateObject var viewModel = ViewModelKeek()
    var body: some View{
        NavigationView {
            ScrollView{
                
                ForEach(viewModel.contestInfo , id: \.self){ contest in
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 25)
                            .fill(
                                Color(UIColor.secondarySystemBackground)
                            )
                            .frame(width: 370, height: 200)
                            .padding(5)
                            .shadow(radius: 5)
                        
                        VStack{
                            HStack{
                                Image("Kick Start")
                                    .resizable()
                                    .frame(height: 30, alignment: .leading)
                                    .frame(maxWidth: 30)
                                    .padding(.trailing,10)
                                Text("Kick Start")
                                Spacer()
                            }
                            .padding([.leading,.trailing],40)
                            Rectangle()
                                .frame(width: 340,height: 3)
                                
                            HStack{
                                Text("Name: ")
                                Spacer()
                                Text(contest.name)
                                
                            }
                            .padding([.leading,.trailing],40)
                            HStack{
                                Text("Start: ")
                                Spacer()
                                Text(contest.start_time)
                                
                            }
                            .padding([.leading,.trailing],40)
                            HStack{
                                Text("End: ")
                                Spacer()
                                Text(contest.end_time)
                                
                            }
                            .padding([.leading,.trailing],40)
                            HStack{
                                Text("Duration: ")
                                Spacer()
                                Text(contest.duration)
                                
                            }
                            .padding([.leading,.trailing],40)
                            
                        }
                            
                    }
                }
            }
            .navigationTitle("Keek Start")
            .navigationBarTitleDisplayMode(.automatic)
            
            .onAppear{
                viewModel.fetch()
            }
        }
        //.navigationBarBackButtonHidden(true)
    }
}
