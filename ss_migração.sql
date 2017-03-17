/////////////////////////////////////////////////////PILOTOS//////////////////////////////////////
======SITE======================================NÚM DOCS===========TAM GB========
SS	SOSSEGO - PA 													40,7	

////////////////////////////////////////////////////////Atualização do status dos projetos////////////////////////////////////////////////////////////////
update engso_projeto objects set a_status = '1' where codigo_site = 'SS' and r_object_id in ('08035f51816070ea', '08035f51816258ec', '08035f5181624d9e')
update engso_projeto prj  objects set a_status = '2' where codigo_site = 'SS'

//////////////////////////////////////////////////////////////////engso_empresa///////////////////////////////////////////////////////////////////////////////
//Pega empresas de um site
select distinct emp.r_object_id, emp.object_name, emp.cnpj, emp.nome_fantasia, emp.razao_social, emp.empresa_vale, emp.endereco_completo from engso_empresa_projeto ep, engso_empresa emp  
where ep.id_empresa = emp.r_object_id and ep.codigo_site = 'SS'
order by emp.object_name

//////////////////////////////////////////////////////////////////engso_empresa_projeto////////////////////////////////////////////////////////////////////
//Objeto que faz associação entre doc e empresa, para isso criei um objteto só para fazer o de-para no 2.0
select ep.id_empresa, ep.r_object_id, emp.nome_fantasia, ep.codigo_site
from engso_empresa_projeto ep, engso_empresa emp 
where ep.id_empresa = emp.r_object_id and ep.codigo_site = 'SS'

//////////////////////////////////////////////////////////////////engso_area///////////////////////////////////////////////////////////////////////////////
select r_object_id, object_name,codigo_site,codigo,nome from engso_area where codigo_site = 'SS'

//////////////////////////////////////////////////////////////////engso_subarea//////////////////////////////////////////////////////////////////////////////
select r_object_id, object_name,codigo_site,codigo,nome,codigo_area from engso_subarea where codigo_site = 'SS'

//////////////////////////////////////////////////////////////////engso_projeto///////////////////////////////////////////////////////////////////////////////
//Pega Projetos

select distinct (eng.fase), prj.r_object_id, prj.object_name, prj.ativo, prj.sigla_segmento_negocio, prj.numero_projeto, prj.numero_sequencial, prj.tipo, prj.codigo_site, prj.nome, prj.numero_se, prj.data_abertura, prj.responsavel_tecnico, prj.area_responsavel, prj.a_status  
from engdo_documento_engenharia eng, engso_projeto prj  
where eng.id_projeto = prj.r_object_id and prj.tipo = 'PR' and prj.codigo_site = 'SS' 
UNION
select 'OPER' as fase, prj.r_object_id, prj.object_name, prj.ativo, prj.sigla_segmento_negocio, prj.numero_projeto, prj.numero_sequencial, prj.tipo, prj.codigo_site, prj.nome, prj.numero_se, prj.data_abertura, prj.responsavel_tecnico, prj.area_responsavel, prj.a_status  
from engso_projeto prj  
where prj.tipo = 'SE' and codigo_site = 'SS'
////////////////////////////////////////////////////////////////////////engso_tag///////////////////////////////////////////////////////////////////////////
//Pegar tags de site

select ENG.r_object_id, ENG.object_name, ENG.codigo_site, SUB.codigo, SUB.codigo_area, ENG.Sigla, ENG.identificacao, ENG.titulo FROM engso_tag ENG, engso_subarea SUB WHERE  ENG.id_subarea = SUB.r_object_id and ENG.codigo_site = 'SS'


//////////////////////////////////////////////////////////////////tags antigos///////////////////////////////////////////////////////////////////////////////
//Pegar tags antigos de sites //Não foi possível pegar a área e o site pois a mesma tag é utilziada em vários
select distinct(tag_antigo), codigo_site from engdo_documento_engenharia (all) where codigo_site = 'SS'


//////////////////////////////////////////////////engdo_documento_engenharia////////////////////////////////////////////////////////////////////////
//Verifica quantidades de documentos por tipo

//Todos os tipos exceto os expecificados abaixo, pegando todas as versões
select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, '' as data_reuniao,'' as localidade,'' as data_envio,'' as nome_remetente,'' as nome_destinatario,'' as sigla_fluido,'' as sigla_especificacao,'' as sequencial_linha,'' as equipamento,'' as rc_referencia,'' as rp_referencia,'' as rt_referencia,'' as numero_contrato,'' as id_empresa_contratada 
from engdo_documento_engenharia (all) 
where codigo_site = 'SS' and
r_object_type not in ('engdo_gr','engdo_ca','engdo_dc','engdo_pt','engdo_rp','engdo_mm','engdo_rd','engdo_pc','engdo_mo','engdo_ri', 'engdo_ar', 'engdo_is', 'engdo_ct')
order by i_chronicle_id, i_has_folder, r_creation_date

//Somente os documentos do Tipo engdo_ca, pegando todas as versões
select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, '' as data_reuniao,'' as localidade, data_envio, nome_remetente, nome_destinatario,'' as sigla_fluido,'' as sigla_especificacao,'' as sequencial_linha,'' as equipamento,'' as rc_referencia,'' as rp_referencia,'' as rt_referencia,'' as numero_contrato,'' as id_empresa_contratada 
from engdo_ca (all) 
where codigo_site = 'SS' 
order by i_chronicle_id, i_has_folder, r_creation_date

//Somente os documentos do Tipo engdo_dc, pegando todas as versões
select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, '' as data_reuniao,'' as localidade,'' as data_envio,'' as nome_remetente,'' as nome_destinatario,'' as sigla_fluido,'' as sigla_especificacao,'' as sequencial_linha,'' as equipamento,'' as rc_referencia,'' as rp_referencia,'' as rt_referencia, numero_contrato, id_empresa_contratada 
from engdo_dc (all) 
where codigo_site = 'SS' 
order by i_chronicle_id, i_has_folder, r_creation_date

//Somente os documentos do Tipo engdo_pt, pegando todas as versões
select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, '' as data_reuniao,'' as localidade,'' as data_envio,'' as nome_remetente,'' as nome_destinatario,'' as sigla_fluido,'' as sigla_especificacao,'' as sequencial_linha,'' as equipamento, rc_referencia, rp_referencia, rt_referencia,'' as numero_contrato,'' as id_empresa_contratada 
from engdo_pt (all) 
where codigo_site = 'SS' 
order by i_chronicle_id, i_has_folder, r_creation_date

//Somente os documentos do Tipo engdo_rp, pegando todas as versões
select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, '' as data_reuniao,'' as localidade,'' as data_envio,'' as nome_remetente,'' as nome_destinatario,'' as sigla_fluido,'' as sigla_especificacao,'' as sequencial_linha,'' as equipamento, rc_referencia,'' as rp_referencia, rt_referencia,'' as numero_contrato,'' as id_empresa_contratada 
from engdo_rp (all) 
where codigo_site = 'SS' 
order by i_chronicle_id, i_has_folder, r_creation_date

//Soment os documento do Tipo engdo_mm, pegando todas as versões
select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, '' as data_reuniao,'' as localidade,'' as data_envio,'' as nome_remetente,'' as nome_destinatario,'' as sigla_fluido,'' as sigla_especificacao,'' as sequencial_linha, equipamento,'' as rc_referencia,'' as rp_referencia,'' as rt_referencia,'' as numero_contrato,'' as id_empresa_contratada 
from engdo_mm (all) 
where codigo_site = 'SS' 
order by i_chronicle_id, i_has_folder, r_creation_date


//Soment os documento do Tipo engdo_rd, pegando todas as versões
select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, '' as data_reuniao,'' as localidade,'' as data_envio,'' as nome_remetente,'' as nome_destinatario,'' as sigla_fluido,'' as sigla_especificacao,'' as sequencial_linha,'' as equipamento,'' as rc_referencia,'' as rp_referencia,'' as rt_referencia,'' as numero_contrato,  id_empresa_contratada 
from engdo_rd (all) 
where codigo_site = 'SS' 
order by i_chronicle_id, i_has_folder, r_creation_date


//Somente os documentos do Tipo engdo_pc, pegando todas as versões
select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, '' as data_reuniao,'' as localidade,'' as data_envio,'' as nome_remetente,'' as nome_destinatario,'' as sigla_fluido,'' as sigla_especificacao,'' as sequencial_linha,'' as equipamento, rc_referencia, rp_referencia, rt_referencia,'' as numero_contrato,'' as id_empresa_contratada 
from engdo_pc (all) 
where codigo_site = 'SS' 
order by i_chronicle_id, i_has_folder, r_creation_date


//Somente os documentos do Tipo engdo_mo, pegando todas as versões
select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, '' as data_reuniao,'' as localidade,'' as data_envio,'' as nome_remetente,'' as nome_destinatario,'' as sigla_fluido,'' as sigla_especificacao,'' as sequencial_linha, equipamento,'' as rc_referencia,'' as rp_referencia,'' as rt_referencia,'' as numero_contrato,'' as id_empresa_contratada 
from engdo_mo (all) 
where codigo_site = 'SS' 
order by i_chronicle_id, i_has_folder, r_creation_date

//Somente os documentos do Tipo engdo_ri, pegando todas as versões
select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, '' as data_reuniao,'' as localidade,'' as data_envio,'' as nome_remetente,'' as nome_destinatario,'' as sigla_fluido,'' as sigla_especificacao,'' as sequencial_linha,'' as equipamento,'' as rc_referencia,'' as rp_referencia,'' as rt_referencia, numero_contrato, id_empresa_contratada 
from engdo_ri (all) 
where codigo_site = 'SS' 
order by i_chronicle_id, i_has_folder, r_creation_date

//Somente os documentos do Tipo engdo_ar, pegando todas as versões
select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, data_reuniao, localidade,'' as data_envio,'' as nome_remetente,'' as nome_destinatario,'' as sigla_fluido,'' as sigla_especificacao,'' as sequencial_linha,'' as equipamento,'' as rc_referencia,'' as rp_referencia,'' as rt_referencia,'' as numero_contrato,'' as id_empresa_contratada 
from engdo_ar (all) 
where codigo_site = 'SS' 
order by i_chronicle_id, i_has_folder, r_creation_date


//Somente os documentos do Tipo engdo_ct, pegando todas as versões
select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, '' as data_reuniao,'' as localidade,'' as data_envio,'' as nome_remetente,'' as nome_destinatario,'' as sigla_fluido,'' as sigla_especificacao,'' as sequencial_linha, equipamento,'' as rc_referencia,'' as rp_referencia,'' as rt_referencia,'' as numero_contrato,'' as id_empresa_contratada 
from engdo_ct (all) 
where codigo_site = 'SS' 
order by i_chronicle_id, i_has_folder, r_creation_date

	
///////////////////////////////////////////////////engdo_anexo//////////////////////////////////////////////////////////////////////////////////////

select anexo.r_object_id, anexo.i_antecedent_id, anexo.i_chronicle_id, anexo.object_name, anexo.numero_vale_doc_principal, anexo.title, anexo.numero_referencia, anexo.revisao_doc_principal, anexo.a_content_type, eng.codigo_site, anexo.i_has_folder, anexo.r_creation_date
from engdo_anexo (all) anexo, engdo_documento_engenharia eng 
where  anexo.numero_vale_doc_principal = eng.numero_vale and eng.codigo_site = 'SS' 
order by anexo.i_chronicle_id, anexo.i_has_folder, anexo.r_creation_date


////////////////////////////////////////////////////////////////////////Processar GR///////////////////////////////////////////////////////////////////

select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, object_name, title, id_projeto, numero_vale, id_empresa_projeto, codigo_site, observacoes, tipo_gr, nome_destinatario, nome_remetente, nome_coordenador, data_emissao_gr, numero_contratada
from engdo_gr (all)
where codigo_site = 'SS' 
order by i_chronicle_id, i_has_folder, r_creation_date


select doc.r_object_id as id_gr , doc.numero_vale as numero_vale_gr, doc2.r_object_id as id_doc, doc2.numero_vale as numero_vale_doc
from engso_documento_gr (all) gr, engdo_gr (all) doc, engdo_documento_engenharia(all) doc2
where 
gr.id_guia_remessa = doc.r_object_id and 
doc.codigo_site = 'SS' and
gr.id_documento_engenharia = doc2.r_object_id 


CREATE dm_relation OBJECT
SET relation_name = 'D2_COPY_OF',
SET child_id = (SELECT r_object_id FROM vale_eng_package(all) WHERE legacy_uid = '09035f5181438c8f'),
SET parent_id = (SELECT r_object_id FROM vale_eng_document(all) WHERE vale_legacy_objectid = '09035f51813de9f5')



///////////////////////////////////////////////////////////SOMENTE SERÁ MIGRADO APÓS GOLIVE////////////////////////////////////////////////////////////////

//Somente os documentos do Tipo engdo_is, pegando todas as versões
select r_object_id,i_antecedent_id, i_chronicle_id, r_version_label, r_creation_date, i_has_folder, a_content_type, r_link_cnt, data_emissao_gr, situacao_aprovacao, se_finalizada, codigo_material, numero_gr_contratada, object_name, numero_vale, subject, title, r_object_type, codigo_site, fase, id_projeto, id_empresa_projeto, id_subarea, codigo_disciplina, r_is_virtual_doc, documento_fornecedor, numero_documento_base, area_funcional, revisao, sigla_idioma, numero_paginas, nome_formato,  sigla_finalidade_devolucao, id_tag, tag_antigo, numero_ld, localizacao_acervo, sigla_tipo_emissao, confidencial, numero_vale_antigo_r, observacoes, data_emissao_prevista, data_emissao_reprog, data_emissao_realiz, avanco_fisico, codigo_atividade, item_contrato, medicao, coringa, substituto, padronizado, livre, numero_contratada, '' as data_reuniao,'' as localidade,'' as data_envio,'' as nome_remetente,'' as nome_destinatario, sigla_fluido, sigla_especificacao, sequencial_linha,'' as equipamento,'' as rc_referencia,'' as rp_referencia,'' as rt_referencia,'' as numero_contrato,'' as id_empresa_contratada 
from engdo_is (all) 
where codigo_site = 'SS' 
order by i_chronicle_id, i_has_folder, r_creation_date