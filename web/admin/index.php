<?php
	require("../config.header.php");

	require("../news.class.php");

	$news = new news();

	$news->new();


?>
<html>
<title>Sol-1 74 Series Logic Homebrew CPU</title>

<head>
<link rel="stylesheet" href="../styles.css">

</head>

<script>

function changeURL(url){
	window.location.href = url;
}


</script>
<body>


<?php include("../menu.php"); ?>




<table valign="top" align="center" width="900" class="prompt">
	<tr><td><center><b>Post a news</b></center></td></tr>
</table>
<br>
<form action="index.php" method="post">
<table  valign="top" align="center" width="900">
    <tr>
        <td align="right">Title:</td><td><input type="text" name="title" size="81"  class="prompt"></td>
    </tr>
    <tr>
        <td align="right" valign="top">Message:</td><td><textarea name="content" rows="15" cols="80" class="prompt"></textarea></td>
    </tr>
    <tr>
        <td></td>
        <td>
            <input type="submit" value="Send" class="button">
            <input type="hidden" name="action" value="new">
        </td>
    </tr>

</table>

</form>





<?php include("../footer.php"); ?>

</body>

</html>

