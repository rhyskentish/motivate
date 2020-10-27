//
//  ContentView.swift
//  motivate
//
//  Created by Rhys Kentish on 26/10/2020.
//

import SwiftUI
import URLImage

struct ContentView: View {
    @EnvironmentObject var store: Store

    var urlString: String {
        return store.state.image?.urls.regular ?? "https://images.unsplash.com/photo-1583575140872-3b0982b31f0f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=80"
    }
    
    var body: some View {
        URLImage(url: URL(string: urlString)!,
                         options: URLImageOptions(
                            identifier: "some_Id",      // Custom identifier
                            expireAfter: 60 * 60 * 24,             // Expire after 5 minutes
//                            cachePolicy: .returnCacheElseLoad(cacheDelay: nil, downloadDelay: 0.25) // Return cached image or download after delay
                            cachePolicy: .ignoreCache(delay: 0.25)
                         ),
                         empty: {
                            Text(urlString + " !___ empty")           // This view is displayed before download starts
                         },
                         inProgress: { progress -> Text in  // Display progress
                            if let progress = progress {
                                return Text("Loading...")
                            }
                            else {
                                return Text("Loading...")
                            }
                         },
                         failure: { error, retry in         // Display error and retry button
                            VStack {
                                Text(error.localizedDescription)
                                Button("Retry", action: retry)
                            }
                         },
                         content: { image in                // Content view
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .edgesIgnoringSafeArea(.all)
                         }).onAppear(perform: getRandomImage)
    }
    
    private func getRandomImage() {
        store.dispatch(action: GetUnsplashImage())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
