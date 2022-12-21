<html>
<title>Sol-1 74 Series Logic Homebrew CPU - 2.5MHz</title>
	
<head>
<meta name="keywords" content="homebrew cpu,homebuilt cpu,ttl,alu,homebuilt computer,homebrew computer,74181,Sol-1, Sol, electronics, hardware, engineering, programming, assembly, cpu, logic">
<link rel="icon" href="http://sol-1.org/images/2.jpg">	

</head>

<body>


<?php
	include("menu.php");
?>
<header>
<h3><span id="headerSubTitle">photos</span></h3>
</header>


<table valign="top">
<?php
	$directory = "images/sol";

	if (is_dir($directory)){
	  if ($opendirectory = opendir($directory)){
	    while (($file = readdir($opendirectory)) != false){
	   	if($file != "." && $file != "..")
		    echo "<tr><td><a href=\"images/sol/{$file}\" target=\"_blank\">" . $file . "</td></tr>"; 
	    }
	    closedir($opendirectory);
	  }
	}
?>
		
</table>




</body>
</html>

