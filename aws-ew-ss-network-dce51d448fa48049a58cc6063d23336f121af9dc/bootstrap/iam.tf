locals {
  project_name    = "${var.environment}-${var.service}"
  iam_role_name   = "${local.project_name}-sec-rol-github-deploy-${var.identifier}"
  tf_state_bucket = "${local.project_name}-plat-s3-terraform-state-${data.aws_caller_identity.current.account_id}"
  ddb_table_name  = "${local.project_name}-plat-s3-terraform-locks-${data.aws_caller_identity.current.account_id}"
}

data "aws_caller_identity" "current" {}

data "aws_s3_bucket" "tf_state_bucket" {
  bucket = local.tf_state_bucket
}

data "aws_dynamodb_table" "ddb_table_name" {
  name = local.ddb_table_name
}

# IAM Role for GitHub Deployer
resource "aws_iam_role" "github_deployer" {
  name = local.iam_role_name
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "token.actions.githubusercontent.com:aud" : "sts.amazonaws.com"
          },
          "StringLike" : {
            "token.actions.githubusercontent.com:sub" : "repo:emisgroup/${var.github_repo}:*"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "S3GitHubDeployerPolicy" {
  name = "${local.project_name}-sec-pol-${var.identifier}S3GitHubDeployerPolicy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:CreateBucket",
          "s3:List*",
          "s3:Get*",
          "s3:Describe*",
          "s3:PutObject",
          "s3:PutBucketPolicy",
          "s3:PutEncryptionConfiguration",
          "s3:PutBucketPublicAccessBlock",
          "s3:PutBucketVersioning",
          "s3:PutBucketTagging",
          "s3:PutObjectTagging",
          "s3:PutBucketAcl",
          "s3:PutObjectAcl",
          "s3:PutBucketLifecycle*",
          "s3:DeleteBucket",
          "s3:DeleteObjects",
          "s3:DeleteBucketLifecycle*",
          "s3:DeleteObjectTagging",
          "s3:DeleteBucketTagging"
        ]
        Effect   = "Allow"
        Resource = "*"
        Condition = {
          "StringEquals" = {
            "aws:RequestedRegion" = "${var.aws_region}"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "SecretsGitHubDeployerPolicy" {
  name = "${local.project_name}-sec-pol-${var.identifier}SecretsGitHubDeployerPolicy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "secretsmanager:CreateSecret",
          "secretsmanager:DeleteSecret",
          "secretsmanager:DescribeSecret",
          "secretsmanager:GetResourcePolicy",
          "secretsmanager:ListSecretVersionIds",
          "secretsmanager:ListSecrets",
          "secretsmanager:PutResourcePolicy",
          "secretsmanager:RestoreSecret",
          "secretsmanager:RotateSecret",
          "secretsmanager:TagResource",
          "secretsmanager:UntagResource",
          "secretsmanager:UpdateSecret",
          "secretsmanager:UpdateSecretVersionStage",
          "secretsmanager:ValidateResourcePolicy",
          "secretsmanager:PutSecretValue",
          "secretsmanager:GetSecretValue"
        ]
        Effect   = "Allow"
        Resource = "*"
        Condition = {
          "StringEquals" = {
            "aws:RequestedRegion" = "${var.aws_region}"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "InfraGitHubDeployerPolicy" {
  name = "${local.project_name}-sec-pol-${var.identifier}InfraGitHubDeployerPolicy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogStream",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
          "logs:PutLogEvents",
          "logs:CreateLogGroup",
          "logs:DeleteLogGroup",
          "logs:PutRetentionPolicy",
          "logs:ListTagsLogGroup",
          "logs:CreateLogDelivery",
          "logs:DeleteLogDelivery",
          "logs:DeleteLogStream",
          "logs:GetLogDelivery",
          "logs:GetLogEvents",
          "logs:TagLogGroup",
          "logs:UntagLogGroup",
          "logs:UpdateLogDelivery",
          "logs:UpdateLogDelivery",
          "logs:AssociateKmsKey",
          "logs:ListTagsForResource",
          "logs:UntagResource",
          "logs:TagResource",
          "logs:PutResourcePolicy"
        ]
        Effect   = "Allow"
        Resource = "*"
        Condition = {
          "StringEquals" = {
            "aws:RequestedRegion" = "${var.aws_region}"
          }
        }
      },
      {
        Action = [
          "events:PutRule",
          "events:DescribeRule",
          "events:ListRules",
          "events:DeleteRule",
          "events:ListTagsForResource",
          "events:PutTargets",
          "events:ListTargetsByRule",
          "events:RemoveTargets"
        ]
        Effect   = "Allow"
        Resource = "*"
        Condition = {
          "StringEquals" = {
            "aws:RequestedRegion" = "${var.aws_region}"
          }
        }
      },
      {
        Action = [
          "iam:CreateRole",
          "iam:DeleteRole",
          "iam:PutRolePolicy",
          "iam:AttachRolePolicy",
          "iam:DetachRolePolicy",
          "iam:DeleteRolePolicy",
          "iam:CreateInstanceProfile",
          "iam:DeleteInstanceProfile",
          "iam:AddRoleToInstanceProfile",
          "iam:RemoveRoleFromInstanceProfile",
          "iam:PassRole",
          "iam:TagRole",
          "iam:List*",
          "iam:Get*",
          "iam:CreateServiceLinkedRole",
          "iam:CreateLoginProfile",
          "iam:TagInstanceProfile",
          "iam:CreatePolicy",
          "iam:CreatePolicyVersion",
          "iam:TagPolicy",
          "iam:PutRolePermissionsBoundary",
          "iam:UpdateRole",
          "iam:UpdateRoleDescription",
          "iam:UpdateLoginProfile",
          "iam:UpdateAssumeRolePolicy",
          "iam:SetDefaultPolicyVersion",
          "iam:UpdateAccountPasswordPolicy",
          "iam:DeleteRolePermissionsBoundary",
          "iam:DeleteServiceLinkedRole",
          "iam:UntagRole",
          "iam:DeleteLoginProfile",
          "iam:UntagInstanceProfile",
          "iam:DeleteAccountPasswordPolicy",
          "iam:DeletePolicy",
          "iam:DeletePolicyVersion",
          "iam:DeleteUserPolicy",
          "iam:DetachGroupPolicy",
          "iam:DetachUserPolicy",
          "iam:UntagPolicy"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "sns:CreateTopic",
          "sns:DeleteTopic",
          "sns:ListTagsForResource",
          "sns:TagResource",
          "sns:UntagResource",
          "sns:GetTopicAttributes",
          "sns:SetTopicAttributes",
          "sns:AddPermission",
          "sns:RemovePermission",
          "sns:DeleteTopic",
          "sns:Publish",
          "sns:GetSubscriptionAttributes",
          "sns:ConfirmSubscription",
          "sns:ListSubscriptions",
          "sns:ListSubscriptionsByTopic",
          "sns:SetSubscriptionAttributes",
          "sns:Subscribe",
          "sns:Unsubscribe"
        ]
        Effect   = "Allow"
        Resource = "*"
        Condition = {
          "StringEquals" = {
            "aws:RequestedRegion" = "${var.aws_region}"
          }
        }
      },
      {
        Action = [
          "cloudwatch:DeleteAlarms",
          "cloudwatch:DescribeAlarmHistory",
          "cloudwatch:DescribeAlarms",
          "cloudwatch:DescribeAlarmsForMetric",
          "cloudwatch:DisableAlarmActions",
          "cloudwatch:EnableAlarmActions",
          "cloudwatch:GetMetricData",
          "cloudwatch:GetMetricStatistics",
          "cloudwatch:GetMetricStream",
          "cloudwatch:ListMetricStreams",
          "cloudwatch:ListMetrics",
          "cloudwatch:ListTagsForResource",
          "cloudwatch:PutCompositeAlarm",
          "cloudwatch:PutMetricAlarm",
          "cloudwatch:SetAlarmState",
          "cloudwatch:TagResource",
          "cloudwatch:UntagResource"
        ]
        Effect   = "Allow"
        Resource = "*"
        Condition = {
          "StringEquals" = {
            "aws:RequestedRegion" = "${var.aws_region}"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "KmsGitHubDeployerPolicy" {
  name = "${local.project_name}-sec-pol-${var.identifier}KmsGitHubDeployerPolicy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "kms:DescribeKey",
          "kms:GetKeyPolicy",
          "kms:List*",
          "kms:GetKeyRotationStatus",
          "kms:CreateAlias",
          "kms:CreateKey",
          "kms:TagResource",
          "kms:EnableKeyRotation",
          "kms:PutKeyPolicy",
          "kms:UpdateKeyDescription",
          "kms:UntagResource",
          "kms:Encrypt",
          "kms:GenerateDataKey",
          "kms:GenerateDataKeyPair",
          "kms:Decrypt",
          "kms:UpdateAlias",
          "kms:DeleteAlias"
        ]
        Effect   = "Allow"
        Resource = "*"
        Condition = {
          "StringEquals" = {
            "aws:RequestedRegion" = "${var.aws_region}"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "EC2GitHubDeployerPolicy" {
  name = "${local.project_name}-sec-pol-${var.identifier}EC2GitHubDeployerPolicy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
          "ec2:Get*",
          "ec2:Create*",
          "ec2:AttachNetworkInterface",
          "ec2:UpdateSecurityGroupRuleDescriptionsEgress",
          "ec2:UpdateSecurityGroupRuleDescriptionsIngress",
          "ec2:AuthorizeSecurityGroupEgress",
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:ModifySecurityGroupRules",
          "ec2:AttachInternetGateway",
          "ec2:DetachInternetGateway",
          "ec2:AssociateRouteTable",
          "ec2:DisassociateRouteTable",
          "ec2:ReplaceRoute",
          "ec2:ReplaceRouteTableAssociation",
          "ec2:AssociateSubnetCidrBlock",
          "ec2:DisassociateSubnetCidrBlock",
          "ec2:ModifySubnetAttribute",
          "ec2:AssociateVpcCidrBlock",
          "ec2:DisassociateVpcCidrBlock",
          "ec2:ModifyInstanceAttribute",
          "ec2:ModifyVpcAttribute",
          "ec2:ModifyVpcTenancy",
          "ec2:AllocateAddress",
          "ec2:RunInstances",
          "ec2:AssociateIamInstanceProfile",
          "ec2:ReplaceIamInstanceProfileAssociation",
          "ec2:AssociateAddress",
          "ec2:DisassociateAddress",
          "ec2:ModifyAddressAttribute",
          "ec2:MoveAddressToVpc",
          "ec2:ReleaseAddress",
          "ec2:ResetAddressAttribute",
          "ec2:RestoreAddressToClassic",
          "ec2:DetachNetworkInterface",
          "ec2:ModifyNetworkInterfaceAttribute",
          "ec2:ResetNetworkInterfaceAttribute",
          "ec2:DeleteSecurityGroup",
          "ec2:RevokeSecurityGroupEgress",
          "ec2:RevokeSecurityGroupIngress",
          "ec2:DeleteTags",
          "ec2:DeleteEgressOnlyInternetGateway",
          "ec2:DeleteInternetGateway",
          "ec2:DeleteRoute",
          "ec2:DeleteRouteTable",
          "ec2:DeleteVpc",
          "ec2:DeleteFlowLogs",
          "ec2:DeleteSubnet",
          "ec2:DeleteNatGateway",
          "ec2:DeleteNetworkInterface",
          "ec2:DeleteNetworkInterfacePermission",
          "ec2:DeleteLaunchTemplate",
          "ec2:TerminateInstances",
          "ec2:StopInstances",
          "ec2:StartInstances",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DisassociateIamInstanceProfile",
          "ec2:DeleteVpcEndpoints",
          "ec2:DescribeVpcEndpoints",
          "ec2:DescribeVpcEndpointServices",
          "ec2:ModifyVpcEndpoint",
          "ec2:ModifyVpcEndpointServicePermissions",
          "ec2:MonitorInstances",
          "ec2:UnmonitorInstances",
          "ec2:AssociateDhcpOptions",
          "ec2:CreateDhcpOptions",
          "ec2:DeleteDhcpOptions",
          "ec2:ImportKeyPair",
          "ec2:CreateTransitGatewayVpcAttachment",
          "ec2:DeleteTransitGatewayVpcAttachment",
          "ec2:DescribeTransitGatewayAttachments",
          "ec2:DescribeTransitGateways",
          "ec2:DescribeTransitGatewayVpcAttachments",
          "ec2:ModifyTransitGatewayVpcAttachment",
          "ec2:CreateVpcPeeringConnection",
          "ec2:DeleteVpcPeeringConnection",
          "ec2:DescribeVpcPeeringConnections",
          "ec2:ModifyVpcPeeringConnectionOptions",
          "ec2:DeleteNetworkAclEntry"
        ]
        Effect   = "Allow"
        Resource = "*"
        Condition = {
          "StringEquals" = {
            "aws:RequestedRegion" = "${var.aws_region}"
          }
        }
      },
      {
        Action = [
          "route53:Get*",
          "route53:List*",
          "route53:DisassociateVPCFromHostedZone",
          "route53:AssociateVPCWithHostedZone",
          "route53:ChangeTagsForResource",
          "route53:ChangeResourceRecordSets",
          "route53:CreateHostedZone",
          "route53:CreateVPCAssociationAuthorization",
          "route53resolver:DisassociateResolverRule",
          "route53resolver:ListResolverRules",
          "route53resolver:GetResolverRuleAssociation",
          "route53resolver:AssociateResolverRule",
          "route53resolver:GetResolverRule",
          "route53resolver:ListResolverEndpointIpAddresses",
          "route53resolver:GetResolverEndpoint",
          "route53resolver:TagResource",
          "route53resolver:CreateResolverEndpoint",
          "route53resolver:ListTagsForResource",
          "route53resolver:CreateResolverRule",
          "route53resolver:ListResourceRecordSets",
          "route53resolver:UpdateResolverRule"
        ]
        Effect   = "Allow"
        Resource = "*"
        Condition = {
          "StringEquals" = {
            "aws:RequestedRegion" = "${var.aws_region}"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "Route53GitHubDeployerPolicy" {
  name = "${local.project_name}-sec-pol-${var.identifier}Route53GitHubDeployerPolicy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "route53:Describe*",
          "route53:Get*",
          "route53:Create*",
          "route53:List*",
          "route53:ChangeResourceRecordSets",
          "route53:AssociateVPCWithHostedZone",
          "route53:ChangeTagsForResource",
          "route53:DisassociateVPCFromHostedZone"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "RemoteStateGitHubDeployerPolicy" {
  name = "${local.project_name}-sec-pol-${var.identifier}RemoteStateGitHubDeployerPolicy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:ListBucket"
        ]
        Effect   = "Allow"
        Resource = data.aws_s3_bucket.tf_state_bucket.arn
      },
      {
        Action = [
          "s3:*Object"
        ]
        Effect   = "Allow"
        Resource = data.aws_s3_bucket.tf_state_bucket.arn
      },
      {
        Action = [
          "dynamodb:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "SSMGitHubDeployerPolicy" {
  name = "${local.project_name}-sec-pol-${var.identifier}SSMGitHubDeployerPolicy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ssm:Describe*",
          "ssm:List*",
          "ssm:DeleteDocument",
          "ssm:CreateDocument",
          "ssm:DescribeDocument",
          "ssm:DeleteAssociation",
          "ssm:DescribeAssociation",
          "ssm:CreateAssociation",
          "ssm:DescribeDocumentPermission",
          "ssm:GetDocument",
          "ssm:AddTagsToResource",
          "ssm:ListTagsForResource",
          "ssm:RemoveTagsFromResource",
          "ssm:UpdateDocument",
          "ssm:UpdateAssociation",
          "ssm:UpdateDocumentDefaultVersion"
        ]
        Effect   = "Allow"
        Resource = "*"
        Condition = {
          "StringEquals" = {
            "aws:RequestedRegion" = "${var.aws_region}"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "Route53GitHubDeployerPolicy-attach" {
  role       = aws_iam_role.github_deployer.name
  policy_arn = aws_iam_policy.Route53GitHubDeployerPolicy.arn
}

resource "aws_iam_role_policy_attachment" "S3GitHubDeployerPolicy-attach" {
  role       = aws_iam_role.github_deployer.name
  policy_arn = aws_iam_policy.S3GitHubDeployerPolicy.arn
}

resource "aws_iam_role_policy_attachment" "SecretsGitHubDeployerPolicy-attach" {
  role       = aws_iam_role.github_deployer.name
  policy_arn = aws_iam_policy.SecretsGitHubDeployerPolicy.arn
}

resource "aws_iam_role_policy_attachment" "InfraGitHubDeployerPolicy-attach" {
  role       = aws_iam_role.github_deployer.name
  policy_arn = aws_iam_policy.InfraGitHubDeployerPolicy.arn
}

resource "aws_iam_role_policy_attachment" "KmsGitHubDeployerPolicy-attach" {
  role       = aws_iam_role.github_deployer.name
  policy_arn = aws_iam_policy.KmsGitHubDeployerPolicy.arn
}

resource "aws_iam_role_policy_attachment" "EC2GitHubDeployerPolicy-attach" {
  role       = aws_iam_role.github_deployer.name
  policy_arn = aws_iam_policy.EC2GitHubDeployerPolicy.arn
}

resource "aws_iam_role_policy_attachment" "RemoteStateGitHubDeployerPolicy-attach" {
  role       = aws_iam_role.github_deployer.name
  policy_arn = aws_iam_policy.RemoteStateGitHubDeployerPolicy.arn
}

resource "aws_iam_role_policy_attachment" "SSMGitHubDeployerPolicy-attach" {
  role       = aws_iam_role.github_deployer.name
  policy_arn = aws_iam_policy.SSMGitHubDeployerPolicy.arn
}
