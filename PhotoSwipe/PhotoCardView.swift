import SwiftUI
import Photos

struct PhotoCardView: View {
    
    let asset: PHAsset
    let imageManager = PHCachingImageManager()
    
    @State private var image: UIImage?
    
    var body: some View {
        
        ZStack {
            
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
            } else {
                ProgressView()
            }
        }
        .onAppear {
            loadImage()
        }
    }
    
    private func loadImage() {
        
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isSynchronous = false
        
        imageManager.requestImage(
            for: asset,
            targetSize: CGSize(width: 800, height: 800),
            contentMode: .aspectFill,
            options: options
        ) { result, _ in
            self.image = result
        }
    }
}