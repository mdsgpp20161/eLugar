![](http://lappis.unb.br/redmine/attachments/download/3896/logo_elugar_1.3.png)

## O que é o eLugar?

Um software open-source que tem como objetivo permitir que os usuários possam obter informações sobre uma determinada cidade ou compara-la com outra. Nosso público-alvo são pessoas que possuem o desejo de viverem em uma outra cidade, e o eLugar pretende ajuda-lo na escolha. 

## Posso testar a aplicação?

Mas é claro! Ela está disponível [aqui](http://159.203.107.38)

## Com quais tecnologias o eLugar foi construído? 

Utilizamos as tecnologias Ruby, Ruby on Rails, ERB, CSS, JavaScript e Bootstrap para construir o site. Para os testes utilizamos Cucumber e Capybara, para as predições e recomendações com Machine Learning utilizamos a gem Distance Measures.

## Quero contribuir! Quais os próximos passos para o eLugar?

Algumas issues estão listadas no repositório, acreditamos que um gráfico para visualização polar dos atributos, adição de mais atributos(como, por exemplo, do expatistan), a possibilidade de visualizar o crescimento de uma cidade e sua temperatura média, renda per capita e um script para popular todas as cidades com imagens reais. E, claro, você possui a liberdade para fazer o que quiser com o eLugar! :)

## Como instalar o eLugar no meu computador?

O primeiro passo é fazer o download do código. Você pode fazer o download do ZIP dele [aqui](https://github.com/mfurquim/eLugar/archive/master.zip) mas recomendamos que você clone o repositório com o seguinte comando dentro da página em que você gostaria que o projeto fosse armazenado pelo Terminal:

```
git clone git@github.com:mfurquim/eLugar.git
```

Para o próximo passo vamos precisar do Ruby, Ruby on Rails e Bundler instalados. Se você não possuir algum deles, clique [aqui](http://railsinstaller.org/en). Feito isso, precisamos instalar todas as dependências que o eLugar requer. Para isso execute o seguinte comando:

```
bundle install
```

Estamos quase lá, agora precisamos preparar o banco de dados do eLugar. Portanto, execute o seguinte comando para criar as tabelas necessárias:

```
rake db:migrate
```

Se você quiser que cerca de 5000 municípios do Brasil estejam disponíveis para fins de teste, recomendamos o seguinte comando (dependendo do seu computador é comum que demore entre 5 e 20 minutos, então não se desespere):

```
rake db:seed
```

Estamos quase lá! Agora basta ativar o servidor local com o seguinte comando:

```
rails server
```

Pronto! Agora o eLugar provavelmente estará acessível pelo endereço http://localhost:3000. Qualquer dúvida ou problema não hesite em nos procurar pelo GitHub ou via email, os contatos de todos os membros da equipe estão listados ao fim dessa página.

## Quem criou o eLugar?

| Nome | Email |
|------|-------|
| Bruno Amorim   | amorim.software@gmail.com |
| Caio Felipe    | caiofelipe147@gmail.com |
| Eduardo Castro | eduardocastro91@gmail.com |
| Felipe Osório  | felipe.osorio72@outlook.com.br |
| Gustavo Lopes  | gustavo.ldbrito@gmail.com |
| Harrison Pedro | hpedro1195@gmail.com |
| Mateus Andrare | mateusandrade080@gmail.com |
| Mateus Furquim | furquim.axs@gmail.com |
| Marcos Diego | marcos.dsg91@gmail.com |
| Willian Gulgielmin | gulgielmin.w@gmail.com |

Ps. todos são alunos do curso de Engenharia de Software da Universidade de Matéria e o eLugar foi fruto das disciplinas de Métodos de Desenvolvimento de Software e Gestão de Projetos e Portfólios sob tutoria da Professora Carla Rocha.
