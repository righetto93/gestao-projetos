<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
<script type="text/javascript">
	$(function() {
		$("#menu-projetos").attr('class', 'active');
		$("#tbProjetos").dataTable({
			"iDisplayLength" : 5,
			"bPaginate" : true,
			"bLengthChange" : false,
			"bFilter" : true,
			"bInfo" : false,
			"bAutoWidth" : true,
			"language" : {
				"emptyTable" : "Nenhuma informa��o cadastrada",
				"search" : "Pesquisar:",
				"paginate" : {
					"first" : "Primeira",
					"last" : "�ltima",
					"next" : "Pr�ximo",
					"previous" : "Anterior"
				}
			}
		});
	});
</script>
</head>
<body>
	<div class="section">
		<div class="container">
			<h4 class="title-screen">Projetos</h4>
			<div id="alertas"></div>
			<table class="table table-responsive" id="tbProjetos">
				<thead>
					<tr>
						<td class="text-center"><span style="font-weight: bold;">#</span></td>
						<td class="text-center"><span style="font-weight: bold;">Nome
								do Projeto</span></td>
						<td class="text-center"><span style="font-weight: bold;">Data
								Inicio</span></td>
						<td class="text-center"><span style="font-weight: bold;">Status</span></td>
						<td class="text-center"><span style="font-weight: bold;">A��o</span></td>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty projetos}">
							<c:forEach items="${projetos}" var="projeto">
								<tr>
									<td class="text-center">${projeto.id}</td>
									<td class="text-center">${projeto.nome}</td>
									<td class="text-center"><fmt:formatDate
											value="${projeto.dataInicio.time}" pattern="dd/MM/yyyy"></fmt:formatDate></td>
									<td class="text-center">${projeto.status}</td>
									<td class="text-center"><a href="editar/${projeto.id}"
										title="Editar"> <span class="glyphicon glyphicon-pencil">
										</span>
									</a> <a style="margin-left: 20px"
										href='<c:url value="/painel/questionarios/cadastro/${projeto.id}" />'
										title="Question�rio"> <span
											class="glyphicon glyphicon-list-alt"></span>
									</a> <a style="margin-left: 20px"
										href='<c:url value="/painel/participacao-projetos/${projeto.id}/parceiros" />'
										title="Parceiros"> <span
											class="glyphicon glyphicon-th-list"></span>
									</a> <a style="margin-left: 20px"
										href='<c:url value="/painel/participacao-projetos/${projeto.id}/parceiros/cadastroParticipacaoProjeto" />'
										title="Reeducandos e Colaboradores"> <span
											class="glyphicon glyphicon-user"></span></a> <a
										style="margin-left: 20px"
										href='<c:url value="/painel/projetos/${projeto.id}/exibirInformacoes"></c:url>'
										title="Informa��es"><span
											class="glyphicon glyphicon-info-sign"></span></a><a
										style="margin-left: 20px"
										href='<c:url value="/painel/projetos/${projeto.id}/tarefas"></c:url>'
										title="Tarefas"><span class="glyphicon glyphicon-pushpin"></span></a>
										<a style="margin-left: 20px"
										href='<c:url value="/painel/respostasprojeto/I/${projeto.id}"></c:url>'
										title="Resposta Inicio"><span
											class="glyphicon glyphicon-copy"></span></a> <a
										style="margin-left: 20px"
										href='<c:url value="/painel/respostasprojeto/F/${projeto.id}"></c:url>'
										title="Resposta Fim"><span
											class="glyphicon glyphicon-paste"></span></a></td>


								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="6">N�o h� dados a serem exibidos</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			<br /> <a href='<c:url value="cadastro"></c:url>'
				class="btn btn-default btn-add">Novo Projeto</a>
		</div>
	</div>
</body>
</html>