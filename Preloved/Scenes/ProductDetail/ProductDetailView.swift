import SwiftUI

struct ProductDetailView: View {
    let product: Product
    
    private var productImage: some View {
        AsyncImage(url: product.thumbnail) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
            case .failure:
                Image(systemName: "photo")
                    .font(.title2)
                    .foregroundStyle(.secondary)
            default:
                ProgressView()
            }
        }
        .frame(maxWidth: .infinity, minHeight: 250)
    }
    
    private var title: some View {
        Text(product.title)
            .font(.title2)
            .bold()
            .lineLimit(2)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                productImage

                HStack {
                    title
                    Spacer()
                    FavoriteButton()
                }
                
                PriceTag(price: product.price)
                
                if let brand = product.brand {
                    Text(brand)
                        .foregroundStyle(.secondary)
                }
                
                ExpandableText(text: product.description)
                
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct ExpandableText: View {
    let text: String
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(text)
                .lineLimit(isExpanded ? nil : 3)
            if text.count > 120 {
                Button(isExpanded ? "Show less" : "Read more") {
                    isExpanded.toggle()
                }
            }
        }
    }
}

// TODO: Favorites are not persisted yet. Save them and show them in the product list.
private struct FavoriteButton: View {
    @State private var isFavorite = false
    
    var body: some View {
        Button {
            isFavorite.toggle()
        } label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
        }
    }
}

private struct PriceTag: View {
    let price: Double
    var body: some View {
        Text(PriceFormatter().string(from: price))
            .font(.title3)
            .padding()
            .background(Color(.secondarySystemBackground))
    }
}

#Preview { ProductDetailView(product: .sample()) }

#Preview("Long description") {
    ProductDetailView(product: .sample(
        description: String(repeating: "Barely worn, great condition. Size M. ", count: 7)
    ))
}

#Preview("No brand") { ProductDetailView(product: .sample(brand: nil)) }

#Preview("Long title") {
    ProductDetailView(product: .sample(title: String(repeating: "Denim Jacket ", count: 7)))
}

#Preview("Dark mode") {
    ProductDetailView(product: .sample())
        .preferredColorScheme(.dark)
}
