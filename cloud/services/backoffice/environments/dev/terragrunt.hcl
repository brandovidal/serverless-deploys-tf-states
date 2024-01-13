include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../src"
}

inputs = {
  bucket_name    = "serverless-deploys"
  lambda_role    = "serverless-backoffice-role"
  handler_dir    = "${path_relative_from_include()}/../../../../app"
}