# 🏛 SwiftArchitectures

Projeto de estudo demonstrando a arquitetura **VIPER** em iOS, com múltiplas cenas (Login, Home, Register) e uma camada **Core** isolando regras de negócio, acesso a dados e integração com **Firebase**.

## 🏛 Arquitetura

```
VIPER + Core Layer

Feature/Scene/
├── Login/
│   ├── LoginViewController   → apresentação e captura de eventos
│   ├── LoginInteractor       → lógica de negócio da cena
│   ├── LoginPresenter        → formata os dados para a View
│   ├── LoginRouter           → navegação entre cenas
│   ├── LoginWorker           → comunicação com serviços externos
│   ├── LoginFactory          → composição e injeção de dependências
│   └── LoginModels           → Request, Response e ViewModel
├── Home/
│   ├── HomeViewController
│   ├── HomeInteractor
│   ├── HomePresenter
│   ├── HomeRouter
│   ├── HomeWorker
│   ├── HomeFactory
│   └── HomeModels
└── Register/
    ├── RegisterViewController
    ├── RegisterInteractor
    ├── RegisterPresenter
    ├── RegisterRouter
    ├── RegisterWorker
    ├── RegisterFactory
    └── RegisterModels

Core/API/
├── Constants   → endpoints e chaves
├── Model       → entidades de domínio (UserModel)
├── Provider    → camada de acesso a dados (UserProvider)
├── Manager     → orquestração de providers (UserManager)
└── Business    → regras de negócio compartilhadas (UserBusiness)

Fluxo
View → Interactor → Worker → Core → Worker → Interactor → Presenter → View
```

## 🛠 Tecnologias

- Swift
- UIKit
- Firebase
- Swift Package Manager
- Swift TEsting

## 🧪 Testes

```
Swift Testing · Spies e Mocks · cobertura nas camadas VIPER

SwiftArchitecturesTests/
└── Feature/
    └── Scene/
        └── Login/
            ├── LoginInteractorTests
            ├── LoginPresenterTests
            └── LoginWorkerTests
```

## 📂 Estrutura de Pastas

```
SwiftArchitectures/
├── Start/
│   ├── AppDelegate
│   └── SceneDelegate
├── Core/
│   └── API/
│       ├── Constants/
│       ├── Model/         → UserModel
│       ├── Provider/      → UserProvider
│       ├── Manager/       → UserManager
│       └── Business/      → UserBusiness
└── Feature/
    └── Scene/
        ├── Login/
        ├── Home/
        └── Register/

SwiftArchitecturesTests/
└── Feature/
    └── Scene/
        └── Login/
```

## 📦 Dependências

```
Firebase · GoogleAppMeasurement · GoogleDataTransport · GoogleUtilities
gRPC · GTMSessionFetcher · abseil · leveldb · nanopb · Promises · SwiftProtobuf
```

## 🚀 Como rodar

1. Clone o repositório
2. Abra o `SwiftArchitectures.xcodeproj`
3. Aguarde o SPM resolver as dependências
4. Rode no simulador
