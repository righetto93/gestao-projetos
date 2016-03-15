package br.com.semear.gestao.service;

import java.util.List;

import br.com.semear.gestao.model.RespostaAcao;

public interface RespostaAcaoService {
	void salvarRespostaAcao(List<RespostaAcao> respostas);
	
	void alterarRespostaAcao(RespostaAcao resposta);
	
	void removerRespostaAcao(RespostaAcao resposta);
	
	RespostaAcao buscarRespostaAcaoPorId(long IdResposta);
	
	List<RespostaAcao> listarRespostas();
}