package br.com.semear.gestao.web.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import br.com.semear.gestao.model.InformacaoProjeto;
import br.com.semear.gestao.model.Projeto;
import br.com.semear.gestao.model.TarefaProjeto;
import br.com.semear.gestao.model.Usuario;
import br.com.semear.gestao.service.ParticipacaoColaboradorProjetoService;
import br.com.semear.gestao.service.ParticipacaoParceiroProjetoService;
import br.com.semear.gestao.service.ParticipacaoProjetoService;
import br.com.semear.gestao.service.ProjetoService;
import br.com.semear.gestao.service.QuestionarioService;
import br.com.semear.gestao.service.UnidadePrisionalService;
import br.com.semear.gestao.service.TarefaProjetoService;

@Controller
@RequestMapping("painel/projetos")
public class ProjetoController {

	@Inject
	private ProjetoService projetoService;

	@Inject
	private UnidadePrisionalService unidadePrisionalService;
	
	@Inject
	private ParticipacaoProjetoService participacaoProjetoService;
	
	@Inject
	private TarefaProjetoService tarefaProjetoService;

	@Inject
	private QuestionarioService questionarioService;
	
	@Inject
	private ParticipacaoParceiroProjetoService participacaoParceiroProjetoService;
	
	@Inject
	private ParticipacaoColaboradorProjetoService participacaoColaboradorProjetoService;
	
	private ModelAndView mav = new ModelAndView();

	@RequestMapping("/")
	public ModelAndView listaDeProjetos() {
		mav.clear();
		mav.setViewName("listar-projetos");
		mav.addObject("projetos", projetoService.listarTodosProjetos());
		return mav;
	}
	
	@RequestMapping("/{idProjeto}/detalhar")
	public ModelAndView detalharProjeto(@PathVariable("idProjeto") long idProjeto) {
		try {
			List<Long> parceirosAssociados = participacaoParceiroProjetoService.buscarParceirosAssociados(idProjeto);
			mav.clear();
			mav.setViewName("detalhar-projeto");
			mav.addObject("projeto", projetoService.buscarProjetoPorId(idProjeto));
			mav.addObject("questionario",questionarioService.buscarQuestionarioPorIdProjeto(idProjeto));
			mav.addObject("parceiros", participacaoProjetoService.listarParticipacaoParceirosProjeto(idProjeto));
			mav.addObject("coordernadorProjeto", projetoService.buscarCoordenadorPorIdProjeto(idProjeto));
			mav.addObject("parceirosAssociados", participacaoParceiroProjetoService.listarParticipacaoParceirosProjeto(idProjeto));
			mav.addObject("reeducandosAssociados", participacaoProjetoService.listarParticipacaoReeducandoProjeto(idProjeto));
			mav.addObject("reeducandos", participacaoProjetoService.listarReeducandosPorUnidadePrisional(idProjeto));
			mav.addObject("colaboradoresAssociados",
					participacaoColaboradorProjetoService.listarColaboradoresDoProjeto(idProjeto, "ROLE_COLABORADOR"));
			
			mav.addObject("colaboradores",
					participacaoProjetoService.listarColaboradoresDosParceiros(parceirosAssociados, "ROLE_COLABORADOR"));
			
			mav.addObject("tarefas", tarefaProjetoService.listarTarefas(idProjeto));
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping("/cadastro")
	public ModelAndView formCadastroProjeto() {
		mav.clear();
		mav.setViewName("cadastroProjeto");
		mav.addObject("unidadesPrisionais", unidadePrisionalService.listaUnidades());

		return mav;
	}

	@RequestMapping(value = "salvarProjeto", method = RequestMethod.POST)
	public ModelAndView salvarProjeto(Projeto novoProjeto, HttpSession session, RedirectAttributes redirectAttributes) {

		novoProjeto.setUsuario((Usuario) session.getAttribute("usuario"));
		String msg = projetoService.cadastrarProjeto(novoProjeto);

		mav.clear();
		mav.setViewName("cadastroProjeto");
		mav.addObject("idProjeto", novoProjeto.getId());
		mav.addObject("msg", msg);
		return mav;
	}

	@RequestMapping(value = "editar/{idProjeto}")
	public ModelAndView formEditarProjeto(@PathVariable("idProjeto") long idProjeto) {
		mav.clear();
		mav.setViewName("editarProjeto");
		mav.addObject("projeto", projetoService.buscarProjetoPorId(idProjeto));
		return mav;
	}

	@RequestMapping(value = "editarProjeto", method = RequestMethod.POST)
	public String editarProjeto(Projeto projeto) {
		projetoService.editarProjeto(projeto);
		return "redirect:/painel/projetos/";
	}

	@ResponseBody
	@RequestMapping("/listarProjetos")
	public List<Projeto> listarProjetos() {
		return projetoService.listarTodosProjetos();
	}

	@RequestMapping("{idProjeto}/adicionarInformacoes")
	public ModelAndView informacoesProjeto(@PathVariable("idProjeto") Long idProjeto) {
		mav.clear();
		mav.setViewName("informacoesProjeto");
		mav.addObject("info", projetoService.buscarInformacaoProjetoPorIdProjeto(idProjeto));
		return mav;
	}

	@RequestMapping("salvarInformacoes")
	public String salvarInformacoes(InformacaoProjeto informacoes, HttpSession session) {
		informacoes.setUsuario((Usuario) session.getAttribute("usuario"));
		projetoService.cadastrarInformacoesAdicionais(informacoes);
		return "redirect:/painel/projetos/";
	}

	@RequestMapping("{idProjeto}/exibirInformacoes")
	public ModelAndView exibirInformacoes(@PathVariable("idProjeto") Long idProjeto) {

		mav.clear();
		InformacaoProjeto info = projetoService.buscarInformacaoProjetoPorIdProjeto(idProjeto);
		if (info.getInformacoes() != null && !info.getInformacoes().isEmpty()) {
			mav.setViewName("exibirInformacoes");
			mav.addObject("info", info);
		} else {
			mav.setViewName("redirect:/painel/projetos/" + idProjeto + "/adicionarInformacoes");
		}
		return mav;
	}
	
	@RequestMapping("{idProjeto}/tarefas/cadastro")
	public ModelAndView formCadastroTarefa(@PathVariable Long idProjeto){
		mav.clear();
		mav.setViewName("cadastroTarefaProjeto");
		mav.addObject("associados", participacaoProjetoService.listarAssociadosDoProjeto(idProjeto));
		return mav;
	}
	
	@RequestMapping("tarefas/salvarTarefa")
	public String salvarTarefa(TarefaProjeto tarefa, HttpSession session){
		tarefa.setAutor((Usuario) session.getAttribute("usuario"));
		tarefaProjetoService.cadastrar(tarefa);
		return "redirect:/painel/projetos/"+tarefa.getProjeto().getId()+"/tarefas";
	}
	
	@RequestMapping("{idProjeto}/tarefas")
	public ModelAndView listarTarefasProjeto(@PathVariable long idProjeto){
		mav.clear();
		mav.setViewName("listarTarefaProjeto");
		mav.addObject("tarefas", tarefaProjetoService.listarTarefas(idProjeto));
		return mav;
	}
	
	@RequestMapping("{idProjeto}/tarefas/{idTarefa}/editar")
	public ModelAndView formEditarTarefa(@PathVariable long idProjeto, @PathVariable long idTarefa){
		mav.clear();
		mav.setViewName("editarTarefaProjeto");
		mav.addObject("tarefa", tarefaProjetoService.buscarTarefaPorId(idTarefa));
		mav.addObject("associados", participacaoProjetoService.listarAssociadosDoProjeto(idProjeto));
		
		return mav;
	}
	
	@RequestMapping("tarefas/editarTarefa")
	public String editarTarefa(TarefaProjeto tarefa){
		tarefaProjetoService.editar(tarefa);
		return "redirect:/painel/projetos/"+tarefa.getProjeto().getId()+"/tarefas";
	}
	
	@RequestMapping("concluirTarefa")
	public String concluirTarefa(long idTarefa){
		TarefaProjeto tarefa = tarefaProjetoService.concluirTarefa(idTarefa);
		return "redirect:/painel/projetos/"+tarefa.getProjeto().getId()+"/tarefas";
	}
}