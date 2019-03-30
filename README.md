
<!-- README.md is generated from README.Rmd. Please edit that file -->

# olb <img src="http://olb.org.br/wp-content/uploads/2018/08/cropped-OLB_SFmenor222222-1.png" align="right" alt="" width="120" />

[![Travis build
status](https://travis-ci.org/meirelesff/olb.svg?branch=master)](https://travis-ci.org/meirelesff/olb)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

`olb` é um pacote em `R` usado para conectar-se à nova [API de Dados
Abertos](https://dadosabertos.camara.leg.br/) da [Câmara dos
Deputados](https://www.camara.leg.br/). Entre outros, o pacote contém
funções para extrair e limpar quaisquer tipos de informações sobre
proposições legislativas, atuação dos parlamentares, discursos e
votações nominais.

## Instalação

Para instalar o `olb`, basta executar o seguinte código no `R`:

``` r
if(!require(devtools)) install.packages("devtools")
devtools::install_github("iesp-uerj/olb")
```

## Quem

O `olb` é uma ferramenta desenvolvida no âmbito do [Observatório do
Legislativo Brasileiro (OLB)](http://olb.org.br/). Para saber mais sobre
o projeto, [clique aqui](http://olb.org.br/institucional/quem-somos/).
