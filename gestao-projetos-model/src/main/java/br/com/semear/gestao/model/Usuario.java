package br.com.semear.gestao.model;

import java.util.Calendar;

public class Usuario {
	private long id;
	private String nome;
	private String usuario;
	private String senha;
	private Perfil perfil;
	private Parceiro parceiro;
	private Calendar dataCadastro;
	private boolean realizaLogin;

	public Usuario(Long id) {
		this.id = id;
	}

	public Usuario() {

	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getUsuario() {
		return usuario;
	}

	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}

	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) {
		this.senha = senha;
	}

	public Perfil getPerfil() {
		return perfil;
	}

	public void setPerfil(Perfil perfil) {
		this.perfil = perfil;
	}

	public Calendar getDataCadastro() {
		return dataCadastro;
	}

	public void setDataCadastro(Calendar dataCadastro) {
		this.dataCadastro = dataCadastro;
	}

	public boolean getRealizaLogin() {
		return realizaLogin;
	}

	public void setRealizaLogin(boolean realizaLogin) {
		this.realizaLogin = realizaLogin;
	}

	public Parceiro getParceiro() {
		return parceiro;
	}

	public void setParceiro(Parceiro parceiro) {
		this.parceiro = parceiro;
	}
}