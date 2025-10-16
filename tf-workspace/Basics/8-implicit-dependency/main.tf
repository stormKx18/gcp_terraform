resource local_file sample_res {
  filename = "sample.txt"
  content  = "My content is random ${random_string.rstring.id}"
  depends_on = [random_string.rstring] /*Explicit dependecy*/
}
resource random_string rstring{
    length = 10
}
