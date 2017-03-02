/////////////////////////////////////////////////////PILOTOS//////////////////////////////////////
======SITE======================================NÚM DOCS===========TAM GB========
KA	USINA DE PELOTIZACAO - SAO LUIS (MA)							16,3
KK	SISTEMA NORTE - GERAL - PA - MA 								10,8
KL	CARAJAS SERRA LESTE - PA 										32,6
KM	MANGANES DO AZUL - PA 											10,5
LL	ALEGRIA - MG 								38536				42,3
OP	ONCA PUMA - PA 													77,2
SA	SALOBO - PA 													109,59
SS	SOSSEGO - PA 													35,7	
 																334,99

PZ - Teste
select count(*) from engdo_documento_engenharia where codigo_site = 'PZ'
select (sum(full_content_size)/1048576.0) from engdo_documento_engenharia where codigo_site = 'PZ'

//////////////////////////////////////////////////////////////////Dados do Site///////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////dm_format///////////////////////////////////////////////////////////////////////////////
select * from dm_format order by name
//Tem que criar o formato cit em produção
Tem que verificar os formados que existem na base do 1.0 e que não existe no 2.o

Nome/default file Extension = cit
description: Intergraph Bitmap Image File


//////////////////////////////////////////////////////////////////engso_empresa///////////////////////////////////////////////////////////////////////////////
//Pega todas as empresas utilizadas pelo Site
select emp.r_object_id, emp.object_name, emp.cnpj, emp.nome_fantasia, emp.razao_social, emp.empresa_vale, emp.endereco_completo from engso_empresa emp 

//Pega empresas de um site
select distinct emp.r_object_id, emp.object_name, emp.cnpj, emp.nome_fantasia, emp.razao_social, emp.empresa_vale, emp.endereco_completo from engso_empresa_projeto ep, engso_empresa emp  
where ep.id_empresa = emp.r_object_id and ep.codigo_site = 'PZ'
order by emp.object_name

//////////////////////////////////////////////////////////////////engso_empresa_projeto////////////////////////////////////////////////////////////////////

//Objeto que faz associação entre doc e empresa, para isso criei um objteto só para fazer o de-para no 2.0
select ep.id_empresa, ep.r_object_id, emp.nome_fantasia, ep.codigo_site
from engso_empresa_projeto ep, engso_empresa emp 
where ep.id_empresa = emp.r_object_id and ep.codigo_site = 'PZ'

//query na base nova:
select id_empresa, id_empproj, nome_fantasia, codigo_site from  migration_empresa_projeto  where codigo_site = 'KM'


08035f518222b06f
08035f518222b071
08035f518222b073


//////////////////////////////////////////////////////////////////engso_area///////////////////////////////////////////////////////////////////////////////
select r_object_id, object_name,codigo_site,codigo,nome from engso_area where codigo_site = 'OP'


//////////////////////////////////////////////////////////////////engso_subarea//////////////////////////////////////////////////////////////////////////////
select r_object_id, object_name,codigo_site,codigo,nome,codigo_area from engso_subarea where codigo_site = 'OP'





//////////////////////////////////////////////////////////////////engso_projeto///////////////////////////////////////////////////////////////////////////////
//Pega Projetos
Fases de um projeto:
GED 2.0 ---> GED 1.0
fel1				FEL1    F1
fel2				FEL2	F2
fel3				FEL3	F3
cons				CONS	F4


Status dos projetos no 2.0
- Aproved
- Completed

--Teste site OP
--id projetos inativos
08035f518244edd5 - Fel3- Eu inativei
08035f51810d73e2 - cons - Já inativado


select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, '' as data_reuniao,'' as localidade,'' as data_envio,'' as nome_remetente,'' as nome_destinatario,'' as sigla_fluido,'' as sigla_especificacao,'' as sequencial_linha,'' as equipamento,'' as rc_referencia,'' as rp_referencia,'' as rt_referencia,'' as numero_contrato,'' as id_empresa_contratada 
from engdo_documento_engenharia (all) 
where id_projeto = '08035f5180c490ad'
order by i_chronicle_id, i_has_folder, r_creation_date



select distinct (eng.fase), prj.r_object_id, prj.object_name, prj.ativo, prj.sigla_segmento_negocio, prj.numero_projeto, prj.numero_sequencial, prj.tipo, prj.codigo_site, prj.nome, prj.numero_se, prj.data_abertura, prj.responsavel_tecnico, prj.area_responsavel, prj.a_status  
from engdo_documento_engenharia eng, engso_projeto prj  
where eng.id_projeto = prj.r_object_id and prj.tipo = 'PR' and prj.codigo_site = 'OP' 
UNION
select 'OPER' as fase, prj.r_object_id, prj.object_name, prj.ativo, prj.sigla_segmento_negocio, prj.numero_projeto, prj.numero_sequencial, prj.tipo, prj.codigo_site, prj.nome, prj.numero_se, prj.data_abertura, prj.responsavel_tecnico, prj.area_responsavel, prj.a_status  
from engso_projeto prj  
where prj.tipo = 'SE' and codigo_site = 'OP'
////////////////////////////////////////////////////////////////////////engso_tag///////////////////////////////////////////////////////////////////////////
//Pegar tags de site
select * from engso_tag where codigo_site = 'IA' enable (return_top 100)

select ENG.r_object_id, ENG.object_name, ENG.codigo_site, SUB.codigo, SUB.codigo_area, ENG.Sigla, ENG.identificacao, ENG.titulo FROM engso_tag ENG, engso_subarea SUB WHERE  ENG.id_subarea = SUB.r_object_id and ENG.codigo_site = 'OP'

select ENG.r_object_id, ENG.object_name, ENG.codigo_site, SUB.codigo, SUB.codigo_area, ENG.Sigla, ENG.identificacao, ENG.titulo FROM engso_tag ENG, engso_subarea SUB WHERE  ENG.id_subarea = SUB.r_object_id

//////////////////////////////////////////////////////////////////tags antigos///////////////////////////////////////////////////////////////////////////////
//Pegar tags antigos de sites //Não foi possível pegar a área e o site pois a mesma tag é utilziada em vários
select distinct(tag_antigo), codigo_site from engdo_documento_engenharia (all) where codigo_site = 'OP'

select distinct(tag_antigo), codigo_site from engdo_documento_engenharia (all) where codigo_site = 'PZ' and id_projeto in ('08035f51828eaa53', '08035f51828eaa54', '08035f51828eaa55', '08035f51828eaa56') order by tag_antigo

//////////////////////////////////////////////////engdo_documento_engenharia////////////////////////////////////////////////////////////////////////
//Verifica quantidades de documentos por tipo
select r_object_type, count(*) as total
from engdo_documento_engenharia
where codigo_site = 'OP' and
r_object_type not in ('engdo_gr')
group by r_object_type
order by 2


//Todos os tipos exceto os expecificados abaixo, pegando todas as versões
select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, '' as data_reuniao,'' as localidade,'' as data_envio,'' as nome_remetente,'' as nome_destinatario,'' as sigla_fluido,'' as sigla_especificacao,'' as sequencial_linha,'' as equipamento,'' as rc_referencia,'' as rp_referencia,'' as rt_referencia,'' as numero_contrato,'' as id_empresa_contratada 
from engdo_documento_engenharia (all) 
where codigo_site = 'IA' and
r_object_type not in ('engdo_gr','engdo_ca','engdo_dc','engdo_pt','engdo_rp','engdo_mm','engdo_rd','engdo_pc','engdo_mo','engdo_ri', 'engdo_ar', 'engdo_is', 'engdo_ct')
order by i_chronicle_id, i_has_folder, r_creation_date

//Somente os documentos do Tipo engdo_ca, pegando todas as versões
select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, '' as data_reuniao,'' as localidade, data_envio, nome_remetente, nome_destinatario,'' as sigla_fluido,'' as sigla_especificacao,'' as sequencial_linha,'' as equipamento,'' as rc_referencia,'' as rp_referencia,'' as rt_referencia,'' as numero_contrato,'' as id_empresa_contratada 
from engdo_ca (all) 
where codigo_site = 'IA' 
order by i_chronicle_id, i_has_folder, r_creation_date

//Somente os documentos do Tipo engdo_dc, pegando todas as versões
select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, '' as data_reuniao,'' as localidade,'' as data_envio,'' as nome_remetente,'' as nome_destinatario,'' as sigla_fluido,'' as sigla_especificacao,'' as sequencial_linha,'' as equipamento,'' as rc_referencia,'' as rp_referencia,'' as rt_referencia, numero_contrato, id_empresa_contratada 
from engdo_dc (all) 
where codigo_site = 'IA' 
order by i_chronicle_id, i_has_folder, r_creation_date

//Somente os documentos do Tipo engdo_pt, pegando todas as versões
select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, '' as data_reuniao,'' as localidade,'' as data_envio,'' as nome_remetente,'' as nome_destinatario,'' as sigla_fluido,'' as sigla_especificacao,'' as sequencial_linha,'' as equipamento, rc_referencia, rp_referencia, rt_referencia,'' as numero_contrato,'' as id_empresa_contratada 
from engdo_pt (all) 
where codigo_site = 'IA' 
order by i_chronicle_id, i_has_folder, r_creation_date

//Somente os documentos do Tipo engdo_rp, pegando todas as versões
select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, '' as data_reuniao,'' as localidade,'' as data_envio,'' as nome_remetente,'' as nome_destinatario,'' as sigla_fluido,'' as sigla_especificacao,'' as sequencial_linha,'' as equipamento, rc_referencia,'' as rp_referencia, rt_referencia,'' as numero_contrato,'' as id_empresa_contratada 
from engdo_rp (all) 
where codigo_site = 'IA' 
order by i_chronicle_id, i_has_folder, r_creation_date

//Soment os documento do Tipo engdo_mm, pegando todas as versões
select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, '' as data_reuniao,'' as localidade,'' as data_envio,'' as nome_remetente,'' as nome_destinatario,'' as sigla_fluido,'' as sigla_especificacao,'' as sequencial_linha, equipamento,'' as rc_referencia,'' as rp_referencia,'' as rt_referencia,'' as numero_contrato,'' as id_empresa_contratada 
from engdo_mm (all) 
where codigo_site = 'IA' 
order by i_chronicle_id, i_has_folder, r_creation_date


//Soment os documento do Tipo engdo_rd, pegando todas as versões
select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, '' as data_reuniao,'' as localidade,'' as data_envio,'' as nome_remetente,'' as nome_destinatario,'' as sigla_fluido,'' as sigla_especificacao,'' as sequencial_linha,'' as equipamento,'' as rc_referencia,'' as rp_referencia,'' as rt_referencia,'' as numero_contrato,  id_empresa_contratada 
from engdo_rd (all) 
where codigo_site = 'IA' 
order by i_chronicle_id, i_has_folder, r_creation_date


//Somente os documentos do Tipo engdo_pc, pegando todas as versões
select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, '' as data_reuniao,'' as localidade,'' as data_envio,'' as nome_remetente,'' as nome_destinatario,'' as sigla_fluido,'' as sigla_especificacao,'' as sequencial_linha,'' as equipamento, rc_referencia, rp_referencia, rt_referencia,'' as numero_contrato,'' as id_empresa_contratada 
from engdo_pc (all) 
where codigo_site = 'IA' 
order by i_chronicle_id, i_has_folder, r_creation_date


//Somente os documentos do Tipo engdo_mo, pegando todas as versões
select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, '' as data_reuniao,'' as localidade,'' as data_envio,'' as nome_remetente,'' as nome_destinatario,'' as sigla_fluido,'' as sigla_especificacao,'' as sequencial_linha, equipamento,'' as rc_referencia,'' as rp_referencia,'' as rt_referencia,'' as numero_contrato,'' as id_empresa_contratada 
from engdo_mo (all) 
where codigo_site = 'IA' 
order by i_chronicle_id, i_has_folder, r_creation_date

//Somente os documentos do Tipo engdo_ri, pegando todas as versões
select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, '' as data_reuniao,'' as localidade,'' as data_envio,'' as nome_remetente,'' as nome_destinatario,'' as sigla_fluido,'' as sigla_especificacao,'' as sequencial_linha,'' as equipamento,'' as rc_referencia,'' as rp_referencia,'' as rt_referencia, numero_contrato, id_empresa_contratada 
from engdo_ri (all) 
where codigo_site = 'IA' 
order by i_chronicle_id, i_has_folder, r_creation_date

//Somente os documentos do Tipo engdo_ar, pegando todas as versões
select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, data_reuniao, localidade,'' as data_envio,'' as nome_remetente,'' as nome_destinatario,'' as sigla_fluido,'' as sigla_especificacao,'' as sequencial_linha,'' as equipamento,'' as rc_referencia,'' as rp_referencia,'' as rt_referencia,'' as numero_contrato,'' as id_empresa_contratada 
from engdo_ar (all) 
where codigo_site = 'KM' 
order by i_chronicle_id, i_has_folder, r_creation_date



//Somente os documentos do Tipo engdo_ct, pegando todas as versões
select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, '' as data_reuniao,'' as localidade,'' as data_envio,'' as nome_remetente,'' as nome_destinatario,'' as sigla_fluido,'' as sigla_especificacao,'' as sequencial_linha, equipamento,'' as rc_referencia,'' as rp_referencia,'' as rt_referencia,'' as numero_contrato,'' as id_empresa_contratada 
from engdo_ct (all) 
where codigo_site = 'IA' 
order by i_chronicle_id, i_has_folder, r_creation_date



//Pegando só algumas linhas de projetos
select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, '' as data_reuniao,'' as localidade,'' as data_envio,'' as nome_remetente,'' as nome_destinatario,'' as sigla_fluido,'' as sigla_especificacao,'' as sequencial_linha,'' as equipamento,'' as rc_referencia,'' as rp_referencia,'' as rt_referencia,'' as numero_contrato,'' as id_empresa_contratada  
from engdo_documento_engenharia (all)   
where codigo_site = 'KM' and r_object_type not in ('engdo_gr','engdo_ca','engdo_dc','engdo_pt','engdo_rp','engdo_mm','engdo_rd','engdo_pc','engdo_mo','engdo_ri', 'engdo_ar', 'engdo_is', 'engdo_ct') 
and i_chronicle_id in ('09035f518222dd26', '09035f518222dd27', '09035f518222dd28', '09035f518222dd2c', '09035f518222dd2d', '09035f518222dd2e','09035f518222dd5b', '09035f518222dd8e', '09035f5182231909', '09035f518223190a', '09035f518223190b', '09035f518223192f', '09035f51822cdbdd', '09035f51822d9df0', '09035f51823011ac')  
order by i_chronicle_id, i_has_folder, r_creation_date

//Pegando só algumas linhas de SEs
select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, '' as data_reuniao,'' as localidade,'' as data_envio,'' as nome_remetente,'' as nome_destinatario,'' as sigla_fluido,'' as sigla_especificacao,'' as sequencial_linha,'' as equipamento,'' as rc_referencia,'' as rp_referencia,'' as rt_referencia,'' as numero_contrato,'' as id_empresa_contratada 
from engdo_documento_engenharia (all) 
where codigo_site = 'KM' and
fase = 'OPER' and
r_object_type not in ('engdo_gr','engdo_ca','engdo_dc','engdo_pt','engdo_rp','engdo_mm','engdo_rd','engdo_pc','engdo_mo','engdo_ri', 'engdo_ar', 'engdo_is', 'engdo_ct')
order by i_chronicle_id, i_has_folder, r_creation_date


//Pegando só algumas linhas de Anexos
select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, '' as data_reuniao,'' as localidade,'' as data_envio,'' as nome_remetente,'' as nome_destinatario,'' as sigla_fluido,'' as sigla_especificacao,'' as sequencial_linha,'' as equipamento,'' as rc_referencia,'' as rp_referencia,'' as rt_referencia,'' as numero_contrato,'' as id_empresa_contratada 
from engdo_documento_engenharia (all) 
where codigo_site = 'KM' and
fase = 'OPER' and
r_object_type not in ('engdo_gr','engdo_ca','engdo_dc','engdo_pt','engdo_rp','engdo_mm','engdo_rd','engdo_pc','engdo_mo','engdo_ri', 'engdo_ar', 'engdo_is', 'engdo_ct')
and numero_vale in ('CR-5760KM-G-08921', '5620KM-A-10243', 'CR-5710KM-G-10021', '5830KM-B-09000', 'CR-5000KM-F-53000', 'CR-5000KM-G-53001','MC-5000KM-S-53001') 
order by i_chronicle_id, i_has_folder, r_creation_date

select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, '' as data_reuniao,'' as localidade,'' as data_envio,'' as nome_remetente,'' as nome_destinatario,'' as sigla_fluido,'' as sigla_especificacao,'' as sequencial_linha,'' as equipamento,'' as rc_referencia,'' as rp_referencia,'' as rt_referencia,'' as numero_contrato,'' as id_empresa_contratada 
from engdo_documento_engenharia (all) 
where codigo_site = 'KM' 
and r_object_type not in ('engdo_gr', 'engdo_ca','engdo_dc','engdo_pt','engdo_rp','engdo_mm','engdo_rd','engdo_pc','engdo_mo','engdo_ri', 'engdo_ar', 'engdo_is', 'engdo_ct')
and numero_vale in ('RL-0124OP-G-81301') 
order by i_chronicle_id, i_has_folder, r_creation_date


select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, '' as data_reuniao,'' as localidade,'' as data_envio,'' as nome_remetente,'' as nome_destinatario,'' as sigla_fluido,'' as sigla_especificacao,'' as sequencial_linha,'' as equipamento,'' as rc_referencia,'' as rp_referencia,'' as rt_referencia,'' as numero_contrato,'' as id_empresa_contratada 
from engdo_documento_engenharia (all) 
where codigo_site = 'KM' 
and r_object_type not in ('engdo_gr', 'engdo_ca','engdo_dc','engdo_pt','engdo_rp','engdo_mm','engdo_rd','engdo_pc','engdo_mo','engdo_ri', 'engdo_ar', 'engdo_is', 'engdo_ct')
and r_object_id = '09035f51827794da'
order by i_chronicle_id, i_has_folder, r_creation_date




select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, '' as data_reuniao,'' as localidade,'' as data_envio,'' as nome_remetente,'' as nome_destinatario,'' as sigla_fluido,'' as sigla_especificacao,'' as sequencial_linha,'' as equipamento,'' as rc_referencia,'' as rp_referencia,'' as rt_referencia,'' as numero_contrato,'' as id_empresa_contratada 
from engdo_documento_engenharia (all) 
where codigo_site = 'PZ' 
and id_projeto = '08035f51828eaa54'
and r_object_type not in ('engdo_gr', 'engdo_ca','engdo_dc','engdo_pt','engdo_rp','engdo_mm','engdo_rd','engdo_pc','engdo_mo','engdo_ri', 'engdo_ar', 'engdo_is', 'engdo_ct')
order by i_chronicle_id, i_has_folder, r_creation_date

select count(*)
from engdo_documento_engenharia (all) 
where codigo_site = 'PZ' 
and id_projeto = '08035f51820be007'
order by 1
738

id_projeto 		  Totais 	Totais Eng 	Totais GR
08035f51828eaa53 -	163 	- 	67 		- 	xx
08035f51828eaa54 - 	170 	- 	74		-	
08035f51828eaa55 - 	136 	- 	40		-	
08035f51828eaa56 - 	136 	- 	40		-	


	
///////////////////////////////////////////////////engdo_anexo//////////////////////////////////////////////////////////////////////////////////////

select anexo.r_object_id, anexo.i_antecedent_id, anexo.i_chronicle_id, anexo.object_name, anexo.numero_vale_doc_principal, anexo.title, anexo.numero_referencia, anexo.revisao_doc_principal, anexo.a_content_type, eng.codigo_site, anexo.i_has_folder, anexo.r_creation_date
from engdo_anexo (all) anexo, engdo_documento_engenharia eng 
where  anexo.numero_vale_doc_principal = eng.numero_vale and eng.codigo_site = 'KM' 
order by anexo.i_chronicle_id, anexo.i_has_folder, anexo.r_creation_date



select anexo.r_object_id, anexo.i_antecedent_id, anexo.i_chronicle_id, anexo.object_name, anexo.numero_vale_doc_principal, anexo.title, anexo.numero_referencia, anexo.revisao_doc_principal, anexo.a_content_type, eng.codigo_site, anexo.i_has_folder, anexo.r_creation_date
from engdo_anexo (all) anexo, engdo_documento_engenharia eng 
where  anexo.numero_vale_doc_principal = eng.numero_vale and eng.codigo_site = 'OP' 
and anexo.numero_vale_doc_principal in ('DF-1213OP-G-96490-E-00003','DF-1213OP-G-96490-J-00003','DF-1213OP-G-96490-J-00007','0200OP-J-14202','0200OP-J-14205','0124OP-G-80511')
order by anexo.i_chronicle_id, anexo.i_has_folder, anexo.r_creation_date

select anexo.r_object_id, anexo.i_antecedent_id, anexo.i_chronicle_id, anexo.object_name, anexo.numero_vale_doc_principal, anexo.title, anexo.numero_referencia, anexo.revisao_doc_principal, anexo.a_content_type, eng.codigo_site, anexo.i_has_folder, anexo.r_creation_date
from engdo_anexo (all) anexo, engdo_documento_engenharia eng 
where  anexo.numero_vale_doc_principal = eng.numero_vale and eng.codigo_site = 'PZ' 
and eng.id_projeto = '08035f51820be007'
order by anexo.i_chronicle_id, anexo.i_has_folder, anexo.r_creation_date



////////////////////////////////////////////////////////////////////////Processar GR///////////////////////////////////////////////////////////////////

A gr é criada de forma que o engso_documento_gr, associa um documento engdo_gr as vários documentos de engenharia. Após a importação vou ter que fazer uma query atualianzando alguns campos dos documentos importados para permitir o relacionamento.
- Ainda tem que detalhar quais campos serão atualizado, quais as mudanças nos Lfs para permitir isso.
- Os atributos específicos da GR serão migrados?
-
-
-

select doc.r_object_id as id_gr , doc.numero_vale as numero_vale_gr, doc2.r_object_id as id_doc, doc2.numero_vale as numero_vale_doc
from engso_documento_gr (all) gr, engdo_gr (all) doc, engdo_documento_engenharia(all) doc2
where 
gr.id_guia_remessa = doc.r_object_id and 
doc.codigo_site = 'KM' and
gr.id_documento_engenharia = doc2.r_object_id 
and doc.numero_vale = 'GR-0000KM-G-00008/2013'

'GR-0000KM-G-00040/2013', 'GR-0000KM-G-00041/2013', 'GR-0000KM-G-00042/2013', 'GR-0000KM-G-00043/2013', 'GR-0000KM-G-00044/2013', 'GR-0000KM-G-00045/2013', 'GR-0000KM-G-00045/2013', 'GR-0000KM-G-00047/2013', 'GR-0000KM-G-00048/2013', 'GR-0000KM-G-00049/2013'

doc.r_object_id in ('09035f518142b0d1', '09035f518142b19a','09035f5181438c8f','09035f51814395d2','09035f518143967b','09035f5181439b1f','09035f518143dfbb','09035f51814424a0','09035f518144ea1a','09035f518144f3b3')

r_object_id in ('09035f51813de9f5','09035f51813f8f22','09035f518141278a','09035f51814269bc','09035f5181426b73','09035f518143dfe6','09035f51814269c8','09035f51814269d0','09035f51813ee53e','09035f5181412a4f','09035f51814374cf')


select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, object_name, title, id_projeto, numero_vale, id_empresa_projeto, codigo_site, observacoes, tipo_gr, nome_destinatario, nome_remetente, nome_coordenador, data_emissao_gr, numero_contratada
from engdo_gr (all)
where codigo_site = 'PZ' 
and id_projeto in ('08035f51828eaa53','08035f51828eaa54','08035f51828eaa55','08035f51828eaa56')
order by i_chronicle_id, i_has_folder, r_creation_date


select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, object_name, title, id_projeto, numero_vale, id_empresa_projeto, codigo_site, observacoes, tipo_gr, nome_destinatario, nome_remetente, nome_coordenador, data_emissao_gr, numero_contratada
from engdo_gr (all)
where codigo_site = 'PZ' 
order by i_chronicle_id, i_has_folder, r_creation_date


select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, object_name, title, id_projeto, numero_vale, id_empresa_projeto, codigo_site, observacoes, tipo_gr, nome_destinatario, nome_remetente,  fase 
from engdo_gr (all)
where codigo_site = 'KM' and numero_vale like 'GR-0000KM-G-0004%/2013'
order by i_chronicle_id, i_has_folder, r_creation_date

---Depois testar o documento abaixo que é versionado, atenção pois é de outo site
where i_chronicle_id in ('09035f5180c37908')


select doc.r_object_id as id_gr , doc.numero_vale as numero_vale_gr, doc2.r_object_id as id_doc, doc2.numero_vale as numero_vale_doc
from engso_documento_gr (all) gr, engdo_gr (all) doc, engdo_documento_engenharia(all) doc2
where 
gr.id_guia_remessa = doc.r_object_id and 
doc.codigo_site = 'KM' and
gr.id_documento_engenharia = doc2.r_object_id 
and doc.numero_vale in ('GR-0000KM-G-00040/2013', 'GR-0000KM-G-00041/2013', 'GR-0000KM-G-00042/2013', 'GR-0000KM-G-00043/2013', 'GR-0000KM-G-00044/2013', 'GR-0000KM-G-00045/2013', 'GR-0000KM-G-00045/2013', 'GR-0000KM-G-00047/2013', 'GR-0000KM-G-00048/2013', 'GR-0000KM-G-00049/2013')

select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, '' as data_reuniao,'' as localidade,'' as data_envio,'' as nome_remetente,'' as nome_destinatario,'' as sigla_fluido,'' as sigla_especificacao,'' as sequencial_linha,'' as equipamento,'' as rc_referencia,'' as rp_referencia,'' as rt_referencia,'' as numero_contrato,'' as id_empresa_contratada 
from engdo_documento_engenharia (all) 
where codigo_site = 'KM' 
and r_object_type not in ('engdo_gr','engdo_ca','engdo_dc','engdo_pt','engdo_rp','engdo_mm','engdo_rd','engdo_pc','engdo_mo','engdo_ri', 'engdo_ar', 'engdo_is', 'engdo_ct')
and i_chronicle_id in ('09035f51813a97c0','09035f51813a97ce','09035f51813a97cf','09035f51813a97d1','09035f51813a97d4','09035f51813a97e6','09035f51813a97f3','09035f51813a97f4','09035f51813a97f7','09035f51813a97f9','09035f51813ac1a0')
order by i_chronicle_id, i_has_folder, r_creation_date


CREATE dm_relation OBJECT
SET relation_name = 'D2_COPY_OF',
SET child_id = (SELECT r_object_id FROM vale_eng_package(all) WHERE legacy_uid = '09035f5181438c8f'),
SET parent_id = (SELECT r_object_id FROM vale_eng_document(all) WHERE vale_legacy_objectid = '09035f51813de9f5')


select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, object_name, title, id_projeto, numero_vale, id_empresa_projeto, codigo_site, observacoes, tipo_gr, nome_destinatario, nome_remetente, nome_coordenador, data_emissao_gr, numero_contratada
from engdo_gr (all)
where codigo_site = 'PZ' 
and id_projeto in ('08035f51828eaa53','08035f51828eaa54','08035f51828eaa55','08035f51828eaa56')
order by i_chronicle_id, i_has_folder, r_creation_date


////////////////////////////////////////////////////////////////////////content file path///////////////////////////////////////////////////////////////////
//Pega o caminho de um arquivo
getpath,c,090003e98004fdfb



//////////////////////////////////////////////////////////////////Gerais///////////////////////////////////////////////////////////////////////////////
select * from  vale_eng_area
select * from vale_eng_site 
select * from engdo_documento_engenharia

vale disciplina
vale_documnento_base
  id_projeto                      : 08035f5180019888

  fase                            : FEL1
  id_empresa_projeto              : 08035f51800198ce
  
  
///////////////////////////////////////////////////////////Objecto de segurança///////////////////////////////////////////////////////////////////////////
select r_object_id,object_name, vale_site, vale_ct_exclusao, vale_ct_cadastro_ficha, vale_ct_revisao, vale_ct_download_completo, vale_ct_download_basico, vale_ct_brava_completo, vale_ct_download_basico, vale_ct_brava_completo, vale_ct_brava_basico, vale_ct_pdf_basico, vale_ct_pdf_completo, vale_ct_pdf_medio 
from vale_eng_ct_acesso 
where vale_site = 'km' 
order by vale_site 


///////////////////////////////////////////////////////////Documentos que possuem anexo///////////////////////////////////////////////////////////////////
select doc.r_object_id, count(anx.r_object_id), doc.numero_vale, doc.r_object_type, doc.a_status
from engdo_documento_engenharia (all) doc, engdo_anexo anx   
where doc.numero_vale = anx.numero_vale_doc_principal and doc.codigo_site = 'IA' and doc.r_object_type != 'engdo_gr'
group by doc.r_object_id, doc.object_name, doc.numero_vale, doc.r_object_type 


///////////////////////////////////////////////////////////SOMENTE SERÁ MIGRADO APÓS GOLIVE////////////////////////////////////////////////////////////////

//Somente os documentos do Tipo engdo_is, pegando todas as versões
select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, '' as data_reuniao,'' as localidade,'' as data_envio,'' as nome_remetente,'' as nome_destinatario, sigla_fluido, sigla_especificacao, sequencial_linha,'' as equipamento,'' as rc_referencia,'' as rp_referencia,'' as rt_referencia,'' as numero_contrato,'' as id_empresa_contratada 
from engdo_is (all) 
where codigo_site = 'IA' 
order by i_chronicle_id, i_has_folder, r_creation_date


///////////////////////////////////////////////////////////TESTE HANDOVER////////////////////////////////////////////////////////////////

i_chronicle_id in ('09035f51803b0137','09035f51803b0138','09035f51803b0139','09035f51803b013a','09035f51803b013b','09035f51803b013c','09035f51803b013d','09035f51803b013e','09035f51803b013f','09035f51803b0140','09035f51803b0159','09035f51803b015a','09035f51803b015b','09035f51803b015c','09035f51803b015d','09035f51803b015e','09035f51803b015f','09035f51803b0160','09035f51803b0161','09035f51803b0161')