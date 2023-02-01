# Life cycle của một resource trong Terraform
## Cách khởi tạo source code để viết config file và vòng đời của 1 resource trong Terraform.
* Để tạo provisioning infrastructure mới 
=> Tạo workspace => viết config file => Khởi tạo workspace với *terraform init* => Kiểm tra resource nào được tạo với *terraform plan* => Tạo resource bằng *terraform apply*
![](./images/provisioning_iac.PNG)

* Provisioning infrastructure
** Tạo workspace và viết config
> Tạo workspace đơn giản(folder), tạo 1 file main.tf
```
provider "aws" {
  region = "us-east-2"
}
resource "aws_instance" "server" {
  ami           = "ami-05bfbece1ed5beb54"
  instance_type = "t2.micro"
  tags = {
    "Name" = "server"
  }
}

```

> Chạy câu lệnh *terraform init* để tải aws provider xuống folder hiện tại để terraform có thể sử dụng provider gọi API lên ASW để tạo resource.

>Sau khi init xong, sẽ có một folder tên là .terraform được tạo ra, đây là folder chứa code của provider. Cấu trúc folder sau.
```
├── .terraform
│   └── providers
│       └── registry.terraform.io
│           └── hashicorp
│               └── aws
│                   └── 4.52.0
│                       └── linux_amd64
│                           └── terraform-provider-aws_v4.52.0_x5
├── .terraform.lock.hcl
└── main.tf
```
* Kiểm tra resources nào được tạo ra 
> terraform plan

```
Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.bai1 will be created
  + resource "aws_instance" "bai1" {
      + ami                                  = "ami-05bfbece1ed5beb54"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t2.micro"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = (known after apply)
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + subnet_id                            = (known after apply)
      + tags                                 = {
          + "Name" = "Bai1"
        }
      + tags_all                             = {
          + "Name" = "Bai1"
        }
      + tenancy                              = (known after apply)
      + user_data                            = (known after apply)
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)

      + capacity_reservation_specification {
          + capacity_reservation_preference = (known after apply)

          + capacity_reservation_target {
              + capacity_reservation_id                 = (known after apply)
              + capacity_reservation_resource_group_arn = (known after apply)
            }
        }

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + enclave_options {
          + enabled = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + maintenance_options {
          + auto_recovery = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = (known after apply)
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = (known after apply)
          + instance_metadata_tags      = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_card_index    = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + private_dns_name_options {
          + enable_resource_name_dns_a_record    = (known after apply)
          + enable_resource_name_dns_aaaa_record = (known after apply)
          + hostname_type                        = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't
guarantee to take exactly these actions if you run "terraform apply" now.

```

> Khi chạy câu lệnh plan trên thì nó sẽ hiển thị ra những resouce nào sẽ được tạo, ở dòng hiển thị gần cuối là Plan: 1 to add, 0 to change, 0 to destroy., nghĩa là sẽ có 1 resource được thêm vào infrastructure hiện tại.
> Ngoài việc hiển thị những resource sẽ được tạo, câu lệnh này cũng sẽ kiểm tra lỗi syntax của file terraform config và sẽ báo lỗi nếu không viết đúng syntax.

> Khi có quá nhiều resource và câu lệnh plan bị chậm, có thể tăng tốc nó lên bằng việc thêm vào -parallelism=n. Ví dụ như sau: terraform plan -parallelism=2

Nếu cần lưu lại kết quả của câu lệnh plan, thì sử dụng thêm -out option khi chạy. Ví dụ ta sẽ save lại kết quả của câu lệnh plan trong file json.
```
$terraform plan -out plan.out
$ terraform show -json plan.out > plan.json
```
### Tạo resource
*terraform apply*

* Khi ta chạy câu lệnh apply, thì terraform sẽ chạy câu lệnh plan trước, để review resource, và nó sẽ hiện chỗ để hỏi ta là có muốn tạo những resource này không, chỉ khi đồng ý nhập đúng giá trị này thì resource của mới được tạo ra.

* Lệnh apply cũng chạy plan thì chạy lệnh *terraform plan* trước để làm gì?
> Thì thật ra những câu lệnh trên được thiết kế cho quá trình CI/CD. Có thể chạy câu lệnh plan trước, với -out option, để review resource, sau đó sẽ chạy câu lệnh apply với kết quả của plan trước đó, như sau:

Đầu tiên là sẽ chạy job để kiểm tra resource.

```
terraform plan -out plan.out
```
Nếu mọi thứ ok thì job trên sẽ pass và tiếp theo sẽ chạy job để tạo resource.
```
terraform apply "plan.out"
```
Ok, quay lại câu lệnh apply ở trên, chọn yes để nó tạo EC2 trên AWS.

```
...
Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_instance.hello: Creating...
aws_instance.hello: Still creating... [10s elapsed]
aws_instance.hello: Still creating... [20s elapsed]
aws_instance.hello: Still creating... [30s elapsed]
aws_instance.hello: Still creating... [40s elapsed]
aws_instance.hello: Creation complete after 42s [id=i-0c0285db1ffe968a2]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```
Khi chạy xong sẽ thấy có một file mới được tạo ra là terraform.tfstate.

Đây là file terraform dùng để lưu lại state của tất cả resource, để nó quản lý và track tất cả các resource trên hạ tầng. Nó lưu những giá trị của EC2.
```
{
  "version": 4,
  "terraform_version": "1.0.0",
  "serial": 1,
  "lineage": "fa28c290-92d6-987f-c49d-bc546b296abd",
  "outputs": {},
  "resources": [
    {
      "mode": "managed",
      "type": "aws_instance",
      "name": "hello",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 1,
          "attributes": {
            "ami": "ami-05bfbece1ed5beb54",
            ...
}
```

Để xóa resource thì chạy lệnh *terraform destroy*, khi chạy thì nó cũng sẽ chạy câu lệnh plan trước để liệt kê ra những resource mà nó sẽ xóa, và hỏi  có muốn xóa hay không. Sau khi terraform nó chạy xong, mở file terraform.tfstate lên thì bây giờ trường resources trong file này sẽ là rỗng.

```
{
  "version": 4,
  "terraform_version": "1.0.0",
  "serial": 3,
  "lineage": "fa28c290-92d6-987f-c49d-bc546b296abd",
  "outputs": {},
  "resources": []
}
```

### Ở trên là các bước cần thực hiện để tạo một infrastructure mới. Và bên cạnh việc sử dụng resource block để tạo resource, thì terraform có cung cấp cho một block khác dùng để queries và tìm kiếm data trên AWS, block này sẽ giúp tạo resource một cách linh hoạt hơn là phải điền giá trị cố định của resource. Ví dụ như ở trên thì trường ami của EC2 fix giá trị là ami-05bfbece1ed5beb54, để biết được giá trị này thì phải lên AWS để kiếm, với lại nếu dùng giá trị này thì người khác đọc cũng không biết được giá trị này là thuộc ami loại gì
## Data block

> Terraform cung cấp một block tên là data, được dùng để gọi API lên infrastructure thông qua provider và lấy thông tin về một resource nào đó, block này nó sẽ không thực hiện hành động tạo resource trên infrastructure. Ví dụ: file main.tf trên như sau:
```
provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["746186632829"] # Canonical Ubuntu AWS account id
}

resource "aws_instance" "hello" {
  ami           = data.aws_ami.ubuntu.id # Change here, reference to result of data block instead of fix value
  instance_type = "t2.micro"
  tags = {
    Name = "HelloWorld"
  }
}
```

Ở file trên, dùng data block để gọi API tới AWS Cloud và lấy thông tin về ami (Amazon Machine Images), sau đó ở dưới resource block thay đổi lại trường ami bằng giá trị id lấy được từ data block ở trên ra. Syntax của data block.

![](./images/syntax_data_block.PNG)

Khi chạy câu lệnh plan, sẽ thấy ở dòng Plan gần cuối nó vẫn chỉ hiển thị chỉ 1 resource sẽ được thêm, do data block không tạo ra resource, bên cạnh đó thì ở trường ami nó sẽ in ra giá trị lấy được từ data block.

```
$ terraform plan
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.hello will be created
  + resource "aws_instance" "hello" {
      + ami                                  = "ami-05bfbece1ed5beb54"
      ...
    }

Plan: 1 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you
run "terraform apply" now.
```

![](./images/data_block.PNG)

# Life cycle

> Sau khi làm qua ví dụ ở trên, Terraform là một công cụ để quản lý state thông qua file terraform.tfstate và thực hiện hành động CRUD lên các resource của một infrastructure nào đó, thông thường thì những resource của ta sẽ là cloud-based resources, nhưng terraform không giới hạn ở cloud mà là tất cả những resource nào mà có thể thực hiện CRUD lên nó, đều có thể quản lý thông qua terraform. Ở phần này thì sẽ dùng terraform để tạo một S3 (AWS Simple Cloud Storage) trên AWS để tìm hiểu về vòng đời của một resource

![](./images/lifecycle_s3.PNG)
## Life cycle function hooks
Tất cả các resource type của terraform đều implement một CRUD interface, trong CRUD interface này sẽ có các function hooks là Create(), Read(), Update(), Delete() và function này sẽ được thực thi nếu gặp đúng điều kiện phù hợp.

Còn data type thì nó implement một Read interface chỉ có một function hooks là Read().

![](./images/lifecycle_fuction_hook.PNG)

Create() sẽ được gọi trong quá trình tạo resource, Read() được gọi trong quá trình plan, Update() được gọi trong quá trình cập nhật resource, và Delete() được gọi trong quá trình xóa resource.

## Ví dụ về S3 resource

```
provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "terraform-bucket" {
  bucket = "terraform-series-bucket"

  tags = {
    Name        = "Terraform Series"
  }
}
```