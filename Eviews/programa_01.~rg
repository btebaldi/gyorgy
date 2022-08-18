' abre o workfile
wfopen C:\Users\bteba\Documents\Github\gyorgy\Eviews\workfile.wf1

' Agrupa as variaveis de interesse
group group_variaveis alternativo inflacao internacional multimercados pos_fixado pre_fixado  renda_variavel sem_classificacao

' Salva as variaveis como matrizes
stom(group_variaveis, group_variaveis_matrix)

' Salva a media de cada coluna
matrix G_Medias = @cmean(group_variaveis_matrix)

' Salva o desvio de cada coluna
matrix G_Desvios = @cstdev(group_variaveis_matrix)

' Analise de screen plot
group_variaveis.pcomp(out=graph, scree)

' Calcula os componentes principais e a matriz de carga
group_variaveis.makepcomp(loading=load) pca1 pca2

' estima o VAR
var var01.ls 1 1 pca1 pca2 dspx dcrb dcds vix @ c covid19 covid1901 
var var05.ls 1 5 pca1 pca2 dspx dcrb dcds vix @ c covid19 covid1901 

' Estima um VAR restrito 
var01.ls 1 1 pca1 pca2 dspx dcrb dcds vix @ c covid19 covid1901  @restrict @vec(l1) = "na, na, 0, 0, 0, 0, na, na, 0, 0, 0, 0, na, na, na, na, na, na, na, na, 0, na, na, na, na, na, 0, 0, na, 0, na, na, na, na, na, na"

' Estima um VAR restrito

' Apaga IRF_response caso exista
if @isobject("IRF_response") then
	delete IRF_response
endif

' calcula o impulso resposta
var01.impulse(12, a, se=a, rmat=IRF_response) pca1 pca2 @imp dspx dcrb dcds vix

' Resposta padronizadas
matrix m_irf_dspx_std  = @hcat(@columnextract(irf_response, 1), @columnextract(irf_response, 5))*  @transpose(load)
matrix m_irf_dcrb_std  = @hcat(@columnextract(irf_response, 2), @columnextract(irf_response, 6))*  @transpose(load)
matrix m_irf_dcds_std  = @hcat(@columnextract(irf_response, 3), @columnextract(irf_response, 7))*  @transpose(load)
matrix m_irf_vix_std  = @hcat(@columnextract(irf_response, 4), @columnextract(irf_response, 8))*  @transpose(load)

' Respostas no nivel
matrix m_irf_dspx = m_irf_dspx_std * @makediagonal(g_desvios) + @ones(12,8) * @makediagonal(g_desvios)
matrix m_irf_dcrb = m_irf_dcrb_std * @makediagonal(g_desvios) + @ones(12,8) * @makediagonal(g_desvios)
matrix m_irf_dcds = m_irf_dcds_std * @makediagonal(g_desvios) + @ones(12,8) * @makediagonal(g_desvios)
matrix m_irf_vix = m_irf_vix_std * @makediagonal(g_desvios) + @ones(12,8) * @makediagonal(g_desvios)

' plota grafcos padronizados
freeze(tab_dspx_std) m_irf_dspx_std.line
tab_dspx_std.setelem(1) legend(Alternativo)
tab_dspx_std.setelem(2) legend(Inflacao)
tab_dspx_std.setelem(3) legend(Internacional)
tab_dspx_std.setelem(4) legend(Multimercado)
tab_dspx_std.setelem(5) legend(Pos fixado)
tab_dspx_std.setelem(6) legend(Pre fixado)
tab_dspx_std.setelem(7) legend(Renda variavel)
tab_dspx_std.setelem(8) legend(Sem classificacao)

freeze(tab_dcrb_std) m_irf_dcrb_std.line
tab_dcrb_std.setelem(1) legend(Alternativo)
tab_dcrb_std.setelem(2) legend(Inflacao)
tab_dcrb_std.setelem(3) legend(Internacional)
tab_dcrb_std.setelem(4) legend(Multimercado)
tab_dcrb_std.setelem(5) legend(Pos fixado)
tab_dcrb_std.setelem(6) legend(Pre fixado)
tab_dcrb_std.setelem(7) legend(Renda variavel)
tab_dcrb_std.setelem(8) legend(Sem classificacao)

freeze(tab_dcds_std) m_irf_dcds_std.line
tab_dcds_std.setelem(1) legend(Alternativo)
tab_dcds_std.setelem(2) legend(Inflacao)
tab_dcds_std.setelem(3) legend(Internacional)
tab_dcds_std.setelem(4) legend(Multimercado)
tab_dcds_std.setelem(5) legend(Pos fixado)
tab_dcds_std.setelem(6) legend(Pre fixado)
tab_dcds_std.setelem(7) legend(Renda variavel)
tab_dcds_std.setelem(8) legend(Sem classificacao)

freeze(tab_vix_std) m_irf_vix_std.line
tab_vix_std.setelem(1) legend(Alternativo)
tab_vix_std.setelem(2) legend(Inflacao)
tab_vix_std.setelem(3) legend(Internacional)
tab_vix_std.setelem(4) legend(Multimercado)
tab_vix_std.setelem(5) legend(Pos fixado)
tab_vix_std.setelem(6) legend(Pre fixado)
tab_vix_std.setelem(7) legend(Renda variavel)
tab_vix_std.setelem(8) legend(Sem classificacao)

tab_dspx_std.addtext(t) "Choque no SPX"
tab_dcrb_std.addtext(t) "Choque no CRB"
tab_dcds_std.addtext(t) "Choque no CDS"
 tab_vix_std.addtext(t) "Choque no VIX"

tab_dspx_std.save(t=png, c, box, port, w=6.9, h = 5.0, u=in, d=96, trans) c:\users\bteba\documents\tab_dspx_std.png
tab_dcrb_std.save(t=png, c, box, port, w=6.9, h = 5.0, u=in, d=96, trans) c:\users\bteba\documents\tab_dcrb_std.png
tab_dcds_std.save(t=png, c, box, port, w=6.9, h = 5.0, u=in, d=96, trans) c:\users\bteba\documents\tab_dcds_std.png
 tab_vix_std.save(t=png, c, box, port, w=6.9, h = 5.0, u=in, d=96, trans) c:\users\bteba\documents\tab_vix_std.png

' plota grafcos
m_irf_dspx.line
m_irf_dcrb.line
m_irf_dcds.line
m_irf_vix.line


' Fecha o Workfile
'wfclose c:\users\bteba\documents\github\gyorgy\eviews\workfile.wf1

