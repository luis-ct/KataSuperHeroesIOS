//
//  SuperHeroesRepository.swift
//  KataSuperHeroes
//
//  Created by Luis Cañadas on 18/03/2017.
//  Copyright © 2017 GoKarumi. All rights reserved.
//

import Foundation

import MarvelAPIClient
import Result

enum SuperHeroError: Error {
    case InvalidSession
    case NetworkError
}

class SuperHeroesRepository {

    let charactersAPIClient: CharactersAPIClient

    var superHeroes: [SuperHero]!

    /**
     * Passing MarvelAPIClientProtocol to testing
     */
    init() {

        MarvelAPIClient.configureCredentials(
            publicKey: "bf1f5d5f088f59478a3f68324fd1face",
            privateKey: "d3fa0b1bad53d48b8bac7b9d4a02a860d24caca0")

        charactersAPIClient = MarvelAPIClient.charactersAPIClient
    }

    func getAll(_ completionHandler: @escaping (Result<[SuperHero], SuperHeroError>) -> Void) {

        charactersAPIClient.getAll(offset: 0, limit: 10, completion: { response in

            var result: Result<[SuperHero], SuperHeroError>

            switch response {
            case .success:
                let characters = response.value?.characters
                print(characters?[0].name ?? "")

                self.superHeroes = (characters?.map({(s1: CharacterDTO) -> SuperHero in
                    return self.wrapperSuperHero(s1)
                }))!
                result = Result.success(self.superHeroes)

            case .failure:
                result = Result.failure(SuperHeroError.NetworkError)
            }

            DispatchQueue.main.async {
                completionHandler(result)
            }
        })
    }

    func getRange(limit: Int, _ completionHandler: @escaping (Result<[SuperHero], SuperHeroError>) -> Void) {

        charactersAPIClient.getAll(offset: superHeroes.count, limit: limit) { response in

            var result: Result<[SuperHero], SuperHeroError>

            switch response {
                case .success:
                    let characters = response.value?.characters
                    print(characters?[0].name ?? "")

                    let newSuperHeroes = (characters?.map({(s1: CharacterDTO) -> SuperHero in
                        return self.wrapperSuperHero(s1)
                    }))!

                    self.superHeroes?.append(contentsOf: newSuperHeroes)
                    result = Result.success(self.superHeroes)

                case .failure:
                    result = Result.failure(SuperHeroError.NetworkError)
            }

            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
    }

    func getById(_ idSuperHero: String, _ completionHandler: @escaping (Result<SuperHero, SuperHeroError>) -> Void) {

        charactersAPIClient.getById(id: idSuperHero) { response in

            var result: Result<SuperHero, SuperHeroError>

            switch response {
            case .success:
                let superHero = self.wrapperSuperHero(response.value!)
                result = Result.success(superHero)

            case .failure:
                result = Result.failure(SuperHeroError.NetworkError)
            }

            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
    }

    private func wrapperSuperHero(_ characterDTO: CharacterDTO) -> SuperHero {

        let str: String = (characterDTO.thumbnail?.path)! + "/detail." + (characterDTO.thumbnail?.format)!
        let url: URL = URL(string: str)!

        return SuperHero(idSuperHero: characterDTO.id, name: characterDTO.name!, photo: url,
						 isAvenger: false, description: characterDTO.description!)
    }
}
