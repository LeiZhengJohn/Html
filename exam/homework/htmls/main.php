<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
	<meta charset="utf-8">
	<title>coder主页</title>
	<link rel="stylesheet" type="text/css" href="../mystyle.css" />
	<style  type="text/css">
	#map{
		height: 600px;
		width: 800px;
		border: 1px solid black;
	}	
</style>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=V5BndarzXzYmeCkrZdv0YvryEGFRubBu"></script>
<script type="text/javascript">    
	
	var map = new BMap.Map("map");    
	var point = new BMap.Point(116.709684,39.89778);  
	map.centerAndZoom(point, 20);    
	map.enableScrollWheelZoom();   
	
	var geolocation = new BMap.Geolocation();  
	geolocation.getCurrentPosition(function(r){  
		if(this.getStatus() == BMAP_STATUS_SUCCESS){  
			var mk = new BMap.Marker(r.point);  
			map.addOverlay(mk);  
			map.panTo(r.point);
		}  
		else {  
			alert('failed'+this.getStatus());  
		}          
	},{enableHighAccuracy: true})  
	
	
</script> 
<script language="javascript">
	window.onload = function(){
		alert("欢迎进入本网页");
	};
	window.onbeforeunload = function() {
		return confirm("确定退出吗");
	}
</script>
<script type="text/javascript" src="https://www.ncbi.nlm.nih.gov/core/jig/1.14.8/js/jig.min.js"></script>
<script type="text/javascript">
	jQuery(document).ready(function ($) {
				// Manage database changes
				function update_db() {
					var db = $("#database")
					db.closest("form").attr("action", "https://www.ncbi.nlm.nih.gov/" + db.val() + "/");
				}

				$("#database").change(update_db);
				$("#term").blur(update_db).keypress(update_db);
				$("#search").click(update_db).keypress(update_db);
			});
		</script>
		<script src="../jquery-3.2.1.js"></script>
		<script language="javascript">
			$(document).ready(function(){  
				$("#link-2").click(function(event){
					event.preventDefault();
					$("#content-middle").load("interduction.html");
				});
				$("#link-3").click(function(event){
					event.preventDefault();
					$("#content-middle").load("sources.html");
				});
				$("#link-4").click(function(event){
					event.preventDefault();
					$("#content-middle").load("codes.html");
				});
				$("#link-5").click(function(event){
					event.preventDefault();
					$("#content-middle").load("community.html");
				});
				$("#link-6").click(function(event){
					event.preventDefault();
					$("#content-middle").load("link.html");
				});
				$("#link-7").click(function(event){
					event.preventDefault();
					$("#content-middle").load("aboutus.html");
				});
			});
		</script>
	</head>

	<body>
		<div id="container">
			<div id="header-left">
				<div id="header-left-h"><h1 id="main" class="font2">献给热爱IT的你</h1></div>
				<div id="header-left-logo"><img id="mainbg" src="../images/logo.png" width="190" height="40" /></div>
				
			</div>
			<div id="header-right">
				<?php

					session_start();
					if(!isset($_SESSION['username']) or $_SESSION['username'] == ''){
						$_SESSION['username'] = 'guest';
					}
					
					if($_SESSION['username'] == 'guest'){
						echo '<p style="color: aliceblue;text-align: center">欢迎您：访客';
						echo '<a href="login.html" style="color:green;">(登录</a>)';
						echo '<a href="register.html" style="color:green;">(注册</a>)</p>';
					}else{
						echo '<p style="color: aliceblue;text-align: center">欢迎您：'.$_SESSION['username'];
						echo '<a href="logout.php" style="color:green;">(注销</a>)';
						echo '<a href="ModifyPassword.html" style="color:green;">(修改密码</a>)';
						echo '<a href="WebEditor.php" target="_blank" style="color:green;">(编辑</a>)</p>';
					}

				?>
								
					
				
			</div>
			<div id="menu">
				<ul>
					<li><a class="link1" href="main.php" id="link-1">本站主页</a></li>
					<li><a class="link1" href="" id="link-2">关于本站</a></li>
					<li><a class="link1" href="" id="link-3">学习资源</a></li>
					<li><a class="link1" href="" id="link-4">代码共享</a></li>
					<li><a class="link1" href="" id="link-5">交流讨论</a></li>
					<li><a class="link1" href="" id="link-6">友情链接</a></li>
					<li><a class="link1" href="" id="link-7">关于我们</a></li>
				</ul>
			</div>
			<div id="content">
				<div id="content-up">
					<div id="content-up-l">
						<form action="">
							<select name="type" id="type">
								<option id="source">资源</option>
								<option id="question">问题</option>
								<option id="code">代码</option>
							</select>
							<select name="language" id="language">
								<option id="java">Java</option>
								<option id="C">C</option>
								<option id="C++">C++</option>
							</select>
							<input type="text" id="search1" name="search1">
							<input type="submit" value="搜索">
						</form>
					</div>
					<div id="content-up-r">
						<form name="f" id="form" action="http://www.baidu.com/s" class="fm" onSubmit="javascript:F.call('ps/sug','pssubmit');" target="_blank">
							<input type="text" class="s_ipt" name="wd" id="kw" maxlength="100" autocomplete="off" />
							<input type="submit" value="百度一下" id="su" class="btn self-btn bg s_btn"> 
						</form>
					</div>
				</div>
				<div id="content-middle"></div>
				<div id="content-down">
					<form method="get" action="/gquery/" id="searchform"  autocomplete="off">
						<label for="database" class="offscreen_noflow">Search database</label>
						<select id="database"><option value="gquery">All Databases</option><option value="assembly">Assembly</option><option value="biocollections">Biocollections</option><option value="bioproject">BioProject</option><option value="biosample">BioSample</option><option value="biosystems">BioSystems</option><option value="books">Books</option><option value="clinvar">ClinVar</option><option value="clone">Clone</option><option value="cdd">Conserved Domains</option><option value="gap">dbGaP</option><option value="dbvar">dbVar</option><option value="nucest">EST</option><option value="gene">Gene</option><option value="genome">Genome</option><option value="gds">GEO DataSets</option><option value="geoprofiles">GEO Profiles</option><option value="nucgss">GSS</option><option value="gtr">GTR</option><option value="homologene">HomoloGene</option><option value="ipg">Identical Protein Groups</option><option data-ac_dict="medgen_disease_name" value="medgen">MedGen</option><option data-ac_dict="mesh_suggestions" value="mesh">MeSH</option><option value="ncbisearch">NCBI Web Site</option><option value="nlmcatalog">NLM Catalog</option><option value="nuccore">Nucleotide</option><option value="omim">OMIM</option><option value="pmc">PMC</option><option value="popset">PopSet</option><option value="probe">Probe</option><option value="protein">Protein</option><option value="proteinclusters">Protein Clusters</option><option value="pcassay">PubChem BioAssay</option><option value="pccompound">PubChem Compound</option><option value="pcsubstance">PubChem Substance</option><option data-ac_dict="pm_related_queries_2" value="pubmed">PubMed</option><option value="pubmedhealth">PubMed Health</option><option value="snp">SNP</option><option value="sparcle">Sparcle</option><option value="sra">SRA</option><option value="structure">Structure</option><option value="taxonomy">Taxonomy</option><option value="toolkit">ToolKit</option><option value="toolkitall">ToolKitAll</option><option value="toolkitbook">ToolKitBook</option><option value="toolkitbookgh">ToolKitBookgh</option><option value="unigene">UniGene</option></select>
						<label for="term" class="offscreen_noflow" accesskey="/">Search term</label>
						<input type="text" name="term" id="term" title="Search All Databases" value="" class="jig-ncbiclearbutton jig-ncbiautocomplete" data-jigconfig="isEnabled:false,disableUrl:'NcbiSearchBarAutoComplCtrl'" autocomplete="off" data-sbconfig="ds:'no',pjs:'no',afs:'yes'" aria-haspopup="true" aria-autocomplete="list" role="textbox"/>
						<button id="search" type="submit" class="button_search nowrap" cmd="go" formtarget="_blank">Search</button>
						<button class="button_search nowrap"><a id="adsearch" href="-entrez.html" target="_blank">高级搜索</a></button>

					</form>

				</div>
				
			</div>
			<div id="footer">
				Copyright 网站素材均来源于网络
				<audio controls="controls" autoplay="autoplay" loop="loop" hidden="hidden">
				  <source src="../music/music-1.mp3" type="audio/mpeg">
					Your browser does not support the audio tag.
				</audio>
			</div>
		</div>
	</body>
	</html>
