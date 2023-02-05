# Provisioning Virtual Private Cloud
![](./images/VPC.PNG)
## VPC
VPC hiểu đơn giản là một mạng ảo nội bộ, nó là một container mà chứa toàn bộ các service của ta bên trong network của nó
Mặc định thì mỗi region của AWS sẽ có một VPC mặc định tên là default. Để tạo một thằng mới, ta dùng resource aws_vpc của Terraform
Ở trên ta sẽ tạo một VPC mới với cidr là 10.0.0.0/16 và tên là Custom. CIDR của VPC sẽ có các giá trị nằm trong khoảng sau:

10.0.0.0/16 -> 10.0.0.0/28
172.16.0.0/16 -> 172.16.0.0/28
192.168.0.0/16 -> 192.168.0.0/28
## Subnet
Subnet sẽ chia VPC của ta ra thành nhiều sub network nhỏ hơn. Mỗi subnet sẽ nằm trong một AZ. Và các service của ta sẽ được launch ở trong subnet này.
![](./images/subnet.PNG)

Dùng aws_subnet của Terraform để tạo subnet.
~~~
main.tf

resource "aws_subnet" "private_subnet_2a" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-2a"

  tags = {
    "Name" = "private-subnet"
  }
}
~~~

```
locals {
  private = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  zone   = ["us-east-2a", "us-east-2b", "us-east-2c"]
}

resource "aws_subnet" "private_subnet" {
  count = length(local.private)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = local.private[count.index]
  availability_zone = local.zone[count.index % length(local.zone)]

  tags = {
    "Name" = "private-subnet"
  }
}
```

## Internet gateway
Để các service bên trong subnet có thể tương tác được với bên ngoài, thì cần phải có internet gateway (IG), và gán IG này vào route table. Sau đó gán subnet nào mà muốn nó có thể tương tác được với internet bên ngoài vào route table này
![](./images/Internet_gateway.PNG)

## NAT Gateway
# Terraform Module
## Standard Module structure
## Using module
## Write modue
## Public module
# Common module
