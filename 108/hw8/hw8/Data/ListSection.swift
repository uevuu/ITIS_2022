enum ListSection{
    case anime([ListItem])
    case wallpaper([ListItem])
    
    var items: [ListItem]{
        switch self{
            case .anime(let items), .wallpaper(let items):
            return items
        }
    }
    
    var count: Int{
        items.count
    }
    
    var title: String{
        switch self{
        case .anime(_):
            return "Anime"
        case .wallpaper(_):
            return "Wallpaper"
        }
    }
}
