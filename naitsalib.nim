
proc print*(args: varargs[string, `$`]) = 
    for s in items(args):
        echo s
