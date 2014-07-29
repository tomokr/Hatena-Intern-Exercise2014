// 課題 JS-1: 関数 `parseLTSVLog` を記述してください
function parseLTSVLog(logStr){
	logar = logStr.split("\n");
	var datar = [];
	for(i=0;i<(logar.length-1);i++){ //一番最後の\n対策
	res = logar[i].split("\t");
	paths = res[0].split(":");
	rt = res[1].split(":");
	var data ={};
	data.path = paths[1];
	data.reqtime_microsec = parseInt(rt[1]);
	datar.push(data);
	}

	return datar;
}

// 課題 JS-2: 関数 `createLogTable` を記述してください
/*function createLogTable(containerElem,array){
	
	var childtext;
	childtext = "<thead><tr><th>path</th><th>reqtime_microsec</th></tr></thead><tbody>";
	for(i=0;i<array.count;i++){
		childtext = childtext+"<tr><td>"+(ar[i]).path+"</td><td>"+(ar[i]).reqtime_microsec+"</td></tr>";
	}

	childtext = childtext+"</tbody>";

	var child = containerElem.createElement("table");
	child.textContent = childtext;
	containerElem.appentChild(child);

}*/