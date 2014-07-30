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
function createLogTable(containerElem,array){
	
	var table_ele = document.createElement("table");
	containerElem.appendChild(table_ele);
	
	//ヘッダー行
	var thead_ele = document.createElement("thead");
	table_ele.appendChild(thead_ele);
	
	var tr_ele = document.createElement("tr");
	thead_ele.appendChild(tr_ele);
	
	var th1_ele = document.createElement("th");
	th1_ele.textContent = "path";
	tr_ele.appendChild(th1_ele);
	
	var th2_ele = document.createElement("th");
	th2_ele.textContent = "reqtime_microsec";
	tr_ele.appendChild(th2_ele);
		
	//データ行
	var tbody_ele = document.createElement("tbody");
	table_ele.appendChild(tbody_ele);
	
	for(i=0;i<array.length;i++){
		var tr_ele = document.createElement("tr");
		tbody_ele.appendChild(tr_ele);
		
		var td1_ele = document.createElement("td");
		td1_ele.textContent = (array[i]).path;
		tr_ele.appendChild(td1_ele);
		
		var td2_ele = document.createElement("td");
		td2_ele.textContent = (array[i]).reqtime_microsec;
		tr_ele.appendChild(td2_ele);
	}				
			
}
