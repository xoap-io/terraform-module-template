variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket"

  validation {
    condition     = length(var.bucket_name) > 3 && length(var.bucket_name) < 64
    error_message = "Bucket name must be between 3 and 63 characters."
  }
}

variable "enable_versioning" {
  type        = bool
  default     = false
  description = "Enable versioning for the S3 bucket"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A list of tags to apply to the resource"
}
