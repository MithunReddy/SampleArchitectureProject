<?php
header('Content-Type: application/json');
if ($_GET["page"] == 1)
{
	echo file_get_contents ( "page1.json");
}
else if ($_GET["page"] == 2)
{
	echo file_get_contents ( "page2.json");
}
else if ($_GET["page"] == 3)
{
	echo file_get_contents ( "page3.json");
}
else 
{
		echo file_get_contents ( "nodata.json");

}


?>