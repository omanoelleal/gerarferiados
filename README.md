# Procedure Gerar Feriados Brasil / RJ
Script SQL Server para geração de Tabela com os feriados do Brasil.

Primeiro passo é necessário criar a procedure com o código abaixo. 

[Acessar o Código](https://github.com/manoelleal17/gerarferiados/blob/main/SQL_GERAR_TBL_FERIADOS.sql)

A procedure está configurada para gerar os feriados de 1990 até 2099, caso deseje alterar o período é só alterar as variáveis:

````SQL
@Dt_Inicial datetime = '1990-01-01'

@Dt_Final datetime = '2099-12-31'
````

Depois de executar a procedure será criada a tabela: TBL_FERIADOS. No formato:

<p align="center"><img src="https://github.com/manoelleal17/gerarferiados/blob/main/Exemplo.png" ></p>



