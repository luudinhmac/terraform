# Tạo EC2 bằng Terraform
>
> Ngôn ngữ Terraform sử dụng gọi là HashiCorp Configuration Language (HCL).
Các bước ta thực hiện như sau:

1. Viết terraform file.
2. Cấu hình AWS provider.
3. Khỏi tạo Terraform bằng câu lệnh *terraform init*
4. Triển khai EC2 instance bằng câu lệnh *terraform apply*
5. Xóa EC2 bằng câu lệnh *terraform destroy*

![](./images/workflow1.PNG)

> Tạo file *main.tf* với nội dung sau

```
provider "aws" {
  region = "us-east-2"
}
resource "aws_instance" "bai1" {
  ami           = "ami-05bfbece1ed5beb54"
  instance_type = "t2.micro"
  tags = {
    "Name" = "Bai1"
  }
}
```

* Để xem thuộc tính của 1 resource nào đó thì truy cập vào trang
 <https://registry.terraform.io/> để xem

> Ví dụ xem thuộc tính của aws_instance thuộc aws provider
![](./images/awsresource.PNG)
> Chọn tab Documentation
![](./images/awsresource-doc.PNG)
> Tìm kiếm thuộc tính aws_instance
![](./images/awsresource-doc-instance.PNG)

* Mỗi *resorce* đều có giá trị arguments(đầu vào) và attributes(đầu ra) tùy thuộc vào resource type, và attributes sẽ có loại gọi là computed attributes, là những attributes chỉ biết được khi resource đã được tạo ra

![](./images/aws_argument_attribute.PNG)

* Mở *terminal* và nhập *terraform init* , đây là bước bắt buộc khi viết một cấu hình cho một hạ tầng mới, nó sẽ tải code của provider xuống folder hiện tại file main.tf

![](./images/terraform_init.PNG)

* Sau khi init xong thì chạy lệnh *terraform apply -auto-approve* để tạo EC2
![](./images/terraform_apply.PNG)

> Chờ một lúc cho tới khi chạy xong, lên aws console kiểm tra
![](./images/terraform_ec2.PNG)

* Để xóa EC2 thì chạy lệnh *terraform destroy -auto-approve*

![](./images/terraform_destroy.PNG)

> Kiểm tra trên AWS console thì ec2 đã được xóa

# [=> Life cycle resource in terraform](https://github.com/luudinhmac/terraform/tree/master/2.Life-cycle-resource-in-tf)
