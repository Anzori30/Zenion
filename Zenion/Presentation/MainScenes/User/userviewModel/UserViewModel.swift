//
//  UserViewModel.swift
//  Zenion
//
//  Created by macbook on 19.04.23.
//

import SwiftUI

class UserViewModel:ObservableObject{
    var Movies = [movie]()
    var imageUrl = "https://scontent.ftbs9-2.fna.fbcdn.net/v/t39.30808-6/313414052_1244872589699573_1129426875842858348_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeFNt0O9g6GLayjav7mSIMTCrsGPhUSfSe-uwY-FRJ9J7_qQxYAtbEYpzUQrJ_cbbn_fulM-5JNjwEfksr1P4oga&_nc_ohc=LS2yP6PY2iEAX-pDUFA&_nc_ht=scontent.ftbs9-2.fna&oh=00_AfAKiTF3RJ2Tvmoev8gep7n26m5dvhN-C-VXRZHA98t3TA&oe=64555DF6"
    @Published var ActivityIndicator = false
    @Published var historyMovies = [movie]()
    var valueToSave = Bool()
    let userName = UserDefaults.standard.string(forKey: "Name") ?? "Unknown"
    let userEmail = UserDefaults.standard.string(forKey: "Email") ?? "Unknown"
    let defaults = UserDefaults.standard
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(MovieNotification(_:)), name:Notification.Name("History"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleMovieNotification(_:)), name:Notification.Name("MovieNotification"), object: nil)
    }
    func logOut(){
        ActivityIndicator = true
        self.valueToSave = false
        self.defaults.set(self.valueToSave, forKey: "isLogined")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            NotificationCenter.default.post(name: NSNotification.Name("LogOut"), object: nil)
        }
    }    // all movies
    @objc func handleMovieNotification(_ notification: Notification) {
        if let movies = notification.object as? [movie] {
            HistoryUpload().printAllHistory()
            Movies = movies
        }
    }
    // history
    @objc func MovieNotification(_ notification: Notification) {
        guard let history = notification.object as? [SaveHistory], !history.isEmpty else { return }
        historyMovies = []
        for savedHistory in history {
            if let movie = Movies.first(where: { $0.name == savedHistory.MovieName }) {
                historyMovies.append(movie)
            }
        }
    }

}
