include {
  path = path_relative_to_include()
}

terraform {
  source = "../../src"
}

inputs = {
  project_name    = "Derverless Deploys TF States"
  bucket_name    = "serverless-deploys-tf-states"
  lambda_role    = "serverless-deploys-tf-states-role"
}