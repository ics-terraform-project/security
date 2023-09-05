// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0

resource "aws_organizations_policy" "payersandbox" {
  name    = local.scp_name
  content = file(var.json_file)
}

resource "aws_organizations_policy_attachment" "payersandbox" {
  for_each  = toset(var.ou_list)
  policy_id = aws_organizations_policy.payersandbox.id
  target_id = each.value
}

