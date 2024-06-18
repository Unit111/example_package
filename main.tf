resource "aws_codebuild_project" "example" {
  name          = "example-project"
  description   = "Example project"
  build_timeout = "5"
  service_role  = "arn:aws:iam::299557483172:role/codebuild-example-service-role"

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/Unit111/example_package.git"
    git_clone_depth = 1
    buildspec       = "buildspec.yml"
  }
}

resource "aws_codebuild_webhook" "example" {
  project_name = aws_codebuild_project.example.name
  build_type   = "BUILD"
  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PUSH"
    }
  }
}