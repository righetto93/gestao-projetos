<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cadastro de Participa��o Projeto</title>
<script type="text/javascript">
	$(document).ready(function() {
		$("#coordenadores").hide();
	});
</script>
<script type="text/javascript">
	function listarCoordenadores() {
		var idInstituicao = $("#instituicao").val();
		if (idInstituicao != "") {
			$("#coordenadores").show();
			$
					.post(
							"/gestao-projetos/painel/participacao-projetos/listarCoordenadores/"
									+ idInstituicao + "/ROLE_COORDENADOR",
							function(listaCoordenadores) {
								$("#coordenador option").remove();
								var coordenador = "<option value='' label='Selecione...' />";
								$(listaCoordenadores)
										.each(
												function(i) {
													coordenador += "<option value='"+ listaCoordenadores[i].id +"' label='"+ listaCoordenadores[i].nome +"' />";
												});
								$("#coordenador").append(coordenador);
							})
		}
		;
	};
</script>
<script type="text/javascript">
	function listarReeducandos() {
									$("input[name=idReeducandos]")
											.on(
													"click",
													function() {
														var idReeducando = this.id;
														var idFuncao = this.id
																.replace(
																		"reeducando",
																		"funcao");
														if ($("#"
																+ idReeducando
																+ ":checked").length > 0) {
															$("#" + idFuncao)
																	.removeAttr(
																			"disabled");
															$("#" + idFuncao)
																	.attr(
																			"required",
																			"required");
														} else {
															$("#" + idFuncao)
																	.removeAttr(
																			"required");
															$("#" + idFuncao)
																	.attr(
																			"disabled",
																			"disabled");
														}
													});
</script>
</head>
<body>
	<form
		action='<c:url value="/painel/participacao-projetos/salvarParticipacaoProjeto"></c:url>'
		method="POST">
		<!-- Formulario de Cadastro - INICIO -->
		<div class="section">
			<div class="container">
				<h3 class="title-screen">Cadastro de Participa��o Projeto</h3>
				<hr />
				<div class="col-md-12">
					<div class="col-md-offset-3">
						<div>
							<input id="idProjeto" name="idProjeto" value="${idProjeto}"
								type="hidden" />
						</div>
						<div class="form-group col-md-4">
							<label for="instituicao">Institui��o:</label> <select
								id="instituicao" name="idInstituicoes" class="form-control"
								required autofocus onchange="listarCoordenadores();">
								<option value="" label="Selecione..." />
								<c:forEach var="instituicao" items="${instituicoes}">
									<option value="${instituicao.id}"
										label="${instituicao.razaosocial}" />
								</c:forEach>
							</select>
						</div>
						<div class="form-group col-md-4" id="coordenadores">
							<label for="coordenador">Coordenador:</label> <select
								id="coordenador" name="idCoordenador" class="form-control"
								required autofocus onchange="listarReeducandos();">
								<option value="" label="" />
							</select>
						</div>
					</div>
				</div>
				<!-- Formulario de Cadastro - FIM -->
				<br />
				<h4 class="title-screen" id="titleReeducandos">Reeducandos</h4>
				<table class="table table-responsive" id="reeducandos">
					<thead>
						<tr class="text-center">
							<td></td>
							<td><span style="font-weight: bold;">#</span></td>
							<td><span style="font-weight: bold;">Matr�cula</span></td>
							<td><span style="font-weight: bold;">Nome</span></td>
							<td><span style="font-weight: bold;">Sexo</span></td>
							<td><span style="font-weight: bold;">Fun��o</span></td>
						</tr>
					</thead>
					<tbody id="tbody-reeducandos">
						<c:forEach var="reeducando" items="${reeducandos}">
							<tr class="text-center">
								<td><input value="${reeducando.id}" name="idReeducandos"
									type="checkbox" /></td>
								<td>${reeducando.id}</td>
								<td>${reeducando.matricula}</td>
								<td>${reeducando.nome}</td>
								<td>${reeducando.sexo}</td>
								<td><select class='form-control'
									id="funcao${reeducando.id}" name='funcoes' disabled>
										<option value='' label='Selecione...'></option>
										<option value='Reeducando Participante'
											label='REEDUCANDO PARTICIPANTE'></option>
										<option value='Reeducando Monitor' label='REEDUCANDO MONITOR'></option>
								</select></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<br />
				<h4 class="title-screen" id="titleColaboradores">Colaboradores</h4>
				<table class="table table-responsive" id="colaboradores">
					<thead>
						<tr class="text-center">
							<td></td>
							<td><span style="font-weight: bold;">#</span></td>
							<td><span style="font-weight: bold;">Nome</span></td>
							<td><span style="font-weight: bold;">Usu�rio</span></td>
						</tr>
					</thead>
					<tbody id="tbody-colaboradores">
						<c:forEach var="colaborador" items="${colaboradores}">
							<tr class="text-center">
								<td><input value="${colaborador.id}" name="idColaboradores"
									type="checkbox" /></td>
								<td>${colaborador.id}</td>
								<td>${colaborador.nome}</td>
								<td>${colaborador.usuario}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="row">
					<div class="col-md-12">
						<button type="submit" class="btn btn-default btn-add">Salvar</button>
						<a href='<c:url value="/painel/projetos/"></c:url>'
							class="btn btn-default btn-return">Cancelar</a>
					</div>
				</div>
			</div>
		</div>



	</form>
</body>
</html>