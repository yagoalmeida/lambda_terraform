# lambda_iac_terraform

Repositório de exemplo para criação de uma lambda function na AWS utilizando Terraform como IaC.

# Introdução

## Tecnologias

| Tecnologia | Versão | Guia de instalação                                                  | Instalação obrigatória |
|------------|--------|---------------------------------------------------------------------|------------------------|
| Terraform  | 1.0.9  | [Link](https://learn.hashicorp.com/tutorials/terraform/install-cli) | Sim                    |
| Python     | 3.8    | [Link](https://www.python.org/downloads/)                           | Sim                    |

## Como utilizar

Esse repositório persiste o estado do Terraform de forma remota, salvando o tfstate em um `s3` na `AWS`, permitindo que
você possa trabalhar em equipe nesse repositório, que também matenha o estado do seus recursos criados via Terraform em
arquivos de estado evitando possíveis conflitos nas alterações desse recurso e que também recupere outputs criados
dentro de outros repositórios de Terraform dentro desse mesmo bucket.

Caso queira entender como efetuar essa configuração basta seguir o passo a passo
desse [repositório](https://github.com/yagoalmeida/shared-storage-terraform-state).

### Executando via actions

* Para que as actions do github funcionem, basta configurar as secrets `AWS_ACCESS_KEY_ID` e `AWS_SECRET_ACCESS_KEY` no
  seu repositório.

### Executando localmente

* Caso queira apenas rodar localmente sem configuração de estado remoto, basta passar o parâmetro `-backend=false` no
  comando `terraform init` ou comentar o arquivo `backend.tf`.
* Executar os comandos abaixo na seguinte ordem:
    * `terraform init -backend=false`
    * `terraform fmt -check`
    * `terraform validate -no-color`
    * `terraform plan -lock=false`
    * `terraform apply -lock=false`

Após isso basta acessar a sua conta na AWS, enviar um evento de teste para sua lambda e partir para as próximas criações
de recursos na Cloud via Terraform :).
