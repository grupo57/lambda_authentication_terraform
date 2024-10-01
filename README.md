# Projeto Lambda Authentication Terraform

Este projeto utiliza Terraform para provisionar uma função Lambda na AWS, incluindo a criação de uma role IAM necessária para a execução da função.

## Estrutura do Projeto

- `main.tf`: Arquivo principal contendo a definição dos recursos do Terraform.
- `.github/workflows/`: Contém os workflows do GitHub Actions para CI/CD.

## Variáveis

As seguintes variáveis são utilizadas no `main.tf`:

- `environment`: O ambiente para deploy (dev ou prod).

## Workflows do GitHub Actions

### `terraform-merge-prod.yml`

Este workflow é acionado em pushs para a branch `main` e aplica as mudanças no ambiente de produção.

### `terraform-merge-dev.yml`

Este workflow é acionado em pushs para a branch `dev` e aplica as mudanças no ambiente de desenvolvimento.

### `terraform-checks.yml`

Este workflow é acionado em pull requests para as branches `dev` e `main` e realiza verificações de formatação, inicialização, validação e plano do Terraform.

## Variáveis de Ambiente no GitHub Actions

As seguintes variáveis de ambiente podem ser configuradas no GitHub Actions:

Para acesso à AWS:
- `AWS_ACCESS_KEY_ID`: Chave de acesso da AWS (definir em secrets).
- `AWS_SECRET_ACCESS_KEY`: Chave secreta da AWS (definir em secrets).

Configurações para ambiente de desenvolvimento (dev):
- `ENVIRONMENT_DEV`: Ambiente de desenvolvimento (definir em secrets).

Configurações para ambiente de produção (prod):
- `ENVIRONMENT_PROD`: Ambiente de produção (definir em secrets).

## Como Usar

1. Clone o repositório:
    ```sh
    git clone https://github.com/grupo57/lambda_authentication_terraform
    cd lambda_authentication_terraform
    ```

2. Configure as variáveis de ambiente necessárias:
    ```sh
    export AWS_ACCESS_KEY_ID=your_access_key_id
    export AWS_SECRET_ACCESS_KEY=your_secret_access_key
    export AWS_DEFAULT_REGION=your_default_region
    export TF_VAR_environment=your_environment
    ```

3. Inicialize o Terraform:
    ```sh
    terraform init
    ```

4. Selecione o workspace apropriado:
    ```sh
    terraform workspace select dev || terraform workspace new dev
    ```
   ou
    ```sh
    terraform workspace select main || terraform workspace new main
    ```

5. Aplique as mudanças:
    ```sh
    terraform apply -auto-approve
    ```

## Licença

Este projeto está licenciado sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.