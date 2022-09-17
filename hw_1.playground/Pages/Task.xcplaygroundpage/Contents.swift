// Герои и маги обязаны биться с моонстрами, пока не сделают 100 шагов(100 шагов = победа, умрут раньше = поражение) или не победят 10 волн
// Ход = действие мага или героя или монстра
// Исключение для хода мага: Использование магии(неважно удачное или нет) и атака = 1 ход
// После каждой второй волны выпадает бонус
// Враги генирируются рандомно (5 видом отрядов)
// Отряд из героев и магов надо вбивать вручную
protocol BaseCharacter{
    var hp: Int { get set }
    var damage: Int { get set }
}


struct SecretBonus{
    let type: String
    let value: Int
    let character: String
    
    init(){
        let helpTypeNum = Int.random(in: 1...5)
        let helpValueNum = Int.random(in: 1...10)
        let helpTypeCharacter = Int.random(in: 1...3)
        
        if helpTypeNum <= 3{
            self.type = "hpUP"
        }
        else if helpTypeNum == 4{
            self.type = "damageUp"
        }else{
            self.type = "mpUp"
        }
        
        if helpValueNum <= 7{
            self.value = 1
        }
        else if helpValueNum <= 9{
            self.value = 2
        }else {
            self.value = 3
        }
        
        if helpTypeCharacter == 1{
            self.character = "wizard"
        }else{
            self.character = "hero"
        }
    }
}

class Hero: BaseCharacter{
    var name: String
    var hp: Int
    var damage: Int
    var type: HeroType

    init(name: String, type: HeroType){
        self.name = name
        self.type = type
        
        if (type == .archer){
            self.hp = 45
            self.damage = 6
            }
        else if (type == .sworder){
            self.hp = 50
            self.damage = 4
            }
        else{
            self.hp = 10
            self.damage = 1
        }
    }
    
    func attack(defender: Enemy) -> WhoDie{
        defender.hp -= self.damage
        if defender.hp <= 0{
            print("Монстр убит героем \(self.name)")
            return .enemy
        }else{
            print("Герой \(self.name) оставил монстру \(defender.hp) HP")
            return .nobody
        }
    }
}

class Wizard: BaseCharacter{
    var name: String
    var hp: Int
    var mp: Int
    var damage: Int
    var type: WizardType

    init(name: String, type: WizardType){
        self.name = name
        self.type = type
        if (type == .healer){
            self.hp = 20
            self.mp = 2
            self.damage = 2
            }
        else if (type == .damager){
            self.hp = 20
            self.mp = 3
            self.damage = 3
            }
        else if (type == .reflector){
            self.hp = 20
            self.mp = 1
            self.damage = 3
            }
        else{
            self.hp = 10
            self.mp = 1
            self.damage = 1
        }
    }
    
    func useMagic(team: HeroesTeam){
        if self.type == .healer && team.heroes.count >= 1{
            let randomHero = team.heroes[Int.random(in: 0..<team.heroes.count)]
            randomHero.hp += self.damage * self.mp
            print("Маг \(self.name) увеличил HP героя \(randomHero.name) до \(randomHero.hp)")
        }
        else if team.heroes.count == 0{
            self.hp += self.damage
            print("Маг \(self.name) повысил себе HP до \(self.hp), так как героев нету")
        }
        else if self.type == .damager{
            self.damage += 1
            print("Маг \(self.name) повысил себе damage до \(self.damage)")
        }else{
            print("Маг \(self.name) использует магию только против атак противника")
        }
    }
    
    func attack(defender: Enemy) -> WhoDie{
        if self.type == .damager{
            defender.hp -= self.damage * self.mp
        }else{
            defender.hp -= self.damage
        }
        if defender.hp <= 0{
            print("Монстр убит магом \(self.name)")
            return .enemy
        }else{
            print("Маг \(self.name) оставил монстру \(defender.hp) HP")
            return .nobody
        }
    }
}

class Enemy: BaseCharacter{
    var hp: Int
    var damage: Int
    let type: EnemyType
    
    init(type: EnemyType){
        self.type = type
        if type == .wolf{
            self.hp = 3
            self.damage = 1
        }
        else if type == .demon{
            self.hp = 5
            self.damage = 3
        }
        else if type == .demonKing{
            self.hp = 12
            self.damage = 5
        }
        else if type == .ogre{
            self.hp = 10
            self.damage = 1
        }
        else if type == .ogreKing{
            self.hp = 20
            self.damage = 3
        }else{
            self.hp = 1
            self.damage = 0
        }
    }
    
    func attackHero(defender: Hero) -> WhoDie{
        defender.hp -= self.damage
        if defender.hp <= 0{
            print("Герой \(defender.name) убит монстром")
            return .hero
        }else{
            print("Монстр оставил герою \(defender.name) \(defender.hp) HP")
            return .nobody
        }
    }
    
    func attackWizard(defender: Wizard) -> WhoDie{
        if defender.type == .reflector{
            defender.hp -= 3
            self.hp -= self.damage * defender.mp
            if self.hp <= 0 && defender.hp <= 0{
                print("Монстр убит магом \(defender.name)")
                print("Маг \(defender.name) убит монстром")
                return .wizardAndEnemy
            }
            else if self.hp <= 0 && defender.hp > 0{
                print("Монстр убит магом \(defender.name)")
                print("Монстр оставил магу \(defender.name) \(defender.hp) HP")
                return .wizard
            }
            else if  self.hp > 0 && defender.hp <= 0{
                print("Маг \(defender.name) убит монстром")
                print("У монстра осталось \(self.hp) HP после отражения его атаки магом \(defender.name)")
                return .wizard
            }else{
                print("Монстр оставил магу \(defender.name) \(defender.hp) HP")
                print("У монстра осталось \(self.hp) HP после отражения его атаки магом \(defender.name)")
                return .nobody
            }
        }else{
            defender.hp -= self.damage
            if defender.hp <= 0{
                print("Маг \(defender.name) убит монстром")
                return .wizard
            }else{
                print("Монстр оставил магу \(defender.name) \(defender.hp) HP")
                return .nobody
            }
        }
        
    }
}

struct  HeroesTeam{
    var heroes: [Hero]
    var wizards: [Wizard]
    var step = 0
    var fights = 0
    
    init(heroes: [Hero], wizards: [Wizard]){
        self.heroes = heroes
        self.wizards = wizards
    }
    
    func takeBonus(){
        let bonus = SecretBonus()
        if bonus.character == "wizard" && self.wizards.count == 0{
            print("Применить невозможно, все маги умерли")
        }
        else if bonus.character == "wizard" && self.wizards.count > 0{
            if bonus.type == "hpUp"{
                self.wizards[Int.random(in: 0..<self.wizards.count)].hp += bonus.value
                print("Применен бонус на HP")
            }
            else if bonus.type == "damageUp"{
                self.wizards[Int.random(in: 0..<self.wizards.count)].damage += bonus.value
                print("Применен бонус на damage")

            }else{
                self.wizards[Int.random(in: 0..<self.wizards.count)].mp += bonus.value
                print("Применен бонус на MP")
            }
        }
        else if bonus.character == "hero" && self.heroes.count == 0{
            print(("Применить невозможно, все герои умерли"))
        }else{
            if bonus.type == "hpUp"{
                self.heroes[Int.random(in: 0..<self.heroes.count)].hp += bonus.value
                print("Применен бонус на HP")
            }else if bonus.type == "damageUp"{
                self.heroes[Int.random(in: 0..<self.heroes.count)].damage += bonus.value
                print("Применен бонус на damage")
            }else if bonus.type == "mpUp"{
                print("Применить не возможно, у героя нету манны")
            }
            
        }
    }
    mutating func fight( enemies:  inout EnemiesTeam){
        while ((self.heroes.count > 0 || self.wizards.count > 0) && enemies.enemies.count > 0 && self.step < 100){
            let wizardOrHero = Int.random(in: 0...2)
            let randomHeroIndex = Int.random(in: 0..<self.heroes.count)
            let randomHero = self.heroes[randomHeroIndex]

            let randomEnemyIndex = Int.random(in: 0..<enemies.enemies.count)

            if (wizardOrHero % 2 == 1 && self.wizards.count > 0) || (self.heroes.count == 0 && self.wizards.count > 0){
                // Wizard attack
                let randomWizardIndex = Int.random(in: 0..<self.wizards.count)
                let randomWizard = self.wizards[randomWizardIndex]
                
                if self.heroes.count > 0{
                    randomWizard.useMagic(team: self)
                }else{
                    print("Все герои умерли, маги не могут применить магию")
                }
                var result = randomWizard.attack(defender: enemies.enemies[randomEnemyIndex])
                
                if result == .enemy{
                    enemies.enemies.remove(at: randomEnemyIndex)
                    self.step += 1
                }else{
                    result = enemies.enemies[randomEnemyIndex].attackWizard(defender: randomWizard)
                    if result == .wizardAndEnemy{
                        self.wizards.remove(at: randomWizardIndex)
                        enemies.enemies.remove(at: randomEnemyIndex)
                    }else if result == .wizard{
                        self.wizards.remove(at: randomWizardIndex)
                    }
                    self.step += 2
                }
            }
            else if self.heroes.count > 0{
                // Hero attack
                var result = randomHero.attack(defender: enemies.enemies[randomEnemyIndex])
                if result == .enemy{
                    enemies.enemies.remove(at: randomEnemyIndex)
                    self.step += 1
                }else{
                    result = enemies.enemies[randomEnemyIndex].attackHero(defender: randomHero)
                    if result == .hero{
                        self.heroes.remove(at: randomHeroIndex)
                    }
                    self.step += 2
                }
            }
        }
        if self.heroes.count + self.wizards.count > 0{
            self.fights += 1
        }
    }
}

struct EnemiesTeam{
    var enemies: [Enemy]
    
    init(){
        let difficulty = Int.random(in: 1...5)
        if difficulty == 1{
            self.enemies = [Enemy(type: .wolf), Enemy(type: .ogre)]
        }
        else if difficulty == 2{
            self.enemies = [Enemy(type: .ogre), Enemy(type: .demon)]
        }
        else if difficulty == 3{
            self.enemies = [Enemy(type: .ogre), Enemy(type: .ogre), Enemy(type: .ogreKing)]
        }
        else if difficulty == 4{
            self.enemies = [Enemy(type: .demon), Enemy(type: .demon) ,Enemy(type: .demonKing)]
        }
        else if difficulty == 5{
            self.enemies = [Enemy(type: .ogre), Enemy(type: .demon), Enemy(type: .demonKing), Enemy(type: .ogreKing)]
        }else{
            self.enemies = [Enemy(type: .wolf)]
        }
    }
}

enum HeroType{
    case archer
    case sworder
    case assasin
}

enum WizardType{
    case healer
    case damager
    case reflector
}

enum EnemyType{
    case wolf
    case demon
    case demonKing
    case ogre
    case ogreKing
}

enum WhoDie{
    case hero
    case wizard
    case enemy
    case wizardAndEnemy
    case nobody
}


var wizard_1 = Wizard(name: "Мерлин", type: .healer)
var wizard_2 = Wizard(name: "Рон", type: .damager)
var wizard_3 = Wizard(name: "Гарри", type: .reflector)
var hero_1 = Hero(name: "Аста", type: .sworder)
var hero_2 = Hero(name: "Леголас", type: .archer)
var heroesTeam = HeroesTeam(heroes:[hero_1, hero_2], wizards: [wizard_2])

print("Наши бойцы: ")
for hero in heroesTeam.heroes{
    print("Герой: \(hero.name)")
}
for wizard in heroesTeam.wizards{
    print("Маг: \(wizard.name)")
}
print("-------------------------------------------------------------")
print("Игра начинается")
print("-------------------------------------------------------------")
while (heroesTeam.heroes.count + heroesTeam.wizards.count > 0 && heroesTeam.step < 100  && heroesTeam.fights != 10){
    var enemiesTeam = EnemiesTeam()
    if heroesTeam.fights > 0 && heroesTeam.fights % 2 == 0{
        heroesTeam.takeBonus()
    }
    heroesTeam.fight(enemies: &enemiesTeam)
    print("-------------------------------------------------------------")
    print("Отразили \(heroesTeam.fights) волну")
    print("-------------------------------------------------------------")
    if heroesTeam.heroes.count + heroesTeam.wizards.count > 0 && heroesTeam.fights == 10{
        print("Игра закончена, герои и маги победили(отразили 10 волн)")
    }
    else if heroesTeam.step >= 100 && heroesTeam.heroes.count + heroesTeam.wizards.count > 0 {
        print("Игра закончена, герои и маги победили(сделано свыше 100 шагов)")
    }
    else if heroesTeam.heroes.count + heroesTeam.wizards.count == 0 && heroesTeam.step < 100{
        print("Игра закончена, герои и маги проиграли")
    }
}


