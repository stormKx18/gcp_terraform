resource random_integer name{
    min = 2
    max = 150

    lifecycle {
      #create_before_destroy = true
      #prevent_destroy = true
      ignore_changes = [ min ]
    }
}