
<!-- README.md is generated from README.Rmd. Please edit that file -->

# olb

[![Travis build
status](https://travis-ci.org/meirelesff/olb.svg?branch=master)](https://travis-ci.org/meirelesff/olb)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

`olb` é um pacote em `R` usado para conectar-se à nova [API de Dados
Abertos](https://dadosabertos.camara.leg.br/) da [Câmara dos
Deputados](https://www.camara.leg.br/). Entre outros, o pacote contém
funções para extrair e limpar quaisquer tipos de informações sobre
proposições legislativas, atuação dos parlamentares, discursos e
votações nominais. Usando o sistema de IDs e eventos do serviço de
dados da Câmara, além disso, o `olb` é capaz de organizar milhares de
informações – emendas, requerimentos, relatorias, situações de
proposições – em bancos de dados apropriados para análise em segundos.

## Instalação

Para instalar o `olb`, basta executar o seguinte código no `R`:

``` r
if(!require(devtools)) install.packages("devtools")
devtools::install_github("iesp-uerj/olb")
```

## Usando

O `olb` foi planejado para extrair e limpar dados legislativos da Câmara
de forma simples e rápida. Por conta disso, qualquer pessoa com
conhecimentos básicos sobre `R` poderá usá-lo. Para um tutorial
detalhado explicando como o pacote funciona, ver o [Get
started](articles/olb.html) ou a [lista de
referência](reference/index.html) com todas as suas funcionalidades.

## Sobre

O `olb` é uma ferramenta desenvolvida no âmbito do [Observatório do
Legislativo Brasileiro (OLB)](http://olb.org.br/). Para saber mais sobre
o projeto, [clique aqui](http://olb.org.br/institucional/quem-somos/).
