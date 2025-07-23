resource "aws_ecr_repository" "app" {
  name = "eyego-repo"
  image_scanning_configuration {
    scan_on_push = true
  }
}

