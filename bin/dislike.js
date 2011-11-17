var s=document.createElement("script");
s.src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.0/jquery.min.js";
s.onload=function(){
	$("ul.actions").map(function(){
		var id=$(this).find("a.love").attr("rel");
		console.log(id);
		var button="<li><a rel=\""+id+"\" id=\"unlo-"+id+"\" class=\"unlove badge-vote-down\" href=\"#\"><span>Unlove</span></a></li>";
		$(this).append(button);
	});
	$("a.unlove").click(function (e){
		e.preventDefault();
		var id=$(this).attr("rel");
		$.get("http://9gag.com/vote/dislike/id/"+id,function(){
			$("#unlo-"+id).addClass("unloved");
		});
	});
};
document.body.appendChild(s);
