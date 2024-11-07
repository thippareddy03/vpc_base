variable "region" {
    type = object({
      name = string
    })
    description = "This defines the region where it is running"
    default = {
      name = "us-east-1"
    }
  
}