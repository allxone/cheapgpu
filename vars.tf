variable "region" {
    description = "AWS default region"
    default = "us-east-1"
}

variable "instance_type" {
    description = "AWS instance type"
    default = "p2.xlarge"
}

variable "server_port" {
    description = "The port the server will use for HTTP requests"
    default = 8888
}

variable "spot_price" {
    description = "Max spot-price (required)"
}

variable "key_name" {
    description = "Key name"
    default = "terraform"
}