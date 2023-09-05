// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0

variable "region" {
  description = "region for deployment"
  type        = string
  default     = "ap-southeast-1"
}

variable "workload_ou" {
  description = "list of workload OUs"
  type        = list(string)
  default     = [ "910191439877" ]
}

# variable "sandbox_ou" {
#   description = "list of sandbox OUs"
#   type        = list(string)
#   default     = [ "918171445319" ]
# }