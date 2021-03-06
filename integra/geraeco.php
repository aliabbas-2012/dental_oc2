<!DOCTYPE HTML>
<?php
/*
 * Esta página foi desenvolvida por Miwana Tecnologia da Informação Ltda.
 * www.miwana.com.br
 * miwana@miwana.com.br
 * 
 * Importa os dados do Arquivo SIDICOM no ECOMMERCE 
 */

include_once('chaveiro.php');

$reg300 = array();
$reg308cod = array();
$reg308sal = array();
$reg310cod = array();
$reg310psd = array();
$reg310pcd = array();

$quebralinha = "\r\n";

if (!isset($_GET["filename"])) {
    $_GET["filename"] = "";
};

$filename = $_GET["filename"];

if ($filename == "") {
    /* Busca pelo arquivo mais recente sem LOG */
    $pasta = './ecommerce/';

    if (is_dir($pasta)) {
        $diretorio = dir($pasta);

        while ($arquivo = $diretorio->read()) {
            if ($arquivo != '..' && $arquivo != '.') {
                #Cria um Arrquivo com todos os Arquivos encontrados
                $arrayArquivos[date("Y/m/d H:i:s", filemtime($pasta . $arquivo))] = $pasta . $arquivo;
            }
        }
        $diretorio->close();
    }

    #Classificar os arquivos para a Ordem Decrescente
    krsort($arrayArquivos, SORT_STRING);

    #Checa qual mais recente não tem LOG
    foreach ($arrayArquivos as $valorArquivos) {
        //echo '<a href='.$pasta.$valorArquivos.'>'.$valorArquivos.'</a><br />';
        /* procura arquivo de log */
        $logfilename = basename($valorArquivos, ".txt");
        $logfilename = "ecommerce/log/" . $logfilename . ".log";

        if (Is_Dir($valorArquivos) == FALSE) {
            if (file_exists($logfilename) == FALSE) {
                $filename = $valorArquivos;
                break;
            }
        }
    }
} else {
    $filename = 'ecommerce/' . $filename;
}

/* ABRE LOG  Com data de Início */
if (!isset($_GET["showlog"])) {
    $_GET["showlog"] = "";
}

$showlog = $_GET["showlog"];

$logfilename = basename($filename, ".txt");
$logfilename = "ecommerce/log/" . $logfilename . ".log";

$logfile = fopen($logfilename, 'a');

$linha = "0000;" . date('Y-m-d H:i:s') . ";" . basename($filename) . ";" . $quebralinha;
fwrite($logfile, $linha);

if (file_exists($filename)) {
    $lines = file($filename);
    foreach ($lines as $line_num => $line) {

        $pos = strpos($line, ';');
        $sub = substr($line, 0, $pos);

        if ($sub == '300') {
            $reg300[] = $line;
        }

        if ($sub == '308') {
            $campos = explode(";", $line);
            $reg308cod[] = $campos[3];
            $reg308sal[] = $campos[4];
        }

        if ($sub == '310') {
            $campos = explode(";", $line);
            $reg310cod[] = $campos[2];
            $reg310psd[] = $campos[4];
            $reg310pcd[] = $campos[6];
        }
    }
} else { /* Nenhum Arquivo encontrado - Escreve no Log */
    $linha = "000E;" . "Nenhum Arquivo Encontrado;" . $quebralinha;
    fwrite($logfile, $linha);
}


/* ATUALIZAR DADOS DOS PRODUTOS, PREÇOS E QUANTIDADES */
$count = count($reg300);
/* Escreve Log */
$linha = "300T;" . $count . ";" . $quebralinha;
fwrite($logfile, $linha);
$linha = "308T;" . count($reg308cod) . ";" . $quebralinha;
fwrite($logfile, $linha);
$linha = "310T;" . count($reg310cod) . ";" . $quebralinha;
fwrite($logfile, $linha);

$atualizados = 0;
$inseridos = 0;

for ($i = 0; $i < $count; $i++) {
    $linha = "";
    $campos = explode(";", $reg300[$i]);
    $prodcod = $campos[2];
    if ($campos[8] = 'A') {
        $prodsit = '1';
    }
    if ($campos[8] = 'I') {
        $prodsit = '0';
    }
    //$prodsit = $campos[8];
    $proddes = mysql_escape_string($campos[9]);  /* ida_product_description */
    $prodpbr = $campos[17];
    $prodpli = $campos[18]; /* weight_net */
    $prodlar = $campos[28];
    $prodcom = $campos[29];
    $prodalt = $campos[30];
    $prodcub = $campos[31]; /* cubage */
    $prodare = $campos[32]; /* square_meters */
    $prodgen = mysql_escape_string($campos[33]); /* ida_product_description */

    /* outros campos advindos necessários */
    $prodstk = 7;

    /* Busca Por Estoque do Produto e Soma */
    $keyvet = array_keys($reg308cod, $prodcod);
    $count2 = count($keyvet);
    for ($j = 0; $j < $count2; $j++) {
        $prodsal += $reg308sal[$keyvet[$j]];
    }
    /* Fim Busca Estoque */

    /* Busca Por Preço do Produto */
    $key = array_search($prodcod, $reg310cod);
    if ($key != FALSE) {
        $prodpsd = $reg310psd[$key];
        $prodpcd = $reg310pcd[$key];
    }
    /* Fim Busca Preço */

    /* Procura por Produto */
    $sql = "SELECT * FROM  " . $db_prefix . "product where product_id = $prodcod";
    $sql = mysqli_query($conexao, $sql);
    if (mysqli_num_rows($sql) > 0) {
        /* Realiza Update no Banco de Dados E-Commerce */
        echo $sql = "UPDATE " . $db_prefix . "product SET status = $prodsit, quantity = $prodsal, price = $prodpsd, date_modified = Now()"
        . " WHERE product_id = $prodcod";
        if ($sql = mysqli_query($conexao, $sql)) {
            echo "<br/>";
            echo "-------success----------";
            echo "<br/>";
        } else {
            echo "<br/>";
            echo "-------faeilure----------";
            echo "<br/>";
        }

        $atualizados++;
    } else {
        //get maximum id
        
        echo $sql_max = "SELECT MAX(product_id) as max_id FROM " . $db_prefix . "product";
        $res_max = mysqli_query($conexao,$sql_max);
        $_max = mysqli_fetch_array($res_max,MYSQLI_NUM);
        
        $product_cus_id = $_max[0]+1;
        /* Realiza Inserção no Banco de Dados */
        echo $sql = "INSERT INTO " . $db_prefix . "product (product_id, status, weight, weight_net, width, length, height, cubage, square_meters, quantity, price, date_added, stock_status_id, date_available)"
        . " VALUES($product_cus_id, $prodsit, $prodpbr, $prodpli, $prodlar, $prodcom, $prodalt, $prodcub, $prodare, $prodsal, $prodpsd, Now(), $prodstk, date(Now()))";

        if ($res = mysqli_query($conexao, $sql)) {
            echo "<br/>";
            echo "-------success----------";
            echo "<br/>";
        } else {
            echo "<br/>";
            echo "-------faeilure----------";
            echo "<br/>";
        }

        if (mysqli_affected_rows($conexao) > 0) {
            /* Insere o detalhamento */
   

            echo $sql = "INSERT INTO " . $db_prefix . "product_description (product_id, language_id, name, description, meta_description, meta_keyword, tag)"
            . " VALUES ($product_cus_id, 2, '$proddes', '$prodgen', '', '', '')";
            if ($sql = mysqli_query($conexao, $sql)) {

                echo "<br/>";
                echo "-------success----------";
                echo "<br/>";
            } else {
                echo "<br/>";
                echo "-------faeilure----------";
                echo "<br/>";
            }
            /* Insere no store */
            echo $sql = "INSERT INTO " . $db_prefix . "product_to_store (product_id, store_id) VALUES ($product_cus_id ,0)";
            if ($sql = mysqli_query($conexao, $sql)) {
                echo "<br/>";
                echo "-------success----------";
                echo "<br/>";
            } else {
                echo "<br/>";
                echo "-------faeilure----------";
                echo "<br/>";
            }
            $inseridos++;
        } else {
            $linha = "300E;" . $prodcod . ";" . $quebralinha;
            fwrite($logfile, $linha);
        }
    }
}

/* Finaliza Dados */
$linha = "999I" . $inseridos . ";" . $quebralinha;
fwrite($logfile, $linha);
$linha = "999U" . $atualizados . ";" . $quebralinha;
fwrite($logfile, $linha);

/* Finaliza Arquivo */
$linha = "9999;" . date('Y-m-d H:i:s') . ";" . basename($filename) . ";" . $quebralinha;
fclose($logfile);

/* Verificar se log vai ser exibido */
if ($showlog == "1") {
    $loglines = file($logfilename);
    foreach ($loglines as $logline_num => $logline) {
        echo $logline;
        echo "<br>";
    }
}
?>