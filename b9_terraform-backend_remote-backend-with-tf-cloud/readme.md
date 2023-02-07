# Implement Terraform Cloud Remote Backend
Để sử dụng remote backend, ta cần phải tạo tài khoản và login vào trong Terraform Cloud.

## Terraform Cloud
Terraform Cloud là một dịch vụ của HashiCorp, nó sẽ giúp ta trong việc quản lý terraform resource một cách dễ dàng và bảo mật hơn. Ngoài ra Terraform Cloud còn giúp ta trong việc xây dựng CI/CD cho infrastructure provisioning một cách rất đơn giản.

Terraform Cloud có ba cách sử dụng là:

- Version control workflow.
- CLI-driven workflow.
- API-driven workflow.
Ta sẽ sử dụng CLI-driven workflow cho remote backend, Version control workflow cho CI/CD.

## Create a account
Đầu tiên để làm việc với Terraform Cloud ta phải tạo tài khoản trước, các bạn truy cập vào link này <https://app.terraform.io/signup/account> để tạo tài khoản.
