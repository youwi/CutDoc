<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="utf-8">
<meta http-equiv="Content-Language" content="zh-CN">
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/jqueryUI/jquery-ui.css" rel="stylesheet">
<script src="resources/js/jquery.js"></script>
<script src="resources/js/bootstrap.min.js"></script>
<script src="resources/jqueryUI/jquery-ui.js"></script>

	
</script>
</head>
<body>
<!-- 自动书签 by 
	yuzhencheng314@pingan.com 
-->


<style>
  #draggable, #draggable2, #draggable3 { width: 100px; height: 100px; padding: 0.5em; float: left; margin: 0 10px 10px 0; }
  </style>
  
	<div id="draggable" class="ui-widget-content">
		<p>auto</p>
	</div>

	<div id="draggable2" class="ui-widget-content">
		<p>note window</p>
	</div>

	<script>
		setInterval("autoSave()",10000);

		$(function() {
			$("#draggable").draggable({
				scroll : true
			});
			$("#draggable2").draggable({
				scroll : true,
				scrollSensitivity : 100
			});
			$("#draggable3").draggable({
				scroll : true,
				scrollSpeed : 100
			});
		});
		
		function autoSave(){
			var list = new Array();
			$(".ui-widget-content").each(function(i, value) {
						var pp=new Object();
						pp.left=$(this).css("left");
						pp.top=$(this).css("top");
						list[i]=pp;
			});
			localStorage.allpp=JSON.stringify(list)
			console.log("autoSave");
		}
		
		var list = JSON.parse(  localStorage.allpp);
		$(".ui-widget-content").each(function(i, value) {
			$(this).css("left", list[i].left);
			$(this).css("top", list[i].top);
		});
 
	</script>
</body>
</html>
