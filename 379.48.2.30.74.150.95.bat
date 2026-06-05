:: Deleta tudo da pasta antes de iniciar uma nova geração
del C:\VERSOES_FECHADAS\379.48.2.30.74.150.95\*.* /q

:: Faz o checkout através de linhas de comando do SVN
svn checkout -q svn://srvprg1.citelsoftware.com.br/Padrao/027.18/27.18.379/379.48.02.REV.FECHADAs/379.48.02.30.FECHADAS/379.48.2.30.74.150.95 %WORKSPACE%

:: Executa CodeTrace e gera log na pasta LOCAL
SET "PASTA_CODETRACE=%WORKSPACE%\codetrace"
SET "EXE_CODETRACE=%PASTA_CODETRACE%\CodeTrace.exe"
SET "DPRFILE_ATUAL=%WORKSPACE%\padra_atualizado\autcom.dpr"
SET "PASTA_LOCAL=C:\VERSOES_FECHADAS\379.48.2.30.74.150.95"
SET "LOG_CODETRACE=%PASTA_LOCAL%\codetrace_resultado.txt"

IF NOT EXIST "%PASTA_LOCAL%" (
    mkdir "%PASTA_LOCAL%"
)

IF NOT EXIST "%EXE_CODETRACE%" (
    ECHO ERRO: CodeTrace.exe nao encontrado: "%EXE_CODETRACE%" > "%LOG_CODETRACE%"
    ECHO Data/Hora: %DATE% %TIME% >> "%LOG_CODETRACE%"
    GOTO END
)

IF NOT EXIST "%DPRFILE_ATUAL%" (
    ECHO ERRO: autcom.dpr nao encontrado: "%DPRFILE_ATUAL%" > "%LOG_CODETRACE%"
    ECHO Data/Hora: %DATE% %TIME% >> "%LOG_CODETRACE%"
    GOTO END
)

ECHO Executando CodeTrace...
ECHO CodeTrace.exe --dprfile="%DPRFILE_ATUAL%"

PUSHD "%PASTA_CODETRACE%"

CodeTrace.exe --dprfile="%DPRFILE_ATUAL%"

IF ERRORLEVEL 1 (
    SET "ERRO_CODETRACE=%ERRORLEVEL%"
    POPD

    ECHO ERRO: CodeTrace.exe retornou erro. > "%LOG_CODETRACE%"
    ECHO Codigo do erro: %ERRO_CODETRACE% >> "%LOG_CODETRACE%"
    ECHO Comando executado: CodeTrace.exe --dprfile="%DPRFILE_ATUAL%" >> "%LOG_CODETRACE%"
    ECHO Data/Hora: %DATE% %TIME% >> "%LOG_CODETRACE%"

    GOTO END
)

POPD

ECHO SUCESSO: CodeTrace.exe executado com sucesso. > "%LOG_CODETRACE%"
ECHO Comando executado: CodeTrace.exe --dprfile="%DPRFILE_ATUAL%" >> "%LOG_CODETRACE%"
ECHO DPR utilizado: "%DPRFILE_ATUAL%" >> "%LOG_CODETRACE%"
ECHO Data/Hora: %DATE% %TIME% >> "%LOG_CODETRACE%"

ECHO CodeTrace executado com sucesso.

CALL C:\Compilador\ddcc32NovoDX10.cmd Shared.Functions.dpk %WORKSPACE%\padra_atualizado\Packages\Shared\Functions\package\ %WORKSPACE%\padra_atualizado\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\Shared.Functions.bpl
copy /Y %WORKSPACE%\padra_atualizado\Shared.Functions.bpl C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd Login.View.dpk %WORKSPACE%\padra_atualizado\Packages\Login\View\package %WORKSPACE%\padra_atualizado\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\Login.View.bpl
copy /Y %WORKSPACE%\padra_atualizado\Login.View.bpl C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd Tintas.View.dpk %WORKSPACE%\padra_atualizado\Packages\Tintas\View\package %WORKSPACE%\padra_atualizado\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\Tintas.View.bpl
copy /Y %WORKSPACE%\padra_atualizado\Tintas.View.bpl C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd Autoatendimento.PagueFacil.View.dpk %WORKSPACE%\padra_atualizado\Packages\Autoatendimento\PagueFacil\View\package %WORKSPACE%\padra_atualizado\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\Autoatendimento.PagueFacil.View.bpl
copy /Y %WORKSPACE%\padra_atualizado\Autoatendimento.PagueFacil.View.bpl C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd Autoatendimento.ConsultaPreco.View.dpk %WORKSPACE%\padra_atualizado\Packages\Autoatendimento\ConsultaPreco\View\package\ %WORKSPACE%\padra_atualizado\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\Autoatendimento.ConsultaPreco.View.bpl
copy /Y %WORKSPACE%\padra_atualizado\Autoatendimento.ConsultaPreco.View.bpl C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd Principal.View.dpk %WORKSPACE%\padra_atualizado\Packages\Principal\View\package\ %WORKSPACE%\padra_atualizado\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\Principal.View.bpl
copy /Y %WORKSPACE%\padra_atualizado\Principal.View.bpl C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libDominioSistemas %WORKSPACE%\libDominioSistemas\ %WORKSPACE%\libDominioSistemas\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\libDominioSistemas.dll
copy /Y %WORKSPACE%\libDominioSistemas\libDominioSistemas.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libLayoutsFR3 %WORKSPACE%\padra_atualizado\fontes\Util_DLL\LayoutsFR3 %WORKSPACE%\padra_atualizado\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\libLayoutsFR3.dll
copy /Y %WORKSPACE%\padra_atualizado\libLayoutsFR3.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libCadastros %WORKSPACE%\padra_atualizado\fontes\cadastros\libCadastros %WORKSPACE%\padra_atualizado\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\libCadastros.dll
copy /Y %WORKSPACE%\padra_atualizado\libCadastros.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10Profile.cmd autcom %WORKSPACE%\padra_atualizado\ %WORKSPACE%\padra_atualizado\ "shared.functions;Login.View;Principal.View;Tintas.View;Autoatendimento.PagueFacil.View;Autoatendimento.ConsultaPreco.View"
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\autcom.exe
copy /Y %WORKSPACE%\padra_atualizado\autcom.exe C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd FatImpressao %WORKSPACE%\padra_atualizado\fontes\faturamento\FatImpressao\ %WORKSPACE%\padra_atualizado\ "shared.functions"
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\FatImpressao.exe
copy /Y %WORKSPACE%\padra_atualizado\FatImpressao.exe C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd EnviaEmailBoletoMonitor %WORKSPACE%\padra_atualizado\Monitors\EnviaEmailBoletoMonitor\ %WORKSPACE%\padra_atualizado\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\EnviaEmailBoletoMonitor.exe
copy /Y %WORKSPACE%\padra_atualizado\EnviaEmailBoletoMonitor.exe C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd ConsultaPitStop %WORKSPACE%\padra_atualizado\Monitors\MonitorPitStop\ %WORKSPACE%\padra_atualizado\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\ConsultaPitStop.exe
copy /Y %WORKSPACE%\padra_atualizado\ConsultaPitStop.exe C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libAutban %WORKSPACE%\autban\Autban_dll\ %WORKSPACE%\autban\Autban_dll\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\autban\Autban_dll\libAutban.dll
copy /Y %WORKSPACE%\autban\Autban_dll\libAutban.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libIntegracaoContasBancarias %WORKSPACE%\libIntegracaoContasBancarias\ %WORKSPACE%\libIntegracaoContasBancarias\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\libIntegracaoContasBancarias.dll
copy /Y %WORKSPACE%\libIntegracaoContasBancarias\libIntegracaoContasBancarias.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95


CALL C:\Compilador\ddcc32NovoDX10.cmd AutcomTinta %WORKSPACE%\AutcomTinta\ %WORKSPACE%\padra_atualizado\auttin
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\AutcomTinta.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\AutcomTinta.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libCorreios %WORKSPACE%\libCorreios\ %WORKSPACE%\libCorreios
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\libCorreios\libCorreios.dll
copy /Y %WORKSPACE%\libCorreios\libCorreios.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libAuttin %WORKSPACE%\auttin\Auttin %WORKSPACE%\auttin\Auttin
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\auttin\Auttin\libAuttin.dll
copy /Y %WORKSPACE%\auttin\Auttin\libAuttin.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libEditorEtiquetas %WORKSPACE%\padra_atualizado\fontes\util\EditorEtiquetas\ %WORKSPACE%\padra_atualizado\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\libEditorEtiquetas.dll
copy /Y %WORKSPACE%\padra_atualizado\libEditorEtiquetas.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd ConsultaPagamentosPixMonitor %WORKSPACE%\padra_atualizado\Monitors\ConsultaPagamentosPixMonitor\ %WORKSPACE%\padra_atualizado\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\ConsultaPagamentosPixMonitor.exe
copy /Y %WORKSPACE%\padra_atualizado\ConsultaPagamentosPixMonitor.exe C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libGNRE %WORKSPACE%\padra_atualizado\fontes\Util_DLL\Gnre %WORKSPACE%\padra_atualizado\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\libGNRE.dll
copy /Y %WORKSPACE%\padra_atualizado\libGNRE.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libImpExtEletronico %WORKSPACE%\libImpExtEletronico\ %WORKSPACE%\padra_atualizado\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\libImpExtEletronico.dll
copy /Y %WORKSPACE%\padra_atualizado\libImpExtEletronico.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libIntegracaoPixCitel %WORKSPACE%\libIntegracaoPixCitel\ %WORKSPACE%\padra_atualizado\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\libIntegracaoPixCitel.dll
copy /Y %WORKSPACE%\padra_atualizado\libIntegracaoPixCitel.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libNfe %WORKSPACE%\padra_atualizado\fontes\libNfe\Package\dxe4\ %WORKSPACE%\padra_atualizado\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\libNfe.dll
copy /Y %WORKSPACE%\padra_atualizado\libNfe.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libOpeRefProd %WORKSPACE%\padra_atualizado\fontes\Util_DLL\OpeRefProd\ %WORKSPACE%\padra_atualizado\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\libOpeRefProd.dll
copy /Y %WORKSPACE%\padra_atualizado\libOpeRefProd.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libPedidoDeCompra %WORKSPACE%\padra_atualizado\fontes\movimentacaoitens\PedidoDeCompra\ %WORKSPACE%\padra_atualizado\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\libPedidoDeCompra.dll
copy /Y %WORKSPACE%\padra_atualizado\libPedidoDeCompra.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTefCitel %WORKSPACE%\padra_atualizado\fontes\libTefCitel %WORKSPACE%\padra_atualizado\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\libTefCitel.dll
copy /Y %WORKSPACE%\padra_atualizado\libTefCitel.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd PainelNFe %WORKSPACE%\PainelNFe\Packages\dXE\ %WORKSPACE%\padra_atualizado\
IF NOT %ERRORLEVEL% == 0 GOTO END 
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\PainelNFe.exe
copy /Y %WORKSPACE%\padra_atualizado\PainelNFe.exe C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd NFeImpressao %WORKSPACE%\PainelNFe\PackagesNfeImpressao\dXE\ %WORKSPACE%\padra_atualizado\
IF NOT %ERRORLEVEL% == 0 GOTO END 
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\NFeImpressao.exe
copy /Y %WORKSPACE%\padra_atualizado\NFeImpressao.exe C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd NFeStatus %WORKSPACE%\PainelNFe\PackagesNFeStatus\dXE\ %WORKSPACE%\padra_atualizado\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\NFeStatus.exe
copy /Y %WORKSPACE%\padra_atualizado\NFeStatus.exe C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTransfCodigo %WORKSPACE%\padra_atualizado\fontes\Util_DLL\TransfCodigos\ %WORKSPACE%\padra_atualizado\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\libTransfCodigo.dll
copy /Y %WORKSPACE%\padra_atualizado\libTransfCodigo.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libFiscalCat42 %WORKSPACE%\padra_atualizado\fontes\fiscal\ %WORKSPACE%\padra_atualizado\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\libFiscalCat42.dll
copy /Y %WORKSPACE%\padra_atualizado\libFiscalCat42.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libReinf %WORKSPACE%\padra_atualizado\fontes\libReinf %WORKSPACE%\padra_atualizado\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\libReinf.dll
copy /Y %WORKSPACE%\padra_atualizado\libReinf.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95


CALL C:\Compilador\ddcc32NovoDX10.cmd libIntegracaoCartoes %WORKSPACE%\libIntegracaoCartoes\Package\dXe\ %WORKSPACE%\padra_atualizado\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\libIntegracaoCartoes.dll
copy /Y %WORKSPACE%\padra_atualizado\libIntegracaoCartoes.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libCartoesAutcom %WORKSPACE%\libCartoes\libCentralizado\ %WORKSPACE%\libCartoes\libCentralizado\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\libCartoesAutcom.dll
copy /Y %WORKSPACE%\libCartoes\libCentralizado\libCartoesAutcom.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libCartoesRedeCard %WORKSPACE%\libCartoes\libCartoesRedeCard\ %WORKSPACE%\libCartoes\libCartoesRedeCard\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\libCartoesRedeCard.dll
copy /Y %WORKSPACE%\libCartoes\libCartoesRedeCard\libCartoesRedeCard.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libCartoesSipag %WORKSPACE%\libCartoes\libCartoesSipag\ %WORKSPACE%\libCartoes\libCartoesSipag\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\libCartoesSipag.dll
copy /Y %WORKSPACE%\libCartoes\libCartoesSipag\libCartoesSipag.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libCartoesMercadoLivre %WORKSPACE%\libCartoes\libCartoesMercadoLivre\ %WORKSPACE%\libCartoes\libCartoesMercadoLivre\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\libCartoesMercadoLivre.dll
copy /Y %WORKSPACE%\libCartoes\libCartoesMercadoLivre\libCartoesMercadoLivre.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libCartoesPagSeguro %WORKSPACE%\libCartoes\libCartoesPagSeguro\ %WORKSPACE%\libCartoes\libCartoesPagSeguro\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\libCartoesPagSeguro.dll
copy /Y %WORKSPACE%\libCartoes\libCartoesPagSeguro\libCartoesPagSeguro.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libCartoesSafrapay %WORKSPACE%\libCartoes\libCartoesSafrapay\ %WORKSPACE%\libCartoes\libCartoesSafrapay\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\libCartoes\libCartoesSafrapay\libCartoesSafrapay.dll
copy /Y %WORKSPACE%\libCartoes\libCartoesSafrapay\libCartoesSafrapay.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libCartoesShopee %WORKSPACE%\libCartoes\libCartoesShopee\ %WORKSPACE%\libCartoes\libCartoesShopee\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\libCartoes\libCartoesShopee\libCartoesShopee.dll
copy /Y %WORKSPACE%\libCartoes\libCartoesShopee\libCartoesShopee.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libCartoesMobbuy %WORKSPACE%\libCartoes\libCartoesMobbuy\ %WORKSPACE%\libCartoes\libCartoesMobbuy\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\libCartoes\libCartoesMobbuy\libCartoesMobbuy.dll
copy /Y %WORKSPACE%\libCartoes\libCartoesMobbuy\libCartoesMobbuy.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libCartoesCielo %WORKSPACE%\libCartoes\libCartoesCielo\ %WORKSPACE%\libCartoes\libCartoesCielo\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\libCartoes\libCartoesCielo\libCartoesCielo.dll
copy /Y %WORKSPACE%\libCartoes\libCartoesCielo\libCartoesCielo.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libCartoesStone %WORKSPACE%\libCartoes\libCartoesStone\ %WORKSPACE%\libCartoes\libCartoesStone\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\libCartoes\libCartoesStone\libCartoesStone.dll
copy /Y %WORKSPACE%\libCartoes\libCartoesStone\libCartoesStone.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libCartoesMagazineLuiza %WORKSPACE%\libCartoes\libCartoesMagazineLuiza\ %WORKSPACE%\libCartoes\libCartoesMagazineLuiza\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\libCartoes\libCartoesMagazineLuiza\libCartoesMagazineLuiza.dll
copy /Y %WORKSPACE%\libCartoes\libCartoesMagazineLuiza\libCartoesMagazineLuiza.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libCartoesYapay %WORKSPACE%\libCartoes\libCartoesYapay\ %WORKSPACE%\libCartoes\libCartoesYapay\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\libCartoes\libCartoesYapay\libCartoesYapay.dll
copy /Y %WORKSPACE%\libCartoes\libCartoesYapay\libCartoesYapay.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libCartoesSicredi %WORKSPACE%\libCartoes\libCartoesSicredi\ %WORKSPACE%\libCartoes\libCartoesSicredi\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\libCartoes\libCartoesSicredi\libCartoesSicredi.dll
copy /Y %WORKSPACE%\libCartoes\libCartoesSicredi\libCartoesSicredi.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libCartoesGetnet %WORKSPACE%\libCartoes\libCartoesGetnet\ %WORKSPACE%\libCartoes\libCartoesGetnet\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\libCartoes\libCartoesGetnet\libCartoesGetnet.dll
copy /Y %WORKSPACE%\libCartoes\libCartoesGetnet\libCartoesGetnet.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libCartoesFiservBin %WORKSPACE%\libCartoes\libCartoesFiservBin\ %WORKSPACE%\libCartoes\libCartoesFiservBin\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\libCartoes\libCartoesFiservBin\libCartoesFiservBin.dll
copy /Y %WORKSPACE%\libCartoes\libCartoesFiservBin\libCartoesFiservBin.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libCartoesEquals %WORKSPACE%\libCartoes\libCartoesEquals\ %WORKSPACE%\libCartoes\libCartoesEquals\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\libCartoes\libCartoesEquals\libCartoesEquals.dll
copy /Y %WORKSPACE%\libCartoes\libCartoesEquals\libCartoesEquals.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libCartoesPagarMe %WORKSPACE%\libCartoes\libCartoesPagarMe\ %WORKSPACE%\libCartoes\libCartoesPagarMe\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\libCartoes\libCartoesPagarMe\libCartoesPagarMe.dll
copy /Y %WORKSPACE%\libCartoes\libCartoesPagarMe\libCartoesPagarMe.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libCartoesBanrisul %WORKSPACE%\libCartoes\libCartoesBanrisul\ %WORKSPACE%\libCartoes\libCartoesBanrisul\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\libCartoes\libCartoesBanrisul\libCartoesBanrisul.dll
copy /Y %WORKSPACE%\libCartoes\libCartoesBanrisul\libCartoesBanrisul.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libCartoesB2W %WORKSPACE%\libCartoes\libCartoesB2W\ %WORKSPACE%\libCartoes\libCartoesB2W\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\libCartoes\libCartoesB2W\libCartoesB2W.dll
copy /Y %WORKSPACE%\libCartoes\libCartoesB2W\libCartoesB2W.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libCartoesGranito %WORKSPACE%\libCartoes\libCartoesGranito\ %WORKSPACE%\libCartoes\libCartoesGranito\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\libCartoes\libCartoesGranito\libCartoesGranito.dll
copy /Y %WORKSPACE%\libCartoes\libCartoesGranito\libCartoesGranito.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libGatIme %WORKSPACE%\padra_atualizado\fontes\libGatIme\ %WORKSPACE%\padra_atualizado\
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\libGatIme.dll
copy /Y %WORKSPACE%\padra_atualizado\libGatIme.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95


:: DLL's DE TINTAS -----------------------------------------------------------------------------------------------------------------------
CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaAlvAutomotiva %WORKSPACE%\LibTintas\libTintaAlvAutomotiva\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaAlvAutomotiva.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaAlvAutomotiva.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaProfissionalAutomotiva %WORKSPACE%\LibTintas\libTintaProfissionalAutomotiva\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaProfissionalAutomotiva.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaProfissionalAutomotiva.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaNexa %WORKSPACE%\LibTintas\libTintaNexa\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaNexa.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaNexa.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaPpg %WORKSPACE%\LibTintas\libTintaPpg\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaPpg.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaPpg.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaPpgNexa %WORKSPACE%\LibTintas\libTintaPpgNexa\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaPpgNexa.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaPpgNexa.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaFarbenAutomotiva %WORKSPACE%\LibTintas\libTintaFarbenAutomotiva\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaFarbenAutomotiva.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaFarbenAutomotiva.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaSkyMixAutomotiva %WORKSPACE%\LibTintas\libTintaSkyMixAutomotiva\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaSkyMixAutomotiva.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaSkyMixAutomotiva.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaMaxVinil %WORKSPACE%\LibTintas\libTintaMaxVinil\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaMaxVinil.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaMaxVinil.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaMiniFabrica %WORKSPACE%\LibTintas\libTintaMiniFabrica\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaMiniFabrica.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaMiniFabrica.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaSherwinWilliams2 %WORKSPACE%\LibTintas\libTintaSherwinWilliams2\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaSherwinWilliams2.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaSherwinWilliams2.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaAdvance %WORKSPACE%\LibTintas\libTintaAdvance\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaAdvance.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaAdvance.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaAdvanceStr %WORKSPACE%\LibTintas\libTintaAdvanceStr\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaAdvanceStr.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaAdvanceStr.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaAdvanceTintoSystem %WORKSPACE%\LibTintas\libTintaAdvanceTintoSystem\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaAdvanceTintoSystem.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaAdvanceTintoSystem.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaAlessiImobiliaria %WORKSPACE%\LibTintas\libTintaAlessiImobiliaria\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaAlessiImobiliaria.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaAlessiImobiliaria.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaAlterPlus %WORKSPACE%\LibTintas\libTintaAlterPlus\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaAlterPlus.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaAlterPlus.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaAnjoAutomotiva %WORKSPACE%\LibTintas\libTintaAnjoAutomotiva\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaAnjoAutomotiva.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaAnjoAutomotiva.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaAnjoImobiliaria %WORKSPACE%\LibTintas\libTintaAnjoImobiliaria\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaAnjoImobiliaria.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaAnjoImobiliaria.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaAnjoSintetica %WORKSPACE%\LibTintas\libTintaAnjoSintetica\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaAnjoSintetica.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaAnjoSintetica.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaAnnetta %WORKSPACE%\LibTintas\libTintaAnnetta\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaAnnetta.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaAnnetta.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaAutoluks %WORKSPACE%\LibTintas\libTintaAutoluks\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaAutoluks.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaAutoluks.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaBautech %WORKSPACE%\LibTintas\libTintaBautech\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaBautech.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaBautech.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaBellaCor %WORKSPACE%\LibTintas\libTintaBellaCor\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaBellaCor.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaBellaCor.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaBrasimixAutomotiva %WORKSPACE%\LibTintas\libTintaBrasimixAutomotiva\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaBrasimixAutomotiva.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaBrasimixAutomotiva.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaBrasimixImobiliaria %WORKSPACE%\LibTintas\libTintaBrasimixImobiliaria\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaBrasimixImobiliaria.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaBrasimixImobiliaria.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaBrazilianColorAutomotiva %WORKSPACE%\LibTintas\libTintaBrazilianColorAutomotiva\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaBrazilianColorAutomotiva.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaBrazilianColorAutomotiva.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaBlascorAutomotiva %WORKSPACE%\LibTintas\libTintaBlascorAutomotiva\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaBlascorAutomotiva.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaBlascorAutomotiva.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaCalamar %WORKSPACE%\LibTintas\libTintaCalamar\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaCalamar.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaCalamar.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaCiacollor %WORKSPACE%\LibTintas\libTintaCiacollor\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaCiacollor.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaCiacollor.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaColorPro %WORKSPACE%\LibTintas\libTintaColorPro\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaColorPro.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaColorPro.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaColorbraz %WORKSPACE%\LibTintas\libTintaColorbraz\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaColorbraz.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaColorbraz.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaCoralImobiliaria %WORKSPACE%\LibTintas\libTintaCoralImobiliaria\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaCoralImobiliaria.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaCoralImobiliaria.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaDacar %WORKSPACE%\LibTintas\libTintaDacar\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaDacar.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaDacar.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaDupont %WORKSPACE%\LibTintas\libTintaDupont\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaDupont.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaDupont.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaDuxone %WORKSPACE%\LibTintas\libTintaDuxone\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaDuxone.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaDuxone.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaDuxone2 %WORKSPACE%\LibTintas\libTintaDuxone2\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaDuxone2.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaDuxone2.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaEucatexImobiliaria %WORKSPACE%\LibTintas\libTintaEucatexImobiliaria\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaEucatexImobiliaria.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaEucatexImobiliaria.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaFalcao %WORKSPACE%\LibTintas\libTintaFalcao\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaFalcao.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaFalcao.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaFutura %WORKSPACE%\LibTintas\libTintaFutura\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaFutura.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaFutura.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaGeneral %WORKSPACE%\LibTintas\libTintaGeneral\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaGeneral.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaGeneral.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaGlobalCc11 %WORKSPACE%\LibTintas\libTintaGlobalCc11\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaGlobalCc11.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaGlobalCc11.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaGlobalCcn13 %WORKSPACE%\LibTintas\libTintaGlobalCcn13\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaGlobalCcn13.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaGlobalCcn13.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaGlobalColor %WORKSPACE%\LibTintas\libTintaGlobalColor\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaGlobalColor.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaGlobalColor.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaGrafftex %WORKSPACE%\LibTintas\libTintaGrafftex\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaGrafftex.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaGrafftex.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaHydronorthImobiliaria %WORKSPACE%\LibTintas\libTintaHydronorthImobiliaria\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaHydronorthImobiliaria.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaHydronorthImobiliaria.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaInkor %WORKSPACE%\LibTintas\libTintaInkor\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaInkor.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaInkor.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaInternational %WORKSPACE%\LibTintas\libTintaInternational\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaInternational.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaInternational.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaIquine %WORKSPACE%\LibTintas\libTintaIquine %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaIquine.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaIquine.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaJotun %WORKSPACE%\LibTintas\libTintaJotun\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaJotun.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaJotun.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaKilling %WORKSPACE%\LibTintas\libTintaKilling\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaKilling.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaKilling.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaKillingIndustrial %WORKSPACE%\LibTintas\libTintaKillingIndustrial\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaKillingIndustrial.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaKillingIndustrial.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaKresil %WORKSPACE%\LibTintas\libTintaKresil\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaKresil.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaKresil.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaLazzumix %WORKSPACE%\LibTintas\libTintaLazzumix\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaLazzumix.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaLazzumix.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaLechler %WORKSPACE%\LibTintas\libTintaLechler\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaLechler.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaLechler.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaLechlerAutomotiva %WORKSPACE%\LibTintas\libTintaLechlerAutomotiva\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaLechlerAutomotiva.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaLechlerAutomotiva.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaLeinertex %WORKSPACE%\LibTintas\libTintaLeinertex\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaLeinertex.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaLeinertex.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaLiko %WORKSPACE%\LibTintas\libTintaLiko\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaLiko.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaLiko.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaLukscolor %WORKSPACE%\LibTintas\libTintaLukscolor\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaLukscolor.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaLukscolor.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaLukscolor2 %WORKSPACE%\LibTintas\libTintaLukscolor2\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaLukscolor2.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaLukscolor2.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaMazaAutomotiva %WORKSPACE%\LibTintas\libTintaMazaAutomotiva\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaMazaAutomotiva.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaMazaAutomotiva.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaMazaImobiliaria %WORKSPACE%\LibTintas\libTintaMazaImobiliaria\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaMazaImobiliaria.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaMazaImobiliaria.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaMazaIndustrial %WORKSPACE%\LibTintas\libTintaMazaIndustrial\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaMazaIndustrial.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaMazaIndustrial.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaMegaTintas %WORKSPACE%\LibTintas\libTintaMegaTintas\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaMegaTintas.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaMegaTintas.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaMontana %WORKSPACE%\LibTintas\libTintaMontana\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaMontana.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaMontana.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaQualyVinil %WORKSPACE%\LibTintas\libTintaQualyVinil\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaQualyVinil.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaQualyVinil.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaRecoa %WORKSPACE%\LibTintas\libTintaRecoa\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaRecoa.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaRecoa.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaRennerImobiliaria %WORKSPACE%\LibTintas\libTintaRennerImobiliaria\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaRennerImobiliaria.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaRennerImobiliaria.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaRennerIndustrial %WORKSPACE%\LibTintas\libTintaRennerIndustrial\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaRennerIndustrial.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaRennerIndustrial.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaRennerPerformance %WORKSPACE%\LibTintas\libTintaRennerPerformance\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaRennerPerformance.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaRennerPerformance.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaResicolor %WORKSPACE%\LibTintas\libTintaResicolor\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaResicolor.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaResicolor.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaResicolor2 %WORKSPACE%\LibTintas\libTintaResicolor2\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaResicolor2.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaResicolor2.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaRoberlo %WORKSPACE%\LibTintas\libTintaRoberlo\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaRoberlo.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaRoberlo.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaSayerlack %WORKSPACE%\LibTintas\libTintaSayerlack\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaSayerlack.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaSayerlack.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaSherwinWilliams %WORKSPACE%\LibTintas\libTintaSherwinWilliams\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaSherwinWilliams.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaSherwinWilliams.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaSinteplast %WORKSPACE%\LibTintas\libTintaSinteplast\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaSinteplast.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaSinteplast.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaSparlack %WORKSPACE%\LibTintas\libTintaSparlack\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaSparlack.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaSparlack.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaStandox %WORKSPACE%\LibTintas\libTintaStandox\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaStandox.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaStandox.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaStarmix %WORKSPACE%\LibTintas\libTintaStarmix\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaStarmix.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaStarmix.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaStarmixWeb %WORKSPACE%\LibTintas\libTintaStarmixWeb\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaStarmixWeb.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaStarmixWeb.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaSuvinil %WORKSPACE%\LibTintas\libTintaSuvinil\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaSuvinil.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaSuvinil.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaTexturaCia %WORKSPACE%\LibTintas\libTintaTexturaCia\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaTexturaCia.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaTexturaCia.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaTopCoat %WORKSPACE%\LibTintas\libTintaTopCoat\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaTopCoat.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaTopCoat.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaUniverso %WORKSPACE%\LibTintas\libTintaUniverso\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaUniverso.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaUniverso.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaVelutexImobiliaria %WORKSPACE%\LibTintas\libTintaVelutexImobiliaria\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaVelutexImobiliaria.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaVelutexImobiliaria.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaWeg %WORKSPACE%\LibTintas\libTintaWeg\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaWeg.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaWeg.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaBellaCorTintavel %WORKSPACE%\LibTintas\libTintaBellaCorTintavel\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaBellaCorTintavel.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaBellaCorTintavel.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaGlobalBc %WORKSPACE%\LibTintas\libTintaGlobalBc\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaGlobalBc.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaGlobalBc.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaGlobalBsn %WORKSPACE%\LibTintas\libTintaGlobalBsn\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaGlobalBsn.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaGlobalBsn.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaGlobalCsn %WORKSPACE%\LibTintas\libTintaGlobalCsn\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaGlobalCsn.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaGlobalCsn.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaChreon %WORKSPACE%\LibTintas\libTintaChreon\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaChreon.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaChreon.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaDacasa %WORKSPACE%\LibTintas\libTintaDacasa\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaDacasa.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaDacasa.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaProfissionalTintas %WORKSPACE%\LibTintas\libTintaProfissionalTintas\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaProfissionalTintas.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaProfissionalTintas.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaMaestria %WORKSPACE%\LibTintas\libTintaMaestria\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaMaestria.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaMaestria.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaLuztol %WORKSPACE%\LibTintas\libTintaLuztol\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaLuztol.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaLuztol.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaAnjoImobiliaria2 %WORKSPACE%\LibTintas\libTintaAnjoImobiliaria2\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaAnjoImobiliaria2.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaAnjoImobiliaria2.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaVerbras %WORKSPACE%\LibTintas\libTintaVerbras\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaVerbras.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaVerbras.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaParis %WORKSPACE%\LibTintas\libTintaParis\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaParis.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaParis.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95

CALL C:\Compilador\ddcc32NovoDX10.cmd libTintaAlv %WORKSPACE%\LibTintas\libTintaAlv\ %WORKSPACE%\padra_atualizado\auttin\tintas
IF NOT %ERRORLEVEL% == 0 GOTO END
C:\Compilador\madExceptPatch.exe %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaAlv.dll
copy /Y %WORKSPACE%\padra_atualizado\auttin\tintas\libTintaAlv.dll C:\VERSOES_FECHADAS\379.48.2.30.74.150.95


echo concluido > C:\VERSOES_FECHADAS\379.48.2.30.74.150.95\concluido.txt

:: Copia a pasta completa para a versão CLOUD
rd /s /q "C:\VERSOES_FECHADAS\379.48.2.30.74.150.95_CLOUD"
xcopy /E /I /Y "C:\VERSOES_FECHADAS\379.48.2.30.74.150.95" "C:\VERSOES_FECHADAS\379.48.2.30.74.150.95_CLOUD\"

:: Remove o arquivo de controle do build da versão CLOUD
del /q "C:\VERSOES_FECHADAS\379.48.2.30.74.150.95_CLOUD\concluido.txt"
del /q "C:\VERSOES_FECHADAS\379.48.2.30.74.150.95_CLOUD\codetrace_resultado.txt"
del /q "C:\VERSOES_FECHADAS\379.48.2.30.74.150.95\codetrace_resultado.txt"

:: Comenta o comando upx.exe e substitui todas as referencias a versao por _CLOUD nos .bat e .cmd
powershell -NoProfile -Command "if (Test-Path 'C:\VERSOES_FECHADAS\379.48.2.30.74.150.95_CLOUD\comandosCMD') { Get-ChildItem 'C:\VERSOES_FECHADAS\379.48.2.30.74.150.95_CLOUD\comandosCMD' | Where-Object { $_.Extension -eq '.bat' -or $_.Extension -eq '.cmd' } | ForEach-Object { $c = Get-Content $_.FullName; $c = $c.Replace('C:\Compilador\upx.exe', '::C:\Compilador\upx.exe'); $c = $c.Replace('379.48.2.30.74.150.95', '379.48.2.30.74.150.95_CLOUD'); Set-Content $_.FullName $c } }"


:: Executa configurações e inicia o sistema após compilação completa
CALL C:\VERSOES_FECHADAS\379.48.2.30.74.150.95\comandosCMD\__RodarPrimeiro.bat
schtasks /run /tn 379.48.2.30.74.150.95_Principal

:: Executa configurações e inicia o sistema da versão CLOUD
CALL C:\VERSOES_FECHADAS\379.48.2.30.74.150.95_CLOUD\comandosCMD\__RodarPrimeiro.bat
schtasks /run /tn 379.48.2.30.74.150.95_CLOUD_Principal

:END
@ECHO OFF
if not exist "C:\VERSOES_FECHADAS\379.48.2.30.74.150.95\concluido.txt" (
	java -jar "C:\Utilitarios\JenkinsJar\jenkins-cli.jar" -s http://localhost:8080/ console 379.48.2.30.74.150.95 -n 20 > C:\VERSOES_FECHADAS\379.48.2.30.74.150.95\erro.txt
	
	EXIT /b 1
)
