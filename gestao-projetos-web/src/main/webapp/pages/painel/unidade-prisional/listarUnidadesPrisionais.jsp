<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
<script type="text/javascript">
	$(function() {
		$("#menu-configuracoes").attr('class', 'active');
		$("#menu-unidades").attr('class', 'active');
		$("#tbUnidades").dataTable({
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
			<h4 class="title-screen">Unidades Prisionais</h4>
			<div id="alertas"></div>
			<table id="tbUnidades" class="table table-responsive">
				<thead>
					<tr>
						<td class="text-center"><span style="font-weight: bold;">#</span></td>
						<td class="text-center"><span style="font-weight: bold;">Unidade
								Prisional</span></td>
						<td class="text-center"><span style="font-weight: bold;">Status</span></td>
						<td class="text-center"><span style="font-weight: bold;">A��o</span></td>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty unidades}">
							<c:forEach items="${unidades}" var="unidade">
								<tr>
									<td class="text-center">${unidade.id}</td>
									<td class="text-center">${unidade.nome}</td>
									<c:if test="${unidade.status == true}">
										<td class="text-center">ATIVADA</td>
									</c:if>
									<c:if test="${unidade.status == false}">
										<td class="text-center">DESATIVADA</td>
									</c:if>
									<td class="text-center"><a href="editar/${unidade.id}"><span
											class="glyphicon glyphicon-pencil"></span></a></td>
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
			<a href="cadastrar" class="btn btn-default btn-add">Adicionar
				Unidade Prisional</a>
		</div>
	</div>
</body>
</html>