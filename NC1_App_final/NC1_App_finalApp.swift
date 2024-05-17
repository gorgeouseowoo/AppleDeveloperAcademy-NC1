//
//  NC1_App_finalApp.swift
//  NC1_App_final
//
//  Created by KIM SEOWOO on 4/16/24.
//

import SwiftUI
import SwiftData

@main //진입의 시작점
struct NC1_App_finalApp: App {
    //let container = try ModelContainer(for: Promise.self)
    //let container = try ModelContainer(for: [Promise.self], configurations: ModelConfiguration(url: URL("path")))
    
    var body: some Scene {
        WindowGroup {
            ListView()
                .modelContainer(for: [Promise.self])
        }
        
        //for: [Trip.self, LivingAccommodation.self]
    }
}
