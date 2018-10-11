
variable "AWS_REGION" {
  default = "us-east-1"
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "ECS_INSTANCE_TYPE" {
  default = "t2.micro"
}

variable "ECS_AMIS" {
  type = "map"
  default = {
    us-east-1 = "ami-0b9a214f40c38d5eb"
    ca-central-1 = "ami-00d1bdbd447b5933a"
    us-west-2 = "ami-00430184c7bb49914"

  }
}

variable "MYAPP_VERSION" 
  { default = "0" }