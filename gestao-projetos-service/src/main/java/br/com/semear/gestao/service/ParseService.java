package br.com.semear.gestao.service;

import br.com.semear.gestao.dao.entity.AcaoEntity;
import br.com.semear.gestao.dao.entity.AlternativaPerguntaAcaoEntity;
import br.com.semear.gestao.dao.entity.AlternativaPerguntaEntity;
import br.com.semear.gestao.dao.entity.ColaboradorEntity;
import br.com.semear.gestao.dao.entity.InformacaoProjetoEntity;
import br.com.semear.gestao.dao.entity.ParceiroEntity;
import br.com.semear.gestao.dao.entity.ParticipacaoColaboradorProjetoEntity;
import br.com.semear.gestao.dao.entity.ParticipacaoParceiroProjetoEntity;
import br.com.semear.gestao.dao.entity.ParticipacaoReeducandoAcaoEntity;
import br.com.semear.gestao.dao.entity.ParticipacaoReeducandoProjetoEntity;
import br.com.semear.gestao.dao.entity.PerfilEntity;
import br.com.semear.gestao.dao.entity.PerguntaAcaoEntity;
import br.com.semear.gestao.dao.entity.PerguntaEntity;
import br.com.semear.gestao.dao.entity.ProjetoEntity;
import br.com.semear.gestao.dao.entity.QuestionarioAcaoEntity;
import br.com.semear.gestao.dao.entity.QuestionarioEntity;
import br.com.semear.gestao.dao.entity.ReeducandoEntity;
import br.com.semear.gestao.dao.entity.RespostaAcaoEntity;
import br.com.semear.gestao.dao.entity.RespostaEntity;
import br.com.semear.gestao.dao.entity.TarefaProjetoEntity;
import br.com.semear.gestao.dao.entity.TipoPerguntaEntity;
import br.com.semear.gestao.dao.entity.UnidadePrisionalEntity;
import br.com.semear.gestao.dao.entity.UsuarioEntity;
import br.com.semear.gestao.model.Acao;
import br.com.semear.gestao.model.AlternativaPergunta;
import br.com.semear.gestao.model.AlternativaPerguntaAcao;
import br.com.semear.gestao.model.Colaborador;
import br.com.semear.gestao.model.InformacaoProjeto;
import br.com.semear.gestao.model.Parceiro;
import br.com.semear.gestao.model.ParticipacaoColaboradorProjeto;
import br.com.semear.gestao.model.ParticipacaoParceiroProjeto;
import br.com.semear.gestao.model.ParticipacaoReeducandoAcao;
import br.com.semear.gestao.model.ParticipacaoReeducandoProjeto;
import br.com.semear.gestao.model.Perfil;
import br.com.semear.gestao.model.Pergunta;
import br.com.semear.gestao.model.PerguntaAcao;
import br.com.semear.gestao.model.Projeto;
import br.com.semear.gestao.model.Questionario;
import br.com.semear.gestao.model.QuestionarioAcao;
import br.com.semear.gestao.model.Reeducando;
import br.com.semear.gestao.model.Resposta;
import br.com.semear.gestao.model.RespostaAcao;
import br.com.semear.gestao.model.TarefaProjeto;
import br.com.semear.gestao.model.TipoPergunta;
import br.com.semear.gestao.model.UnidadePrisional;
import br.com.semear.gestao.model.Usuario;


public interface ParseService {
	ProjetoEntity parseToEntity(Projeto projeto);
	
	ParceiroEntity parseToEntity(Parceiro parceiro);
	
	UsuarioEntity parseToEntity(Usuario usuario);
	
	PerfilEntity parseToEntity(Perfil perfil);

	Usuario parseToModel(UsuarioEntity entity);
	
	Parceiro parseToModel(ParceiroEntity entity);

	Perfil parseToModel(PerfilEntity entity);

	UnidadePrisionalEntity parseToEntity(UnidadePrisional unidade);

	ReeducandoEntity parseToEntity(Reeducando reeducando);

	ParticipacaoReeducandoProjetoEntity parseToEntity(ParticipacaoReeducandoProjeto participacaoProjeto);

	AcaoEntity parseToEntity(Acao acao);

	Projeto parseToModel(ProjetoEntity entity);

	Reeducando parseToModel(ReeducandoEntity entity);

	UnidadePrisional parseToModel(UnidadePrisionalEntity entity);

	Questionario parseToModel(QuestionarioEntity entity);

	QuestionarioAcao parseToModel(QuestionarioAcaoEntity entity);
	
	RespostaAcao parseToModel(RespostaAcaoEntity entity);
	
	QuestionarioAcaoEntity parseToEntity(QuestionarioAcao model);
	
	TipoPergunta parseToModel(TipoPerguntaEntity entity);
	
	Acao parseToModel(AcaoEntity a);

	QuestionarioEntity parseToEntity(Questionario questionario);

	PerguntaEntity parseToEntity(Pergunta model);

	TipoPerguntaEntity parseToEntity(TipoPergunta model);

	Pergunta parseToModel(PerguntaEntity p);

	PerguntaAcao parseToModel(PerguntaAcaoEntity p);
	
	AlternativaPerguntaEntity parseToEntity(AlternativaPergunta alternativa);

	AlternativaPerguntaAcaoEntity parseToEntity(AlternativaPerguntaAcao alternativa);

	PerguntaAcaoEntity parseToEntity(PerguntaAcao p);

	AlternativaPerguntaAcao parseToModel(AlternativaPerguntaAcaoEntity a);
	
	ParticipacaoColaboradorProjetoEntity parseToEntity(ParticipacaoColaboradorProjeto colaboradorProjeto);

	ParticipacaoReeducandoAcaoEntity parseToEntity(ParticipacaoReeducandoAcao participacaoAcao);

	ParticipacaoParceiroProjetoEntity parseToEntity(ParticipacaoParceiroProjeto participacaoParceiroProjeto);

	ParticipacaoParceiroProjeto parseToModel(ParticipacaoParceiroProjetoEntity p);

	ParticipacaoReeducandoProjeto parseToModel(ParticipacaoReeducandoProjetoEntity p);

	ParticipacaoColaboradorProjeto parseToModel(ParticipacaoColaboradorProjetoEntity p);

	InformacaoProjetoEntity parseToEntity(InformacaoProjeto informacaoProjeto);

	InformacaoProjeto parseToModel(InformacaoProjetoEntity buscarInformacaoProjetoPorIdProjeto);

	TarefaProjetoEntity parseToEntity(TarefaProjeto tarefa);

	TarefaProjeto parseToModel(TarefaProjetoEntity tarefa);

	Resposta parseToModel(RespostaEntity entity);

	AlternativaPergunta parseToModel(AlternativaPerguntaEntity a);

	ColaboradorEntity parseToEntity(Colaborador colaborador);

	Colaborador parseToModel(ColaboradorEntity colaborador);
}