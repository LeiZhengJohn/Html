<?php

$db = $_GET['db'];
$term = $_GET['term'];

$query = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=".$db."&term=".$term."&retmode=xml";
$curl = curl_init();
curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($curl, CURLOPT_URL, $query);
curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($curl,CURLOPT_HEADER,0);
$output = curl_exec($curl);
if($output === FALSE ){
	
}else{
	$handle = fopen("entrez_results.xml","w");
	fwrite($handle, $output);
	fclose($handle);
}
?>

<html>
<body>
<h1>eSearchResult</h1>
<p><b>Count:</b> <span id="Count"></span><br />
<p><b>RetMax:</b> <span id="RetMax"></span><br />
<p><b>RetStart:</b> <span id="RetStart"></span><br />
<p><b>Id:</b> <span id="Id"></span><br />
<script type="text/javascript">
	if (window.XMLHttpRequest) {
		xmlhttp = new XMLHttpRequest(); 
	}
	else { 
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); 
	}
	xmlhttp.open("GET","entrez_results.xml",false);
	xmlhttp.send();
	xmlDoc = xmlhttp.responseXML;
	document.getElementById("Count").innerHTML=xmlDoc.getElementsByTagName("Count")[0].childNodes[0].nodeValue;
	document.getElementById("RetMax").innerHTML=xmlDoc.getElementsByTagName("RetMax")[0].childNodes[0].nodeValue;
	document.getElementById("RetStart").innerHTML=xmlDoc.getElementsByTagName("RetStart")[0].childNodes[0].nodeValue;
	document.getElementById("Id").innerHTML=xmlDoc.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
</script>
</body>
</html>