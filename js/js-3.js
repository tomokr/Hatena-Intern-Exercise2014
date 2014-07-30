// 課題 JS-3 の実装をここに記述してください。
element = document.getElementById("submit-button");
element.addEventListener("click",createTable,false);

function createTable(){
	text = document.getElementById("log-input").value;
	parent_elem = document.getElementById("table-container")
	 createLogTable(parent_elem,parseLTSVLog(text));
}