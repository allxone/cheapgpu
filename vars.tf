variable "instance_type" {
    description = "AWS instance type"
    default = "p2.xlarge"
}

variable "provisioner_key_name" {
    description = "The key name"
    default = "datalab-provisioner"
}

variable "provisioner_key_file" {
    description = "Private key file path for the provisioner_user"
    default = "security/datalab-provisioner.pem"
}

variable "server_port" {
    description = "The port the server will use for HTTP requests"
    default = 8888
}

variable "spot_price" {
    description = "Max spot-price"
}
