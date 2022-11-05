import Foundation

struct MyData{
    
    
    let anime: ListSection = {
        .anime([
            .init(title: "1", image: "https://dere.shikimori.one/system/animes/original/5114.jpg", size: CGSize(width: 160, height: 200)),
            .init(title: "2", image: "https://desu.shikimori.one/system/animes/original/43608.jpg", size: CGSize(width: 160, height: 200)),
            .init(title: "3", image: "https://moe.shikimori.one/system/animes/original/41467.jpg", size: CGSize(width: 160, height: 200)),
            .init(title: "4", image: "https://desu.shikimori.one/system/animes/original/9253.jpg", size: CGSize(width: 160, height: 200)),
            .init(title: "5", image: "https://moe.shikimori.one/system/animes/original/28977.jpg", size: CGSize(width: 160, height: 200)),
            .init(title: "6", image: "https://dere.shikimori.one/system/animes/original/38524.jpg", size: CGSize(width: 160, height: 200)),
            .init(title: "7", image: "https://kawai.shikimori.one/system/animes/original/11061.jpg", size: CGSize(width: 160, height: 200)),
            .init(title: "8", image: "https://dere.shikimori.one/system/animes/original/9969.jpg", size: CGSize(width: 160, height: 200)),
            .init(title: "9", image: "https://desu.shikimori.one/system/animes/original/42938.jpg", size: CGSize(width: 160, height: 200)),
            .init(title: "10", image: "https://kawai.shikimori.one/system/animes/original/28851.jpg", size: CGSize(width: 160, height: 200))
        ])
    }()
    
    let wallpaper: ListSection = {
        .wallpaper([
            .init(title: "Chainsaw Man", image: "https://moe.shikimori.one/system/screenshots/original/671b95a264f37f6f0d3e34d32966f013d2e4b4fa.jpg", size: CGSize(width: 350, height: 200)),
            .init(title: "Koe no Katachi", image: "https://dere.shikimori.one/system/screenshots/original/4703c735c143e8804c8ae9e1077ae35d8d7959fc.jpg", size: CGSize(width: 350, height: 200)),
            .init(title: "Fruits Basket: The Final", image: "https://desu.shikimori.one/system/screenshots/original/4895567b7a1593993b0642745e3388e34b1dbc94.jpg", size: CGSize(width: 350, height: 200)),
            .init(title: "Gintama 2", image: "https://kawai.shikimori.one/system/screenshots/original/b693b5148641f11d9e28433429aace6732b41e51.png", size: CGSize(width: 350, height: 200)),
            .init(title: "Hunter x Hunter", image: "https://kawai.shikimori.one/system/screenshots/original/4301300a7be43d44344ec2b9e77280c24d9133f4.jpg", size: CGSize(width: 350, height: 200)),
            .init(title: "Gintama 4", image: "https://nyaa.shikimori.one/system/screenshots/original/63dfb577bf81b31ae8c7d926327512b4cca37588.jpg", size: CGSize(width: 350, height: 200)),
            .init(title: "Steins;Gate", image: "https://dere.shikimori.one/system/screenshots/original/d7a06183cbd282a74d0a4b35bf9b3600416b99f1.jpg", size: CGSize(width: 350, height: 200)),
            .init(title: "Bleach: Sennen Kessen-hen", image: "https://nyaa.shikimori.one/system/screenshots/original/721106db44acdf1a44eb868114c57dbfc74c658c.jpg", size: CGSize(width: 350, height: 200)),
            .init(title: "Kaguya-sama wa Kokurasetai: Ultra ", image: "https://moe.shikimori.one/system/screenshots/original/5ef3130056df892a75a487219680bed96d6c4194.jpg", size: CGSize(width: 350, height: 200)),
            .init(title: "Fullmetal Alchemist: Brotherhood", image: "https://nyaa.shikimori.one/system/screenshots/original/bab2700a71b2b2d1b24a20d3b409d3f18aedd08e.jpg", size: CGSize(width: 350, height: 200))
        ])
    }()
    
    var pageData: [ListSection]{
        [anime, wallpaper]
    }
}




