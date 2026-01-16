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

## CLI

Script `chaindb` criado na pasta `bin`.

### Resumo do que foi implementado:

1. Script CLI: `/bin/chaindb` — executável e funcional
2. Comando: `chaindb generate model ModelName field:type ...`
3. Funcionalidades:

- Cria automaticamente a pasta `app/models` se não existir
- Gera arquivos com nome baseado no modelo (downcase + `.rb`)
- Pluraliza o nome da tabela automaticamente (ex: `Message` → `messages`)
- Suporta tipos: `string`, `number`, `array`, `hash`/`object`
- Valores padrão por tipo:
- - string: ''
- - number: nil
- - array: []
- - hash/object: {}

### Exemplo de uso:

`./bin/chaindb generate model Message username:string message:string b64Image:string timestamp:number`
Isso gera o arquivo `app/models/message.rb` com a estrutura especificada.
