resource random_integer rint{
    min = 500
    max = 700
}

resource random_string rstring{
    length = 5
}

output name1{
    value = random_integer.rint.result
}

output name2{
    value = random_string.rstring.result
}

