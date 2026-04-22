import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = SwipeDeckViewModel()
    
    var body: some View {
        
        ZStack {
            
            if let asset = viewModel.assets.first {
                PhotoCardView(asset: asset)
            } else {
                Text("Loading photos...")
            }
        }
        .onAppear {
            viewModel.loadPhotos()
        }
    }
}