//
//  Store.swift
//  motivate
//
//  Created by Rhys Kentish on 27/10/2020.
//

import Foundation

typealias Reducer = (State, Action) -> State

struct State {
    var image: UnsplashImage?
    var quote: String?
}

protocol Action { }

struct GetUnsplashImage: Action {
    
    init() {
        UnsplashService().getRandomPhoto { (result) in
            switch result {
                case .success(let unsplashImage):
                    store.dispatch(action: SetUnplashImage(unsplashImage: unsplashImage))
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}

struct SetUnplashImage: Action {
    let unsplashImage: UnsplashImage
    init(unsplashImage: UnsplashImage) {
        self.unsplashImage = unsplashImage
    }
}

func reducer(state: State, action: Action) -> State {
    var state = state
    switch action {
    case let action as SetUnplashImage:
        state.image = action.unsplashImage
    default:
        break
    }
    
    return state
}

class Store: ObservableObject {
    var reducer: Reducer
    @Published private (set) var state: State
    
    init(reducer: @escaping Reducer, state: State = State()) {
        self.reducer = reducer
        self.state = state
    }
    
    func dispatch(action: Action) {
        DispatchQueue.main.async {
            self.state = self.reducer(self.state, action)
        }
    }
}
