# Implement GitLab CI
Yếu cầu:
- Tài khoản gitlab
Ví dụ: tạo EC2 trên AWS thông qua Gitlab CI.

> Tạo gitlab repository để chứa code, repository sẽ có các file như sau:

- .gitlab-ci.yml
- main.tf
- variables.tf


variables.tf
~~~
variable "region" {
    default = "us-east-2"
}

variable "instance_type" {
  default = "t2.micro"
}
~~~

main.tf

~~~

~~~