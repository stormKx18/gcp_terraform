data "local_file" "foo" {
    filename = "input.txt"
} 

output name1{
    value = data.local_file.foo.content
}