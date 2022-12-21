<html>
<title>Sol-1 74 Series Logic Homebrew CPU - 2.5MHz</title>
	
<head>
<meta name="keywords" content="homebrew cpu,homebuilt cpu,ttl,alu,homebuilt computer,homebrew computer,74181,Sol-1, Sol, electronics, hardware, engineering, programming, assembly, cpu, logic">
<link rel="icon" href="http://sol-1.org/images/icon.png">	

</head>

<body>

<?php include("menu.php"); ?>

<header>
<h3><span id="headerSubTitle">C Compiler</span></h3>
</header>


<pre>
I started working on a C compiler for Sol-1. It can already compile a good sub-set
of the C language, but a lot is still missing. I had written a C interpreter a few
years back, and I've always wanted to write a C compiler myself. When I finally
decided to go ahead and start writing this compiler, I took the code from my C interpreter,
adapted it, and turned it into a compiler.

It was amazing how easy it was and how the ideas just poured out of my mind with basically no effort.
The interpreter already had a good lexical parser and all the heavy work had already been done.
All that was required was that instead of executing code, as an interpreter, line by line,
it would generate assembly code instead. And so it does now...

I then use the TASM assembler to create the binary. I will write my own assembler
later on too because even though TASM is very nice, it is also a bit constraining.
An assembler is much easier to write than a compiler anyhow, but for now TASM works.

I will post updates as I go.

<a href="downloads/cc.7z">Sources available here.</a>


15/Jan/2022

</pre>






</body>
</html>

