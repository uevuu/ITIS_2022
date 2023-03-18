//
//  DefaultFightService.swift
//  FightingSimulator2999
//
//  Created by Teacher on 18.03.2023.
//

import Foundation
import PlayerServices
import FightingServices
import Combine

class DefaultFightService: FightService {
    let playerService: PlayerService

    init(playerService: PlayerService) {
        self.playerService = playerService
    }

    var _myHealth: CurrentValueSubject<Int, Never> = .init(100)
    var myHealth: AnyPublisher<Int, Never> {
        _myHealth.eraseToAnyPublisher()
    }

    var _enemyHealth: CurrentValueSubject<Int, Never> = .init(100)
    var enemyHealth: AnyPublisher<Int, Never> {
        _enemyHealth.eraseToAnyPublisher()
    }

    /// Restores player and enemy health to 100
    func startFight() {
        _myHealth.value = 100
        _enemyHealth.value = 100
    }

    /// Deals 9 damage to enemy. Enemy attacks back and reduces `myHealth` by 10.
    func basicAttack() {
        _myHealth.value -= 10
        _enemyHealth.value -= 9
    }

    /// Deals 7-15 damage. Enemy attacks back and reduces `myHealth` by 10.
    func magicAttack() {
        _myHealth.value -= 10
        _enemyHealth.value -= .random(in: 7...15)
    }
}
