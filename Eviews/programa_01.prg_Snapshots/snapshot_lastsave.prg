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
m_irf_dspx_std.line
m_irf_dcrb_std.line
m_irf_dcds_std.line
m_irf_vix_std.line

' plota grafcos
m_irf_dspx.line
m_irf_dcrb.line
m_irf_dcds.line
m_irf_vix.line


