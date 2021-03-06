package br.com.semear.gestao.dao;

import java.util.List;

import br.com.semear.gestao.dao.entity.ParticipacaoReeducandoProjetoEntity;

public interface ParticipacaoProjetoDAO {
	public void cadastrar(ParticipacaoReeducandoProjetoEntity participacaoProjeto);

	public List<ParticipacaoReeducandoProjetoEntity> listarParticipacaoProjetos();
}