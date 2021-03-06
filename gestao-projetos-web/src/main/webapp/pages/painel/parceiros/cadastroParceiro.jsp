<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<script type="text/javascript">
	$(function() {
		var msg = "<c:out value='${msg}'/>";
		if (msg == 'OK') {
			$("#modalParceiroAdicionada").modal({
				keyboard : false,
				backdrop : 'static'
			});
		}

		$("#menu-parceiros").attr('class', 'active');
		$('#documentoCNPJ').mask('00.000.000/0000-00');
		$('#cep').mask('00000-000');
		$('#telefoneFixo').mask('(00) 0000-0000');
		$('#telefone').mask('(00) 0000-00009');
	});

	function escolheValidacao() {
		var escolha = document.getElementById("tipopessoa").value;
		if (escolha == "fisica") {
			var rg = document.getElementById("tipoDocumento").value;
			if (rg == "rg") {
				validarDocumentoInst();
			} else if (rg == "cpf") {
				if (validarCPF()) {
					validarDocumentoInst();
				}
			}
		} else if (escolha == "juridica") {
			if (validaCNPJ()) {
				validarDocumentoInst();
			}
		}
	}

	function mascaraRG() {
		var rg = document.getElementById("tipoDocumento").value;
		if (rg == "rg") {
			$('#documento').mask('00000000000000');
		} else {
			$('#documento').mask('000.000.000-00');

		}
	}

	function ocultarCNPJ() {
		var escolha = document.getElementById("tipopessoa").value;
		if (escolha == "fisica") {
			$('#tipoDocumento').append(
					'<option value="cpf" id="cpf">CPF</option>');
			$('#tipoDocumento')
					.append('<option value="rg" id="rg">RG</option>');
			document.getElementById("jurudico1").style.display = "none";
			document.getElementById("jurudico2").style.display = "none";
			document.getElementById("fisica1").style.display = "block";
			$('#documento').mask('000.000.000-00');
			$('#nomecompleto').val("");
			$('#nomecompleto').removeAttr('disabled');
			$('#nomecompleto').attr('required', 'required');
			$('#razaosocial').removeAttr('required');
			$('#cnpj').remove();
			$('#razaosocial').attr('disabled', 'disabled');
			$('#razaosocial').removeAttr('required');
			$('#nomefantasia').removeAttr('required');
		} else if (escolha == "juridica") {
			$('#tipoDocumento').append(
					'<option value="cnpj" id="cnpj">CNPJ</option>');
			document.getElementById("jurudico1").style.display = "block";
			document.getElementById("jurudico2").style.display = "block";
			document.getElementById("fisica1").style.display = "none";
			$('#documento').mask('00.000.000/0000-00');
			$('#razaosocial').val("");
			$('#cpf').remove();
			$('#rg').remove();
			$('#nomecompleto').attr('disabled', 'disabled');
			$('#razaosocial').attr('required', 'required');
			$('#nomefantasia').attr('required', 'required');
			$('#razaosocial').removeAttr('disabled');
			$('#nomecompleto').removeAttr('required');
			$('#razaosocial').attr('required', 'required');
		}
	}

	function validarCPF() {
		var escolhapessoa = document.getElementById("tipopessoa").value;
		if (escolhapessoa == "fisica") {
			var cpf = $('#documento').val();
			cpf = cpf.replace(/[^\d]+/g, '');
			if (cpf == '')
				return false;
			// Elimina CPFs invalidos conhecidos    
			if (cpf.length != 11 || cpf == "00000000000"
					|| cpf == "11111111111" || cpf == "22222222222"
					|| cpf == "33333333333" || cpf == "44444444444"
					|| cpf == "55555555555" || cpf == "66666666666"
					|| cpf == "77777777777" || cpf == "88888888888"
					|| cpf == "99999999999") {
				$("#alertadocdiv").remove();
				var alerta = "<div id='alertadocdiv' class='alert alert-warning'>"
						+ "<span style='color: #000000'><strong>Alerta!</strong>"
						+ "O CPF informado  � inv�lido.</span></div>";
				$("#alertas").append(alerta);
				$("#documento").val("");
				$("#documento").focus();
				return false;
			}
			// Valida 1o digito 
			add = 0;
			for (i = 0; i < 9; i++)
				add += parseInt(cpf.charAt(i)) * (10 - i);
			rev = 11 - (add % 11);
			if (rev == 10 || rev == 11)
				rev = 0;
			if (rev != parseInt(cpf.charAt(9))) {
				$("#alertadocdiv").remove();
				var alerta = "<div id='alertadocdiv' class='alert alert-warning'>"
						+ "<span style='color: #000000'><strong>Alerta!</strong>"
						+ "O CPF informado  � inv�lido.</span></div>";
				$("#alertas").append(alerta);
				$("#documento").val("");
				$("#documento").focus();
				return false;
			}
			// Valida 2o digito 
			add = 0;
			for (i = 0; i < 10; i++)
				add += parseInt(cpf.charAt(i)) * (11 - i);
			rev = 11 - (add % 11);
			if (rev == 10 || rev == 11)
				rev = 0;
			if (rev != parseInt(cpf.charAt(10))) {
				$("#alertadocdiv").remove();
				var alerta = "<div id='alertadocdiv' class='alert alert-warning'>"
						+ "<span style='color: #000000'><strong>Alerta!</strong>"
						+ "O CPF informado  � inv�lido.</span></div>";
				$("#alertas").append(alerta);
				$("#documento").val("");
				$("#documento").focus();
				return false;
			}
			$("#alertadocdiv").remove();
			return true;
		}
	}

	function validaCNPJ() {
		var cnpj = document.getElementById("documento").value;
		cnpj = cnpj.replace(/[^\d]+/g, '');

		if (cnpj == '')
			return false;

		if (cnpj.length != 14) {
			$("#alertadocdiv").remove();
			var alerta = "<div id='alertadocdiv' class='alert alert-warning'>"
					+ "<span style='color: #000000'><strong>Alerta!</strong>"
					+ "O CNPJ informado  � inv�lido.</span></div>";
			$("#alertas").append(alerta);
			//$("#documento").val("");
			$("#documento").focus();
			return false;
		}

		// Elimina CNPJs invalidos conhecidos
		if (cnpj == "00000000000000" || cnpj == "11111111111111"
				|| cnpj == "22222222222222" || cnpj == "33333333333333"
				|| cnpj == "44444444444444" || cnpj == "55555555555555"
				|| cnpj == "66666666666666" || cnpj == "77777777777777"
				|| cnpj == "88888888888888" || cnpj == "99999999999999") {
			$("#alertadocdiv").remove();
			var alerta = "<div id='alertadocdiv' class='alert alert-warning'>"
					+ "<span style='color: #000000'><strong>Alerta!</strong>"
					+ "O CNPJ informado  � inv�lido.</span></div>";
			$("#alertas").append(alerta);
			$("#documento").val("");
			$("#documento").focus();
			return false;
		}

		// Valida DVs
		tamanho = cnpj.length - 2
		numeros = cnpj.substring(0, tamanho);
		digitos = cnpj.substring(tamanho);
		soma = 0;
		pos = tamanho - 7;
		for (var i = tamanho; i >= 1; i--) {
			soma += numeros.charAt(tamanho - i) * pos--;
			if (pos < 2)
				pos = 9;
		}
		resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
		if (resultado != digitos.charAt(0)) {
			$("#alertadocdiv").remove();
			var alerta = "<div id='alertadocdiv' class='alert alert-warning'>"
					+ "<span style='color: #000000'><strong>Alerta!</strong>"
					+ "O CNPJ informado  � inv�lido.</span></div>";
			$("#alertas").append(alerta);
			$("#documento").val("");
			$("#documento").focus();
			return false;
		}
		tamanho = tamanho + 1;
		numeros = cnpj.substring(0, tamanho);
		soma = 0;
		pos = tamanho - 7;
		for (i = tamanho; i >= 1; i--) {
			soma += numeros.charAt(tamanho - i) * pos--;
			if (pos < 2)
				pos = 9;
		}
		resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
		if (resultado != digitos.charAt(1)) {
			$("#alertadocdiv").remove();
			var alerta = "<div id='alertadocdiv' class='alert alert-warning'>"
					+ "<span style='color: #000000'><strong>Alerta!</strong>"
					+ "O CNPJ informado  � inv�lido.</span></div>";
			$("#alertas").append(alerta);
			//$("#documento").val("");
			$("#documento").focus();
			return false;
		}
		$("#alertadocdiv").remove();
		return true;

	}

	function validarDocumentoInst() {
		var documento = $("#documento").val();
		$
				.post(
						"/gestao-projetos/painel/parceiros/consultarParceiro?documento="
								+ documento,
						function(existe) {
							if (existe) {
								$("#alertadocdiv").remove();
								var alerta = "<div id='alertadocdiv' class='alert alert-warning'>"
										+ "<span style='color: #000000'><strong>Alerta!</strong>"
										+ "O Documento informado j� est� sendo utilizado.</span></div>";
								$("#alertas").append(alerta);
								$("#documento").val("").focus();
							} else {
								$("#alertadocdiv").remove();
							}
						});
	}
</script>

<body>
	<!-- MODAL PARCEIRO ADICIONADA INICIO -->
	<div class="modal fade" id="modalParceiroAdicionada" tabindex="-1"
		role="dialog" data-backdrop="static" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Institui��o adicionada com sucesso!</h4>
				</div>
				<div class="modal-body">
					<p>O que deseja fazer agora?</p>
				</div>
				<div class="modal-footer">
					<a href='<c:url value="/painel/parceiros/" />'
						style="background-color: #4DC1FF; color: #fff; border-color: #4DC1FF"
						class="btn btn-default">Ir para a lista de parceiros</a> <a
						href='<c:url value="/painel/parceiros/editar/${idParceiro}" />'
						style="background-color: #4DC1FF; color: #fff; border-color: #4DC1FF"
						class="btn btn-default">Informar unidades</a>
				</div>
			</div>
		</div>
	</div>
	<!-- MODAL PARCEIRO ADICIONADA FIM -->
	<div class="section">
		<div class="container">
			<h4 class="title-screen">Cadastro de Institui��o</h4>
			<hr />
			<div class="row">
				<div class="col-md-12">
					<form action="salvarParceiro" method="POST" role="form">
						<div id="alertas"></div>
						<div class="form-group col-md-2">
							<label for="tipopessoa">Tipo de Pessoa:</label> <select
								class="form-control" name="tipopessoa" id=tipopessoa
								onchange="ocultarCNPJ();" required>
								<option value="">Selecione ...</option>
								<option value="fisica">Pessoa Fisica</option>
								<option value="juridica">Pessoa Juridica</option>
							</select>
						</div>
						<div class="form-group col-md-5" id="fisica1"
							style="display: none;">
							<label for="razaosocial">Nome Completo:</label> <input
								type="text" class="form-control" id="nomecompleto"
								name="razaosocial" placeholder="Digite o nome">
						</div>
						<div class="form-group col-md-5" id="jurudico2">
							<label for="razaosocial">Raz�o Social:</label> <input type="text"
								class="form-control" id="razaosocial" name="razaosocial"
								placeholder="Digite a razao social">
						</div>
						<div class="form-group col-md-5" id="jurudico1">
							<label for="nomefantasia">Nome Fantasia:</label> <input
								type="text" class="form-control" id="nomefantasia"
								name="nomefantasia" placeholder="Digite o nome">
						</div>
						<div class="form-group col-md-2">
							<label for="tipoDocumento">Tipo do Documento</label> <select
								class="form-control" name="tipoDocumento" id="tipoDocumento"
								onchange="mascaraRG();" required>
							</select>
						</div>
						<div class="form-group col-md-3">
							<label for="documento">N�mero do Documento:</label> <input
								onblur="escolheValidacao();" type="text" class="form-control"
								id="documento" name="documento" placeholder="Digite o documento"
								required>
						</div>
						<div class="form-group col-md-2">
							<label for="cep">CEP:</label> <input type="text"
								class="form-control" id="cep" name="cep"
								placeholder="Digite o cep" required>
						</div>
						<div class="form-group col-md-5">
							<label for="logradouro">Logradouro:</label> <input type="text"
								class="form-control" id="logradouro" name="logradouro"
								placeholder="Digite o logradouro" required>
						</div>
						<div class="form-group col-md-2">
							<label for="numero">N�mero:</label> <input type="text"
								class="form-control" id="numero" name="numero"
								placeholder="Digite o numero" required>
						</div>
						<div class="form-group col-md-4">
							<label for="complemento">Complemento:</label> <input type="text"
								class="form-control" id="complemento" name="complemento"
								placeholder="Digite o complemento">
						</div>
						<div class="form-group col-md-3">
							<label for="bairro">Bairro:</label> <input type="text"
								class="form-control" id="bairro" name="bairro"
								placeholder="Digite o bairro" required>
						</div>

						<div class="form-group col-md-1">
							<label for="uf">UF:</label> <input type="text"
								class="form-control" id="uf" name="uf" placeholder="UF" required>
						</div>
						<div class="form-group col-md-2">
							<label for="cidade">Cidade:</label> <input type="text"
								class="form-control" id="cidade" name="cidade"
								placeholder="Digite a cidade" required>
						</div>
						<div class="form-group col-md-2">
							<label for="telefone">Telefone:</label> <input type="text"
								class="form-control" id="telefone" name="telefone"
								placeholder="Digite o telefone" required>
						</div>
						<div class="form-group col-md-4">
							<label for="email">Email:</label> <input type="email"
								class="form-control" id="email" name="email"
								placeholder="Digite o E-mail" required>
						</div>
						<div class="form-group col-md-3">
							<label for="responsavel">Respons�vel:</label> <input type="text"
								class="form-control" id="responsavel" name="responsavel"
								placeholder="Digite o nome do responsavel" required>
						</div>
						<div class="form-group"></div>
						<br /> <br /> <br /> <br />
						<div class="form-group col-md-12">
							<hr />
							<div class="form-group col-xs-offset-0">
								<a href='<c:url value="/painel/parceiros/" />'
									class="btn btn-default btn-return"><span
									class="glyphicon glyphicon-remove"></span> Cancelar</a>
								<button type="submit" class="btn btn-default btn-add">
									<span class="glyphicon glyphicon-ok"></span> Salvar Institui��o
								</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
