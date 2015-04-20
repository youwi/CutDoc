<meta charset="utf-8">
<!--link rel="stylesheet" type="text/css" href="base.css"-->
<!--link rel="stylesheet" type="text/css" href="gh-buttons.css">
<link rel="stylesheet" type="text/css" href="gh-buttons.css"-->



<script type="text/javascript" src="../resources/js/jquery.js"></script>
<script type="text/javascript" src="../resources/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="../resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../resources/js/jquery.bootstrap.min.js"></script>


<link   type="text/css"    href="../resources/css/bootstrap.min.css" rel="stylesheet">
<link   type="text/css"    href="../resources/css/index.css" rel="stylesheet"  />
<link   type="text/css"    href="../resources/css/font-awesome.css"  rel="stylesheet" >

<!--
<script type="text/javascript" src="../resources/js/paste.js" ></script>
<script type="text/javascript" src="../resources/js/pa.paste.js" ></script>
<link   rel="stylesheet"   href="css/bootstrap-switch.min.css" >
<script type="text/javascript" src="../resources/tinymce/tinymce.min.js"></script>
<script type="text/javascript" src="../resources/ajaxfileupload.js"></script>
-->
<html>

<nav class=" buleBar col-lg-12" role="navigation">
	<div class="navbar-header navbar-brand" >
			<h2  class='myh2'>wiki</h2>
	</div>
	<div class='col-md-6 myPathT '  >
		<ol class="breadcrumb myPath">
		  <li><a href="../index.html"  id="gotoMain"  class='icon-home'>主页</a></li>
		  <li><a href="/cutwiki/wiki"  id="gotoDeploy"  class="1active" >wiki</a></li>

		</ol>
	</div>
	<div class=' navbar-right'><small>@isyou</small></div>
</nav>

<div class="container-fluid">
	<div class="row-fluid">
		<div class="span2">
			<div class='btn-group-vertical col-lg-2'>
				<a href="#" class="btn btn-primary  btn-xs">任务:</a>
				<a href="#" class="btn btn-primary  btn-xs">用$.post("json")来做测试</a>
				<a href="#" class="btn btn-primary  btn-xs">Poster</a>
				<a href="#" class="btn btn-primary  btn-xs">Risk</a>
				<a href="#" class="btn btn-primary  btn-xs">生成目录</a>
				<a href="#" class="btn btn-primary  btn-xs">CKtester</a>
				<a href="#" class="btn btn-primary  btn-xs">添加</a>
				<a href="#" class="btn btn-primary  btn-xs">删除</a>
			</div>
		</div>

		<div class="span10">
				<div style="float:right;position: absolute; right:0px; z-index:9999;top:50px"  >
				<span id='tagop' class="glyphicon glyphicon-list"></span>
					<div class='btn-group'  id='tagedit'>
					<span href="#" id='ckeditor' 	class="btn btn-primary  btn-xs">CKeditor</span>
					<a href="#" id='save' 	class="btn btn-primary  btn-xs">保存</a>
					<a href="#" id='upload' class="btn btn-primary  btn-xs" >上传文件</a>
					<a href="#" id='edit'   class="btn btn-primary  btn-xs">编辑</a>
					<a href="#" id='exit' 	class="btn btn-primary  btn-xs">退出</a>
					</div>
				</div>
			<div class='col-lg-10'  style="min-height: 500px">
				<form  id='formUp' action='upload.php' method='post'  >
					<input  id='uppc' class='hide'  type='file'  name='files[]'></input>
					<iframe  class='noborder col-lg-12 mySHeight'  id='if' name='if' src="${page}"  data-path="${path}" title="可视编辑器 " tabindex="4" ></iframe >
				</form>
			</div>
		
		</div>
		
	</div>
</div>



<script type='text/javascript'>
/*
	$(document).on("paste",function(ev,data){
		alert(event.clipboardData);
	});
	 window.onpaste=function(ev,data){
	 aler("fasdfa");
	 }
	   document.if.addEventListener('paste', function(e){
          	console.log(     e.clipboardData);
     		console.log( e.clipboardData.types);
          	var reader = new FileReader();
          	var tout;
          	for(var i=0;i<clipboardData.items.length;i++  ){

               	tout=reader.readAsDataURL(clipboardData.items[i].getAsFile());
              }

              // e.clipboardData.setData(tout);
         });
*/
		var xio;

   		frames[0].addEventListener('paste',pp);


   		function pp(e){

     	var reader = new FileReader();
     	var tout;

		if(e.clipboardData.types.indexOf('Files') > -1)
		{
			console.log("data:" + e.clipboardData);
			console.log("types:"+ e.clipboardData.types);
			console.log("getData:"+ e.clipboardData.getData("img/*"));
		//console.log("files[0]:"+ e.clipboardData.files[0]);
			console.log("items[0]:"+ e.clipboardData.items[0]);

			var it=e.clipboardData.items[0];
		//	console.log("items[0].getData():"+ it.getData());
		  	reader.readAsDataURL( it.getAsFile());
			console.log("tout:",tout);
			console.log("reader",reader);
			console.log("text:"+reader.result.toString());//为结果文件
			xio=reader; //注意读取有时间限制!! 要使用onload来读取结果
			e.clipboardData.setData("text/plain", '<img src="' + reader.result +'" >');
			console.log(e.srcElement);
			reader.onload=function(ev){
				console.log("<img src=\"" + reader.result+"\" >");
				$(e.srcElement).append(  "<img src=\"" + reader.result+"\" >" )  ;
			};
			//var ss="<img src=\"" + reader.result.toString() +"\" >" ;



		    e.preventDefault();
		    console.log(e);
		//  	'<img src="' + reader.result +'" >';//生成图片,然后把图片加入就好了.
      	}



         // e.clipboardData.setData(tout);
    	};




	// $("#ckeditor").bootstrapSwitch();
  

	$("#tagop").click(function(){
		$("#tagedit").slideToggle("slow");
	});
	$("#edit").click(function(){
		window.frames.if.document.designMode='on';
	});
	$("#save").click(function(){
		var filename=$('#if').attr('src');
		var path=$("#if")[0].dataset.path;
		window.frames.if.document.designMode='off';	
		$.post('/cutwiki/wiki/wikiSave', 	{wikipath:path,name:filename,wikiContent:window.frames.if.document.body.innerHTML},function(data){ alert(data);});	
	});
	$("#upload").click(function(){
		//alert("#upload");
		$("#uppc")[0].click();
		upac();
	});
	function  upac(){
        $.ajaxFileUpload(
        {
             url:'upload.php', //你处理上传文件的服务端
             secureuri:false,
             fileElementId:'uppc',
             dataType: 'json',
             success: function (data){ alert(data.file_infor);}
        })
        return false;
	};
	
	var CK;
	$("#ckeditor").click(function(){
		if(CK==null) 
		{
			CK=CKEDITOR.replace('if');
			CK.setData(window.frames.if.document.body.innerHTML) //设置内容



			CKEDITOR.on('instanceReady', function (e) {
            	//  var td = document.getElementById('cke_contents_' + e.editor.name), tbody = td.parentNode.parentNode;
             	// td.style.height = h - tbody.rows[0].offsetHeight - tbody.rows[2].offsetHeight + 'px';
             $('.cke_contents').css('height', "calc(100% - 210px)");
             frames[1].addEventListener('paste',pp);//设置可粘贴
              //setTimeout("$('.cke_contents').css('height', $('body').height()-200);",100) ;//设置一个超时对象:自动变高
            });
		}else{
			window.frames.if.document.body.innerHTML=CK.getData();
			CK.destroy();
			CK=null;
		}
	});
	
		document.onkeydown=function(event){
			  var e=event||window.event;
			  var keyCode=e.keyCode||e.which;
			  if(e.ctrlKey && (keyCode == 83 ))
			  {
				$("#f").submit();
				e.returnValue=false;
			  }
		}


  
    

</script>


</html>

