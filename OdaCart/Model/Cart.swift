import Foundation

struct Cart: Codable {
    let items: [Item]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
}

struct Item: Codable {
    let product: Product
    let quantity: Int
    let availability: Availability
    let displayPriceTotal, discountedDisplayPriceTotal: String
    
    enum CodingKeys: String, CodingKey {
        case product, quantity, availability
        case displayPriceTotal = "display_price_total"
        case discountedDisplayPriceTotal = "discounted_display_price_total"
    }
}

extension Item: Hashable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id && lhs.quantity == lhs.quantity
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(quantity)
    }
    
    
}


extension Item: Identifiable {
    var id: Int {return product.id}
}

struct Availability: Codable {
    let code: Code
    let availabilityDescription: Description
    let isAvailable: Bool
    let descriptionShort: Description
    
    enum CodingKeys: String, CodingKey {
        case code
        case availabilityDescription = "description"
        case isAvailable = "is_available"
        case descriptionShort = "description_short"
    }
}

enum Description: String, Codable {
    case empty = ""
    case soldOutSupplier = "Utsolgt fra leverandør"
    case soldOut = "Utsolgt"
}

enum Code: String, Codable {
    case available = "available"
    case soldOutSupplier = "sold_out_supplier"
}

enum DescriptionShort: String, Codable {
    case empty = ""
    case utsolgt = "Utsolgt"
}

struct Product: Codable {
    let id: Int
    let name: String
    let brand: String?
    let images: [Imge]
    let brandID: Int?
    let discount: Discount?
    let frontUrl: String
    let fullName: String
    let promotion: Promotion?
    let nameExtra, grossPrice: String?
    let availability: Availability
    let grossUnitPrice: String
    let clientClassifiers: [ClientClassifier]
    let unitPriceQuantityName, unitPriceQuantityAbbreviation: String
    
    enum CodingKeys: String, CodingKey {
        case id,name,brand,images
        case brandID = "brand_id"
        case discount
        case frontUrl = "front_url"
        case fullName = "full_name"
        case promotion
        case nameExtra = "name_extra"
        case grossPrice = "gross_price"
        case availability
        case grossUnitPrice = "gross_unit_price"
        case clientClassifiers = "client_classifiers"
        case unitPriceQuantityName = "unit_price_quantity_name"
        case unitPriceQuantityAbbreviation = "unit_price_quantity_abbreviation"
    }
    
}

struct ClientClassifier: Codable {
    let name: String
    let imageUrl: String
    let isImportant: Bool
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageUrl = "image_url"
        case isImportant = "is_important"
    }
}

struct Imge: Codable {
    let large, thumbnail: Large
    
}

struct Large: Codable {
    let url: String
}

struct Discount: Codable {
    let isDiscounted: Bool?
    let descriptionShort,displayPriceTotal,discountedDisplayPriceTotal,undiscountedGrossPrice : String?
    
    enum CodingKeys: String, CodingKey{
        case isDiscounted
        case descriptionShort = "description_short"
        case displayPriceTotal = "display_price_total"
        case discountedDisplayPriceTotal = "discounted_display_price_total"
        case undiscountedGrossPrice = "undiscounted_gross_price"
    }
}

struct Promotion: Codable {
    let title,textColor,titleColor,backgroundColor: String
    let descriptionShort,accessibilityText : String
    
    enum CodingKeys:String, CodingKey {
        case title
        case textColor = "text_color"
        case titleColor = "title_color"
        case backgroundColor = "background_color"
        case descriptionShort = "description_short"
        case accessibilityText = "accessibility_text"
    }
    
}
