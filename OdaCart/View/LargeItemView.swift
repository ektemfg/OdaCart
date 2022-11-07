import Foundation
import SwiftUI

struct LargeItemView: View {
    let item: Item
    
    var body: some View {
        
        HStack{
                VStack {
                Text(item.product.name)
                        .font(.system(size:20, weight: .medium, design:.rounded))
                        .lineLimit(1)
                Text(item.product.nameExtra ?? "")
                        .font(.system(size:20, weight: .medium, design:.rounded))
                        .lineLimit(1)
                    Spacer()
                AsyncImage(url: URL(string: item.product.images[0].thumbnail.url)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .onTapGesture {
                        
                    }
            }
        placeholder: {
            ProgressView()
            }
                    Text("Pris: " + "kr " + (item.product.grossPrice ?? ""))
                        .font(.system(size:20, weight: .heavy, design:.rounded))
                        .lineLimit(1)
            }
            }
        
        }
    }
