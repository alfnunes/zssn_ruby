# zssn_ruby
ZSSN (Zombie Survival Social Network)

## Solução
Desenvolvido no formato de ***REST API*** utilizando os padrões de micro serviços no qual contém

Banco de Dados: Postgres

Interface com Banco de Dados: Pgadmin

API: Ruby on Rails

Front: React

## Como Rodar
1-) Instalar o docker em qualquer plataforma OS

2-) Ao clonar o projeto entrar na rais do zssn_ruby onde contém o arquivo docker-compose

3-) Executar ```docker-compose build```

4-) Executar ```docker-compose up```

## Criando Banco de Dados
1-) Executar ``` docker-compose exec zssn-api rake db:migrate```

2-) Para pouplar Executar ``` docker-compose exec zssn-api rake db:seed```

## URL's 
API: http://localhost:3000
Web: http://localhost


## Documentação da API
http://localhost:3000/api-docs/index.html

#Mais

Adicionei a collection do postman com as requests criadas.

