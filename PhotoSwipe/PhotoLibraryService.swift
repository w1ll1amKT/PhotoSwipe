import Foundation
import Photos

class PhotoLibraryService {
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            DispatchQueue.main.async {
                completion(status == .authorized || status == .limited)
            }
        }
    }
    
    func fetchPhotos(limit: Int = 50) -> [PHAsset] {
        
        let options = PHFetchOptions()
        options.sortDescriptors = [
            NSSortDescriptor(key: "creationDate", ascending: false)
        ]
        
        let result = PHAsset.fetchAssets(with: .image, options: options)
        
        var assets: [PHAsset] = []
        
        result.enumerateObjects { asset, _, stop in
            assets.append(asset)
            if assets.count >= limit {
                stop.pointee = true
            }
        }
        
        return assets
    }
}