import Foundation
import Photos

class SwipeDeckViewModel: ObservableObject {
    
    @Published var assets: [PHAsset] = []
    
    private let service = PhotoLibraryService()
    
    func loadPhotos() {
        
        service.requestAuthorization { granted in
            if granted {
                self.assets = self.service.fetchPhotos()
            }
        }
    }
    
    func removeTopPhoto() {
        if !assets.isEmpty {
            assets.removeFirst()
        }
    }
}