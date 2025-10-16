resource local_file sample_res {
  filename = "sample.txt"
  sensitive_content  = "I love Terraform"
  file_permission = "0700"
}