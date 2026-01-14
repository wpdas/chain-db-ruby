# Chain DB Ruby

Aplicação Ruby básica sem Rails.

## Estrutura do Projeto

```
chain-db-ruby/
├── lib/              # Código fonte da aplicação
│   ├── config/       # Configurações
│   └── ...
├── spec/             # Testes (RSpec)
├── bin/              # Scripts executáveis
├── Gemfile           # Dependências
├── main.rb           # Ponto de entrada
└── README.md
```

## Instalação

1. Instale as dependências:
```bash
bundle install
```

2. Configure as variáveis de ambiente (opcional):
```bash
cp .env.example .env
# Edite o arquivo .env com suas configurações
```

## Execução

Execute a aplicação:
```bash
ruby main.rb
```

Ou torne o arquivo executável:
```bash
chmod +x main.rb
./main.rb
```

## Desenvolvimento

Execute os testes:
```bash
bundle exec rspec
```

Execute o linter:
```bash
bundle exec rubocop
```

## Versão Ruby

Este projeto requer Ruby ~> 3.2


