struct Anime{
    var name: String
    var rating: Float
    var series_out: Int
    var series_total: Int
    var studio: String
    var image: String
}

struct Manga{
    var name: String
    var rating: Float
    var  animeAdaptation: Bool
    var publisherImg: String
}

struct DataBase{
    static func getAnime() -> [Anime]{
        let animeList: [Anime] =  [
            Anime(name: "Fullmetal Alchemist: Brotherhood", rating: 9.12, series_out: 64, series_total: 64, studio: "Bones", image: "Fullmetal Alchemist"),
            Anime(name: "Bleach: Sennen Kessen-hen", rating: 9.1, series_out: 2, series_total: 52, studio: "Pierrot", image: "Bleach"),
            Anime(name: "Kaguya-sama wa Kokurasetai: Ultra Romantic", rating: 9.1, series_out: 13, series_total: 13, studio: "A-1 Pictures", image: "Kaguya-sama"),
            Anime(name: "Vinland Saga", rating: 8.73, series_out: 24, series_total: 24, studio: "Wit Studio", image: "Vinland"),
            Anime(name: "Kimi no Suizou wo Tabetai", rating: 8.56, series_out: 1, series_total: 1, studio: "Studio VOLN", image: "Tabetai"),
            Anime(name: "Summertime Render", rating: 8.5, series_out: 25, series_total: 25, studio: "OLM", image: "Summertime Render"),
            Anime(name: "Blue Lock", rating: 8.42, series_out: 2, series_total: 24, studio: "8bit", image: "Blue Lock"),
            Anime(name: "Dr. Stone", rating: 8.3, series_out: 24, series_total: 24, studio: "TMS Entertainment", image: "DrStone"),
            Anime(name: "Isekai Ojisan", rating: 7.94, series_out: 7, series_total: 13, studio: "AtelierPontdarc", image: "Ojisan"),
            Anime(name: "Akuyaku Reijou nanode Last Boss wo Kattemimashita", rating: 7.5, series_out: 4, series_total: 13, studio: "Maho Film", image: "Akuyaku Reijou")
        ]
        return animeList
    }
    
    static func getManga() -> [Manga]{
        let mangaList: [Manga] = [
            Manga(name: "Berserk", rating: 9.46, animeAdaptation: true, publisherImg: "Young Animal"),
            Manga(name: "Vagabond", rating: 9.18, animeAdaptation: false, publisherImg: "Morning"),
            Manga(name: "Vinland Saga", rating: 8.99, animeAdaptation: true, publisherImg: "Afternoon"),
            Manga(name: "Sayonara Eri", rating: 8.74, animeAdaptation: false, publisherImg: "Shounen Jump+"),
            Manga(name: "Solo Leveling", rating: 8.72, animeAdaptation: false, publisherImg: "KakaoPage"),
            Manga(name: "Hunter x Hunter", rating: 8.69, animeAdaptation: true, publisherImg: "Shounen Jump (Weekly)"),
            Manga(name: "Jujutsu Kaisen", rating: 8.55, animeAdaptation: true, publisherImg: "Shounen Jump (Weekly)")
        ]
        return mangaList
    }
}
