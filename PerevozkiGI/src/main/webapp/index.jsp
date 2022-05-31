<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>Title</title>
		
		<style>
			html {
				height: 100%;
			}
			body {
				background-color: lightblue;
				height: 100%;
				margin: 0;
				padding: 0;
			}
			
			.container{
				height: 100%;
				position: relative;
			}

			.form {
				flex-wrap: wrap;
				display: flex;
				align-content: flex-end;
				justify-content: center;
				height: 50%;
			}
			
			.result_form_ex {
				align-content: flex-start;
			}

			.form_item {
				position: relative;
				padding: 2px;
			}

			.input {
				padding: 0;

				width: 120px;
				height: 30px;

				border: 0;
				border-radius: 4px;
			}
			
			.button {
				padding: 0;
			
				width: 120px;
				height: 30px;
				
				background-color: #4478ff;
				color: white;

				border: 0;
				border-radius: 4px;
			}
			
			.invisible{
				visibility: hidden;
			}
			
			.authors{
				display: fixed;
				bottom: 0;
				right: 0;
			}
		</style>
		
		<script type="text/javascript">
			let selected_city_from = "1.0";
			let selected_city_to = "2.0";
			function select_city(){
				if (document.forms.form.from.value === document.forms.form.to.value){
					alert("Нельзя отправить в тот же город");
					document.forms.form.from.value = selected_city_from;
					document.forms.form.to.value = selected_city_to;
				}
				else{
					selected_city_from = document.forms.form.from.value;
					selected_city_to = document.forms.form.to.value;
				}
			}
			
			function check_size(){
				let sizes = document.forms.form.size.value.trim().split(" ");
				let width = parseInt(sizes[0]);
				let height = parseInt(sizes[1]);
				let length = parseFInt(sizes[2]);
				
				if (width > 10 | height > 10 | length > 10){
					alert("Размеры не должны превышать 10м");
					return false;
				}
				
				return true;
			}
			
			function send_calc_request(){
				let request = new XMLHttpRequest();
				request.onreadystatechange = function() {
				    if (this.readyState == 4 && this.status == 200) {
				    	document.forms.result_form.result.value = request.responseText;
				    }
			  	};
			  	
			  	let url = "/Home";
			  	request.open("GET", url);
			  	request.send();
			}	
			
			function on_submit(){
				if (check_size()){
					send_calc_request();
				}
			}
		</script>
	</head>
	<body>
		<div class="container">
			<form name="form" class="form" onsubmit="on_submit(); return false;">
				<div class="form_item">
					<div>Откуда</div>
					<select name="from" class="input" onchange="select_city();" required>
						<option selected value="1.0">Город1</option>
						<option value="2.0">Город2</option>
					</select>
				</div>
				
				<div class="form_item">
					<div>Куда</div>
					<select name="to" class="input" onchange="select_city();" required>
						<option value="1.0">Город1</option>
						<option selected value="2.0">Город2</option>
					</select>
				</div>
			
				<div class="form_item">
					<div>Вес</div>
					<input type="text" name="weight" class="input" pattern="[0-9]{1,3}" required>
				</div>
				
				<div class="form_item">
					<div>Размер</div>
					<input type="text" name="size" class="input" pattern="[0-9]{1,3}\s{1,}[0-9]{1,3}\s{1,}[0-9]{1,3}" required>
				</div>
				
				<div class="form_item">
					<div class="invisible">Кнопка</div>
					<button class="button">Расчёт</button>
				</div>
			</form>
			<form name="result_form" class=" form result_form_ex" onsubmit="return false;">
				<div class="form_item">
					<div>Результат</div>
					<input type="text" name="result" class="input">
				</div>
				
				<div class="form_item">
					<div class="invisible">Кнопка</div>
					<button class="button">Показать в PDF</button>
				</div>
			</form>
		</div>
		<div class="authors">
			<div>Ефимов Ю.А.</div>
			<div>Ганцев К.Т.</div>
			<div>Ильясов Р.М.</div>
		</div>
		<script>
			document.forms.form.weight.addEventListener("input", function(){
				let weight = parseInt(document.forms.form.weight.value);
				if (weight > 50){	
					document.forms.form.weight.setCustomValidity("Weight must be less or equal to 50kg");
					document.forms.form.weight.reportValidity();
				}
				else{
					document.forms.form.weight.setCustomValidity("");
				}
			});
		</script>
	</body>
</html>